unit U_UserConfig;

interface

Type
  TUserConfig = Class

  private
    FDown_AllowActivex: Boolean;
    FDown_AllowImage: Boolean;
    FDown_AllowJava: Boolean;
    FDown_AllowBkSound: Boolean;
    FDown_AllowVideo: Boolean;
    FDown_AllowScript: Boolean;
    procedure SetDown_AllowActivex(const Value: Boolean);
    procedure SetDown_AllowImage(const Value: Boolean);
    procedure SetDown_AllowJava(const Value: Boolean);
    procedure SetDown_AllowBkSound(const Value: Boolean);
    procedure SetDown_AllowVideo(const Value: Boolean);
    procedure SetDown_AllowScript(const Value: Boolean);
  public
    constructor Create;
    property Down_AllowActivex: Boolean read FDown_AllowActivex write
        SetDown_AllowActivex;
    property Down_AllowImage: Boolean read FDown_AllowImage write
        SetDown_AllowImage;
    property Down_AllowJava: Boolean read FDown_AllowJava write SetDown_AllowJava;
    property Down_AllowBkSound: Boolean read FDown_AllowBkSound write
        SetDown_AllowBkSound;
    property Down_AllowVideo: Boolean read FDown_AllowVideo write
        SetDown_AllowVideo;
    property Down_AllowScript: Boolean read FDown_AllowScript write
        SetDown_AllowScript;
  End;

Var
  UserConfig: TUserConfig;

implementation

constructor TUserConfig.Create;
begin
  inherited;
  FDown_AllowActivex := True;
  FDown_AllowImage := True;
  FDown_AllowJava := True;
  FDown_AllowVideo := True;
  FDown_AllowScript := True;
  FDown_AllowBkSound := True;
end;

procedure TUserConfig.SetDown_AllowActivex(const Value: Boolean);
begin
  if FDown_AllowActivex <> Value then
  begin
    FDown_AllowActivex := Value;
  end;
end;

procedure TUserConfig.SetDown_AllowImage(const Value: Boolean);
begin
  if FDown_AllowImage <> Value then
  begin
    FDown_AllowImage := Value;
  end;
end;

procedure TUserConfig.SetDown_AllowJava(const Value: Boolean);
begin
  if FDown_AllowJava <> Value then
  begin
    FDown_AllowJava := Value;
  end;
end;

procedure TUserConfig.SetDown_AllowBkSound(const Value: Boolean);
begin
  if FDown_AllowJava <> Value then
  begin
    FDown_AllowJava := Value;
  end;
end;

procedure TUserConfig.SetDown_AllowVideo(const Value: Boolean);
begin
  if FDown_AllowJava <> Value then
  begin
    FDown_AllowJava := Value;
  end;
end;

procedure TUserConfig.SetDown_AllowScript(const Value: Boolean);
begin
  if FDown_AllowJava <> Value then
  begin
    FDown_AllowJava := Value;
  end;
end;

initialization
  UserConfig := TUserConfig.Create;
finalization
  UserConfig.Free;


end.
