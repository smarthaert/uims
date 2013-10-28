unit U_javascript;

interface

type
  TJS=class(TObject)
  public
    function GetJQueryString:Ansistring;
  end;

implementation

{ TJS }

function TJS.GetJQueryString: Ansistring;
begin
begin
//http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js
 result:=
       '   var isScript = document.getElementById("JSyantInject");'+#13#10+
       '   if(isScript == null|| isScript == undefined)'+#13#10+
       '   {'+#13#10+
       '     var headID = document.getElementsByTagName("head")[0];'+#13#10+
       '     //add prototype150.js;'+#13#10+
       '     var newScript = document.createElement("script");'+#13#10+
       '     newScript.type = "text/javascript";'+#13#10+
       '     newScript.id="JSyantInject"; '+#13#10+
       '     newScript.src = "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js";'+#13#10+
       '     headID.appendChild(newScript);'+#13#10+
       '     alert(''Hello , I am Syant'');'+#13#10+
       '  }'+#13#10+
       '   else'+#13#10+
       '   { '+#13#10+
       '     //alert("已经将Jquery和Prototy注入到Baibu,无需重复注入!");'+#13#10+
       '   }';
end;
end;

end.
