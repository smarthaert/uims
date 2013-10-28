unit XmlIniConvert;

interface

  uses SysUtils,Classes,XmlIni,IniFiles;

  function XmlToini(const XmlFile,IniFile:String):Boolean;
  function IniToXml(Const IniFile,XmlFile:String):Boolean;
  
implementation

function XmlToini(const XmlFile,IniFile:String):Boolean;
var
  i,j:integer;
  xml:TxmlIni;
  ini:Tinifile;
  SectionList:Tstringlist;
  KeyList:Tstringlist;
begin
  Result:=false;
  if FileExists(Xmlfile) then
   begin
      xml:=Txmlini.Create(xmlFile);
      ini:=Tinifile.Create(IniFile);
      Sectionlist:=Tstringlist.Create;
      KeyList:=Tstringlist.Create;
      try
         xml.ReadSections(SectionList);
         if SectionList.Count > 0 then
         for i:=0 to SectionList.Count -1 do
           begin
              xml.ReadSection(sectionlist[i],Keylist);
              if Keylist.Count > 0 then
              for j:=0 to Keylist.Count -1 do
                   ini.WriteString(sectionlist[i],keylist[j],xml.ReadString(sectionlist[i],Keylist[j],''));
           end;
           Result:=true;
      finally
        xml.Free;
        ini.Free;
        Sectionlist.Free;
        Keylist.Free;
      end;
   end;
end;

function IniToXml(Const IniFile,XmlFile:String):Boolean;
var
  i,j:integer;
  xml:TxmlIni;
  ini:Tinifile;
  SectionList:Tstringlist;
  KeyList:Tstringlist;
begin
  Result:=false;
  if FileExists(IniFile) then
   begin
      xml:=Txmlini.Create(xmlFile);
      ini:=Tinifile.Create(IniFile);
      Sectionlist:=Tstringlist.Create;
      KeyList:=Tstringlist.Create;
      try
         ini.ReadSections(SectionList);
         if SectionList.Count > 0 then
         for i:=0 to SectionList.Count -1 do
           begin
              ini.ReadSection(sectionlist[i],Keylist);
              if Keylist.Count > 0 then
              for j:=0 to Keylist.Count -1 do
                   xml.WriteString(sectionlist[i],keylist[j],ini.ReadString(sectionlist[i],Keylist[j],''));
           end;
           Result:=true;
      finally
        xml.Free;
        ini.Free;
        Sectionlist.Free;
        Keylist.Free;
      end;
   end;
end;

end.
