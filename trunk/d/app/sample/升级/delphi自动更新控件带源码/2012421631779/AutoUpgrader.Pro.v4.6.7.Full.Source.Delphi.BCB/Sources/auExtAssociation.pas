{*******************************************************************************

  AutoUpgrader Professional
  FILE: auExtAssociation.pas - ExtAssociation component.

  Copyright (c) 1998-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

*******************************************************************************}

unit auExtAssociation;

interface

uses
  Windows, Classes, Controls, Graphics;

type
  TauShellExtAccessMode = (amReadOnly, amReadWrite);
  TauExtAssociation = class(TComponent)
  private
    FAccessMode: TauShellExtAccessMode;
    FExtension: String;
    FExecutableFile: String;
    FExtDescription: String;
    FFileDescription: String;
    FParamString: String;

    FIconFile: String;
    FIconIndex: Integer;
    FLargeIcon: TIcon;
    FSmallIcon: TIcon;

    procedure SetExtension(Value: String);
    procedure SetExecutableFile(Value: String);
    procedure SetExtDescription(Value: String);
    procedure SetFileDescription(Value: String);
    procedure SetParamString(Value: String);
    procedure SetIconFile(Value: String);
    procedure SetIconIndex(Value: Integer);
    procedure SetIcon(Value: TIcon);

    function  CheckAccessMode: Boolean;
    procedure GetExtensionInfo;
    procedure DoInstallExtension;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function InstallExtension(Extension, ExecutableFile, ParamString,
                              ExtDescription, FileDescription,
                              IconFile: String; IconIndex: Integer): Boolean;
    function UninstallExtension(Ext: String): Boolean;
  published
    property AccessMode: TauShellExtAccessMode read FAccessMode write FAccessMode;
    property EXTENSION: String read FExtension write SetExtension;
    property ExecutableFile: String read FExecutableFile write SetExecutableFile;
    property ExtDescription: String read FExtDescription write SetExtDescription;
    property FileDescription: String read FFileDescription write SetFileDescription;
    property ParamString: String read FParamString write SetParamString;

    property IconFile: String read FIconFile write SetIconFile;
    property IconIndex: Integer read FIconIndex write SetIconIndex;
    property LargeIcon: TIcon read FLargeIcon write SetIcon;
    property SmallIcon: TIcon read FSmallIcon write SetIcon;
  end;

implementation

uses Forms, SysUtils, Registry, ShellAPI, ShlObj, auUtils;

constructor TauExtAssociation.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FLargeIcon := TIcon.Create;
  FSmallIcon := TIcon.Create;
end;

destructor TauExtAssociation.Destroy;
begin
  FSmallIcon.Destroy;
  FLargeIcon.Destroy;
  inherited Destroy;
end;


procedure TauExtAssociation.GetExtensionInfo;
var
  I: Integer;
  LIcon, SIcon: hIcon;
  St: String;
  StrList: TStringList;

  procedure GetShell32Icons(IconIndex: Integer; var LargeIcon, SmallIcon: TIcon);
  begin
    ExtractIconEx(PChar(GetSystemDir + 'SHELL32.DLL'),
                  IconIndex, LIcon, SIcon, 1);
    FLargeIcon.Handle := LIcon;
    FSmallIcon.Handle := SIcon;
  end;

  procedure GetDefaultIcons(var LargeIcon, SmallIcon: TIcon);
  begin
    GetShell32Icons(0, LargeIcon, SmallIcon);
  end;

