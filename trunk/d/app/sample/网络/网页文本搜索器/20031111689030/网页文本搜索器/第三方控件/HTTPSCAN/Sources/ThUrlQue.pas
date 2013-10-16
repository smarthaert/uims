{(((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
(                              THttpScan v4.02                               )
(                       Copyright (c) 2001 Michel Fornengo                   )
(                             All rights reserved.                           )
(                                                                            )
( home page:     http://www.delphicity.com                                   )
( contacts:      contact@delphicity.com                                      )
( support:       support@delphicity.com                                      )
((((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
( Description: download queue manager                                        )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThUrlQue;

interface

Uses Classes;

type
    TGetAction = (HEAD_ONLY, STORE_TO_DATASTRING, STORE_TO_FILE, STORE_TO_DATASTRING_AND_FILE, STORE_OTHER);

    TUrlObject = class (TObject)
       DeepLevel : integer;
       Priority : boolean;
       CountArea : integer;
       HrefOrSrc : char;
       GetAction : TGetAction;
       CurrentRetryCount : integer;
       ReferringUrl : PChar;
       ReturnTag : integer;
    end;

    TUrlInQueue = class (TObject)

    public
       Queue : TStringList;
       constructor create ;
       destructor destroy; override;
       procedure Add (Tag : integer ; Url : string ; ReferringUrl : string ; Level : integer ; CurrentRetryCount : integer ; HrefOrSrc : char ; GetAction : TGetAction ; CountArea : integer ; Priority : boolean ; ReturnTag : integer);
       procedure Clear;
       procedure Delete (i : integer);
    end;

implementation

Uses SysUtils;

constructor TUrlInQueue.Create;
begin
   Queue := TStringList.Create;
   Queue.Capacity := 32000;
   Queue.Clear;
   Queue.Text := '';
end;

destructor TUrlInQueue.Destroy;
begin
   Queue.Free;
   inherited Destroy;
end;

procedure TUrlInQueue.Add (Tag : integer ; Url : string ; ReferringUrl : string ; Level : integer ; CurrentRetryCount : integer ; HrefOrSrc : char ; GetAction : TGetAction ; CountArea : integer ; Priority : boolean ; ReturnTag : integer);
var
   i : integer;
   Obj : TUrlObject;
begin
   Obj := TUrlObject.Create;
   Obj.Priority := Priority;
   Obj.DeepLevel := Level;
   Obj.CountArea := CountArea;
   Obj.CurrentRetryCount := CurrentRetryCount;
   Obj.HrefOrSrc := HRefOrSrc;
   Obj.GetAction := GetAction;
   Obj.ReturnTag := ReturnTag;
   GetMem (Obj.ReferringUrl, length (ReferringUrl) + 1);
   StrPCopy (Obj.ReferringUrl, ReferringUrl);
   i := Queue.Add (Url);
   Queue.Objects[i] := Obj;
end;

procedure TUrlInQueue.Clear;
begin
   while Queue.Count > 0 do begin
      Delete (0);
   end;
end;

procedure TUrlInQueue.Delete (i : integer);
var
   UrlObject : TUrlObject;
begin
   UrlObject := TUrlObject (Queue.Objects[i]);
   if assigned (UrlObject) then begin
      FreeMem (UrlObject.ReferringUrl);
      UrlObject.free;
      Queue.Objects[i] := nil;
   end;
   Queue.Delete (i);
end;

end.
