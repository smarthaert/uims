{*******************************************************************************

  AutoUpgrader Professional
  FILE: _AUReg.pas - Components and property editor registration within the IDE.

  Copyright (c) 1999-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

  Restrictions

  The source code contained within this file and all related files or any
portion of its contents shall at no time be copied, transferred, sold,
distributed, or otherwise made available to other individuals without express
             written consent and permission from the UtilMind Solutions.

  Consult the End User License Agreement (EULA) for information on additional
restrictions.

*******************************************************************************}
{$I auDefines.inc}

unit _AUReg;

interface

procedure Register;

implementation

uses Windows, Classes, Controls, Forms, Dialogs,
{$IFDEF D6}
     DesignIntf, DesignEditors,
{$ELSE}
     DsgnIntf,
{$ENDIF}
     auAutoUpgrader, auHTTP, auThread, auExtAssociation,
     auAutoUpgraderEditor, auHTTPProxyEditor;

type
{*******************************************************************************
  Proxy structure PROPERTY editor for auCustomHTTP
*******************************************************************************}
 { TauHTTPProxyProperty }
  TauHTTPProxyProperty = class(TClassProperty)
  public
    function GetValue: String; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{*******************************************************************************
  VersionInfo/Upgrade Message PROPERTY editor for AugoUpgrader
*******************************************************************************}
 { TauAutoUpgraderProperty }
  TauAutoUpgraderProperty = class(TClassProperty)
  public
    function GetValue: String; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{*******************************************************************************
  VersionInfo/Upgrade Message COMPONENT editor for AugoUpgrader
*******************************************************************************}
 { TauAutoUpgraderCompEditor }
  TauAutoUpgraderCompEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): String; override;
  end;


{ TauHTTPProxyProperty Editor }
function TauHTTPProxyProperty.GetValue: String;
begin
  Result := '(Proxy settings)';
end;

function TauHTTPProxyProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog];
end;

procedure TauHTTPProxyProperty.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
{$IFDEF AUTOUPGRADERPROXY}
  if Component is TauAutoUpgrader then
    ShowHTTPProxyDesigner(Designer, TauAutoUpgrader(Component).Proxy)
  else
{$ENDIF}
    ShowHTTPProxyDesigner(Designer, TauCustomHTTP(Component).Proxy)
end;


{ TauAutoUpgraderProperty Editor }
function TauAutoUpgraderProperty.GetValue: String;
begin
  Result := '(Upgrade Info)';
end;

function TauAutoUpgraderProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog];
end;

procedure TauAutoUpgraderProperty.Edit;
begin
  ShowAutoUpgraderDesigner(Designer, TauAutoUpgrader(GetComponent(0)));
end;


{ TauAutoUpgraderCompEditor }
procedure TauAutoUpgraderCompEditor.ExecuteVerb(Index: Integer);
begin
  if Index = GetVerbCount - 1 then
    ShowAutoUpgraderDesigner(Designer, TauAutoUpgrader(Component))
  else inherited ExecuteVerb(Index);
end;

function TauAutoUpgraderCompEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;

function TauAutoUpgraderCompEditor.GetVerb(Index: Integer): String;
begin
  if Index = GetVerbCount - 1 then
    Result := '&Edit Info-file...'
  else
    Result := inherited GetVerb(Index);
end;

procedure Register;
begin
  RegisterComponents('UtilMind', [TauAutoUpgrader, TauHTTP, TauThread {, TauExtAssociation}]);

  RegisterComponentEditor(TauAutoUpgrader, TauAutoUpgraderCompEditor);

  RegisterPropertyEditor(TypeInfo(TauHTTPProxy), TauCustomHTTP, 'Proxy', TauHTTPProxyProperty);
{$IFDEF AUTOUPGRADERPROXY}
  RegisterPropertyEditor(TypeInfo(TauHTTPProxy), TauAutoUpgrader, 'Proxy', TauHTTPProxyProperty);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(TauAutoUpgraderInfo), TauAutoUpgrader, 'InfoFile', TauAutoUpgraderProperty);
end;

end.