begin
  { clearing all properties }
  FExecutableFile := '';
  FExtDescription := '';
  FFileDescription := '';
  FParamString := '';
  FIconFile := '';
  FIconIndex := 0;
  FLargeIcon.Assign(nil);
  FSmallIcon.Assign(nil);

  if (FEXTENSION = '') or (FEXTENSION = '.') then Exit;

  with TRegistry.Create do
   try
     try
       { open key in HKCR where stored info about needed extension }
       RootKey := HKEY_CLASSES_ROOT;
       OpenKey(FExtension, False);
       { reading the description key }
       FExtDescription := ReadString('');

       { if there is not description for specified extension
         then reading default MS icon and exiting }
       if (FExtDescription = '') or
          not OpenKey('\' + FExtDescription, False) then
        begin
         GetDefaultIcons(FLargeIcon, FSmallIcon);

         { if ExtDescription still not specified and we'd like to
           install an extension }
         if AccessMode = amReadWrite then
          begin
           FExtDescription := FEXTENSION + 'file';
           if FExtDescription[1] = '.' then
             Delete(FExtDescription, 1, 1);
           FParamString := '%1';
          end;
         Exit;
        end;

       FFileDescription := ReadString('');  { reading the file description (ie: .pas = "Delphi Unit" ) }

       { reading the icons (large and small) }
       if OpenKey('DefaultIcon', False) then
        begin
         FIconFile := ReadString('');

         if FIconFile <> '' then { if icon file exists }
          begin
           SplitStr(',', FIconFile, FIconFile, St, LEFT, []);
           { getting the icon index }
           FIconIndex := StrToIntDef(St, 0);
           I := ExtractIconEx(PChar(FIconFile), FIconIndex, LIcon, SIcon, 1);
           if (I = 0) or (I = -1) then
            { if icon can not be read then opening the shell32 icon }
            try
              if LowerCase(FExtension) = '.exe' then I := 2
              else I := 0;
              GetShell32Icons(I, FLargeIcon, FSmallIcon);
            except
            end
           else
            begin
             FLargeIcon.Handle := LIcon;
             FSmallIcon.Handle := SIcon;
            end;
          end;
        end;

       { reading the info about executable }
       if OpenKey('\' + FExtDescription + '\shell\open\command', False) then
         FExecutableFile := ReadString('')
       else
        if OpenKey('\' + FExtDescription + '\shell\', False) then
         begin { trying to find executable }
          StrList := TStringList.Create;
          try
            GetKeyNames(StrList);
            I := StrList.Count;
            if I <> 0 then
             begin
              St := '';
              for I := I - 1 downto 0 do
               if Pos('open', LowerCase(StrList[I])) <> 0 then
                St := StrList[I];
                
              if St <> '' then
               if OpenKey('\' + FExtDescription + '\shell\' + St + '\command', False) then
                 FExecutableFile := ReadString('');

              { if executable still not found then returning *any* way of opening this extension }
              if St = '' then
               for I := 0 to StrList.Count - 1 do
                if FExecutableFile = '' then              
                 if OpenKey('\' + FExtDescription + '\shell\' + StrList[I] + '\command', False) then
                  FExecutableFile := ReadString('');
             end;
          except
          end;
          StrList.Free;
         end;
       SplitFileNameAndParams(FExecutableFile, FParamString);

       if FIconFile = '' then
        begin
        { if we still haven't icon then trying to
          read this from the executable.
          This thing happends with Corel Photo-paint extensions (gif/jpg etc) }
         FIconFile := FExecutableFile;
         SplitStr(',', FIconFile, FIconFile, St, LEFT, []);
         FIconIndex := StrToIntDef(St, 0);
         ExtractIconEx(PChar(FIconFile), FIconIndex, LIcon, SIcon, 1);
         FLargeIcon.Handle := LIcon;
         FSmallIcon.Handle := SIcon;
        end;
     except
     end;
   finally
     Free;
   end;
end;

procedure TauExtAssociation.DoInstallExtension;
begin
  InstallExtension(FExtension, FExecutableFile, FParamString, FExtDescription, FFileDescription, FIconFile, FIconIndex);
end;

function TauExtAssociation.InstallExtension(Extension, ExecutableFile, ParamString,
                                ExtDescription, FileDescription,
                                IconFile: String; IconIndex: Integer): Boolean;
begin
  Result := False;
  if (Extension = '') or (csLoading in ComponentState) then Exit;
  if ExtDescription = '' then ExtDescription := Extension + 'file';
  if (Extension <> '') and (Extension[1] <> '.') then Insert('.', Extension, 1);

  with TRegistry.Create do
   try
     try
       Result := True;
       RootKey := HKEY_CLASSES_ROOT;
       Result := OpenKey(Extension, True);
       if Result then
        begin
         WriteString('', ExtDescription);
         Result := OpenKey('\' + ExtDescription, True);
         if Result then
          begin
           WriteString('', FileDescription);
           Result := OpenKey('DefaultIcon', True);
           if Result then
            begin
             if IconFile = '' then IconFile := ExecutableFile;
             WriteString('', IconFile + ',' + IntToStr(IconIndex));
             Result := OpenKey('\' + ExtDescription + '\shell\open\command', True);
             if Result then
              begin
               if ParamString <> '' then
                 ExecutableFile := '"' + ExecutableFile + '" "' + ParamString + '"';
               WriteString('', ExecutableFile);
              end;
            end;
          end;
        end;  
     except
       Result := False;
     end;
   finally
     Free;
   end;
end;

function TauExtAssociation.UninstallExtension(Ext: String): Boolean;
var
  Description: String;
begin
  if Ext[1] <> '.' then
    Insert('.', Ext, 1);

  with TRegistry.Create do
   try
     try
       RootKey := HKEY_CLASSES_ROOT;
       OpenKey(Ext, False);
       { reading the description key }
       Description := ReadString('');
       CloseKey;
       DeleteKey(Ext);
       DeleteKey('\' + Description);
       Result := True;

       { notifying shell about changes }
       SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
     except
       Result := False;
     end;
   finally
     Free;
   end;

  GetExtensionInfo;
end;

procedure TauExtAssociation.SetExtension(Value: String);
begin
  if FExtension <> Value then
   begin
    FExtension := Value;
    if (FExtension <> '') and (FExtension[1] <> '.') then
     Insert('.', FExtension, 1);

    GetExtensionInfo;
   end;
end;


function TauExtAssociation.CheckAccessMode: Boolean;
begin
  Result := AccessMode = amReadWrite;

  if not Result and (csDesigning in ComponentState) and
     not (csReading in ComponentState) then
   Application.MessageBox('Cannot write this property in Read-Only access mode.', PChar(Name + ': Design-time tip'), mb_Ok or mb_IconWarning);
end;

procedure TauExtAssociation.SetExecutableFile(Value: String);
begin
  if (FExecutableFile <> Value) and CheckAccessMode then
   begin
    FExecutableFile := Value;
    DoInstallExtension;
    GetExtensionInfo;
   end;
end;

procedure TauExtAssociation.SetExtDescription(Value: String);
begin
  if (FExtDescription <> Value) and CheckAccessMode then
   begin
    FExtDescription := Value;
    DoInstallExtension;
   end;
end;

procedure TauExtAssociation.SetFileDescription(Value: String);
begin
  if (FFileDescription <> Value) and CheckAccessMode then
   begin
    FFileDescription := Value;
    DoInstallExtension;
   end;
end;

procedure TauExtAssociation.SetParamString(Value: String);
begin
  if (FParamString <> Value) and CheckAccessMode then
   begin
    FParamString := Value;
    DoInstallExtension;
   end;
end;

procedure TauExtAssociation.SetIconFile(Value: String);
begin
  if (FIconFile <> Value) and CheckAccessMode then
   begin
    FIconFile := Value;
    DoInstallExtension;
    GetExtensionInfo;
   end;
end;

procedure TauExtAssociation.SetIconIndex(Value: Integer);
begin
  if (FIconIndex <> Value) and CheckAccessMode then
   begin
    FIconIndex := Value;
    DoInstallExtension;
    GetExtensionInfo;
   end;
end;

procedure TauExtAssociation.SetIcon(Value: TIcon);
begin
end;

end.