unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Button3: TButton;
    Button4: TButton;
    Edit4: TEdit;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
     i:integer;
     s,M,H:string;
  begin
    //arycount:=0;
    s:=Edit1.text;
    Edit2.text:='';
    Edit3.text:='';
    Edit4.text:='';
    if length(s)<=0   then
    begin
      messagedlg('字符长度不能小于0',mterror,[mbok],0);
      exit;
    end;
    //H:='';
    for   i:=1  to  length(s)   do
    begin
      M:=uppercase(copy(s,i,1));
       if M='A' then
      H:='*-';
      if M='B' then
      H:='-***';
      if M='C' then
      H:='-*-*';
      if M='D' then
      H:='-**';
      if M='E' then
      H:='*';
      if M='F' then
      H:='**-*';
      if M='G' then
      H:='--*';
      if M='H' then
      H:='****';
      if M='I' then
      H:='**';
      if M='J' then
      H:='*---';
      if M='K' then
      H:='-*-';
      if M='L' then
      H:='*-**';
      if M='M' then
      H:='--';
      if M='N' then
      H:='-*';
      if M='O' then
      H:='---';
      if M='P' then
      H:='*--*';
      if M='Q' then
      H:='--*-';
      if M='R' then
      H:='*-*';
      if M='S' then
      H:='***';
      if M='T' then
      H:='-';
      if M='U' then
      H:='**-';
      if M='V' then
      H:='***-';
      if M='W' then
      H:='*--';
      if M='X' then
      H:='-**-';
      if M='Y' then
      H:='-*--';
      if M='Z' then
      H:='--**';
      if M='1' then
      H:='*----';
      if M='2' then
      H:='**---';
      if M='3' then
      H:='***--';
      if M='4' then
      H:='****-';
      if M='5' then
      H:='*****';
      if M='6' then
      H:='-****';
      if M='7' then
      H:='--***';
      if M='8' then
      H:='---**';
      if M='9' then
      H:='----*';
      if M='0' then
      H:='-----';

      Edit4.Text:=Edit4.Text+' '+H;
      end;
    end;

procedure TForm1.Button2Click(Sender: TObject);
var
   I,N,B:INTEGER;
    str :WideString;
    C,L,A,K,M,S,str1,str2,F,str3,str4,str5,str6,str7:String;
  begin
    Edit1.text:='';
    Edit2.text:='';
    Edit3.text:='';
    str:=Edit4.Text+' ';
    str1:=str;
    while POS(' ',str1) > 0 do
    begin
      str2:=Copy(str1,1,POS(' ',str1));
      str3:=Copy(str2,1,POS(' ',str2)-1);
      if str3='*-' Then
      F:='A';
      if str3='-***' Then
      F:='B';
      if str3='-*-*' Then
      F:='C';
      if str3='-**' Then
      F:='D';
      if str3='*' Then
      F:='E';
      if str3='**-*' Then
      F:='F';
      if str3='--*' Then
      F:='G';
      if str3='****' Then
      F:='H';
      if str3='**' Then
      F:='I';
      if str3='*---' Then
      F:='J';
      if str3='-*-' Then
      F:='K';
      if str3='*-**' Then
      F:='L';
      if str3='--' Then
      F:='M';
      if str3='-*' Then
      F:='N';
      if str3='---' Then
      F:='O';
      if str3='*--*' Then
      F:='P';
      if str3='--*-' Then
      F:='Q';
      if str3='*-*' Then
      F:='R';
      if str3='***' Then
      F:='S';
      if str3='-' Then
      F:='T';
      if str3='**-' Then
      F:='U';
      if str3='***-' Then
      F:='V';
      if str3='*--' Then
      F:='W';
      if str3='-**-' Then
      F:='X';
      if str3='-*--' Then
      F:='Y';
      if str3='--**' Then
      F:='Z';
      if str3='*----' Then
      F:='1';
      if str3='**---' Then
      F:='2';
      if str3='***--' Then
      F:='3';
      if str3='****-' Then
      F:='4';
      if str3='*****' Then
      F:='5';
      if str3='-****' Then
      F:='6';
      if str3='--***' Then
      F:='7';
      if str3='---**' Then
      F:='8';
      if str3='----*' Then
      F:='9';
      if str3='-----' Then
      F:='0';
      str1:=Copy(str1,POS(' ',str1)+1,Length(str1));
      Edit3.Text:=Edit3.Text+F;
    end;

     edit2.text:='';
    str4:=Edit3.Text;
   Str1:=' '+str4;
  for  i:=1  to  length(Str1)   do
  begin
  Str5:=copy(Str1,i+1,length(Str1)-i);
  Str6:=copy(Str5,i,2);
   IF Str6<>'' THEN
   BEGIN
    if Str6='21' then
    Str7:='A';
    if Str6='22' then
    Str7:='B';
    if Str6='23' then
    Str7:='C';
    if Str6='31' then
    Str7:='D';
    if Str6='32' then
    Str7:='E';
    if Str6='33' then
    Str7:='F';
    if Str6='41' then
    Str7:='G';
    if Str6='42' then
    StR7:='H';
    if Str6='43' then
    Str7:='I';
    if Str6='51' then
    Str7:='J';
    if Str6='52' then
    Str7:='K';
    if Str6='53' then
    Str7:='L';
    if Str6='61' then
    Str7:='M';
    if Str6='62' then
    Str7:='N';
    if Str6='63' then
    Str7:='O';
    if Str6='71' then
    Str7:='P';
    if Str6='72' then
    Str7:='Q';
    if Str6='73' then
    Str7:='R';
    if Str6='74' then
    Str7:='S';
    if Str6='81' then
    Str7:='T';
    if Str6='82' then
    Str7:='U';
    if Str6='83' then
    Str7:='V';
    if Str6='91' then
    Str7:='W';
    if Str6='92' then
    Str7:='X';
    if Str6='93' then
    Str7:='Y';
    if Str6='94' then
    Str7:='Z';
    edit2.text:=edit2.text+Str7;
  END;
  end;
  S:=edit2.text;
  //SHOWMESSAGE(s);
  for   i:=1  to  length(s)   do
    begin
      M:=uppercase(copy(s,i,1));

      //将输入的字符转化成键盘密码值
      k:='QWERTYUIOPASDFGHJKLZXCVBNM!';
      L:=',A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,*,';
      A:=L;
      n:=0;
      b:=pos(',',A);
      while b <>0 do
      begin
        n:=n+1;
        A:=copy(A,b+1,length(A)-b);
        Str1:=copy(A,1,POS(',',A)-1);
        if Str1= M then
        begin
          C:=copy(k,n,length(K)-n);
          Str2:=copy(C,1,1);
          //SHOWMESSAGE(Str2);
          edit1.Text:=edit1.Text+Str2;
        end;
        b:=pos(',',A);
      end;
    END;
  END;

procedure TForm1.Button3Click(Sender: TObject);
 var
     INt1,i,n,b:integer;
     s,M,H,L,A,k,C,Str1,Str2,Str3,F:string;
  begin
    Edit2.text:='';
    Edit3.text:='';
    Edit4.text:='';
    s:=Edit1.text;
    if length(s)<=0   then
    begin
      messagedlg('字符长度不能小于0',mterror,[mbok],0);
      exit;
    end;
    H:='';
    for   i:=1  to  length(s)   do
    begin
      M:=uppercase(copy(s,i,1));
      //将输入的字符转化成键盘密码值
      L:=',Q,W,E,R,T,Y,U,I,O,P,A,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M,!,';
      K:='ABCDEFGHIJKLMNOPQRSTUVWXYZ!';
      A:=L;
      n:=0;
      b:=pos(',',A);
      while b <>0 do
      begin
        n:=n+1;
        A:=copy(A,b+1,length(A)-b);
        Str1:=copy(A,1,POS(',',A)-1);
        if Str1= M then
        begin
          C:=copy(k,n,length(K)-n);
          Str2:=copy(C,1,1);
          edit2.Text:=edit2.Text+Str2;
        end;
        b:=pos(',',A);
      end;
    END;
    Str1:=edit2.Text;
    for  INt1:=1  to  length(Str1)   do
    begin
      Str3:=uppercase(copy(Str1,INt1,1));
      if Str3='A' then
      F:='*-';
      if Str3='B' then
      F:='-***';
      if Str3='C' then
      F:='-*-*';
      if Str3='D' then
      F:='-**';
      if Str3='E' then
      F:='*';
      if Str3='F' then
      F:='**-*';
      if Str3='G' then
      F:='--*';
      if Str3='H' then
      F:='****';
      if Str3='I' then
      F:='**';
      if Str3='J' then
      F:='*---';
      if Str3='K' then
      F:='-*-';
      if Str3='L' then
      F:='*-**';
      if Str3='M' then
      F:='--';
      if Str3='N' then
      F:='-*';
      if Str3='O' then
      F:='---';
      if Str3='P' then
      F:='*--*';
      if Str3='Q' then
      F:='--*-';
      if Str3='R' then
      F:='*-*';
      if Str3='S' then
      F:='***';
      if Str3='T' then
      F:='-';
      if Str3='U' then
      F:='**-';
      if Str3='V' then
      F:='***-';
      if Str3='W' then
      F:='*--';
      if Str3='X' then
      F:='-**-';
      if Str3='Y' then
      F:='-*--';
      if Str3='Z' then
      F:='--**';
      if Str3='1' then
      F:='*----';
      if Str3='2' then
      F:='**---';
      if Str3='3' then
      F:='***--';
      if Str3='4' then
      F:='****-';
      if Str3='5' then
      F:='*****';
      if Str3='6' then
      F:='-****';
      if Str3='7' then
      F:='--***';
      if Str3='8' then
      F:='---**';
      if Str3='9' then
      F:='----*';
      if Str3='0' then
      F:='-----';
      Edit4.Text:=EDIT4.Text+' '+F;
    end;
  end;
procedure TForm1.Button4Click(Sender: TObject);
VAR
  i:integer;
  Str1,Str2,Str3,Str4:String;
begin
  edit2.text:='';
  Str1:=' '+Edit3.Text;
  for  i:=1  to  length(Str1)   do
  begin
  Str3:=copy(Str1,i+1,length(Str1)-i);
  Str2:=copy(Str3,i,2);
   IF Str2<>'' THEN
   BEGIN
    if Str2='21' then
    Str4:='A';
    if Str2='22' then
    Str4:='B';
    if Str2='23' then
    Str4:='C';
    if Str2='31' then
    Str4:='D';
    if Str2='32' then
    Str4:='E';
    if Str2='33' then
    Str4:='F';
    if Str2='41' then
    Str4:='G';
    if Str2='42' then
    Str4:='H';
    if Str2='43' then
    Str4:='I';
    if Str2='51' then
    Str4:='J';
    if Str2='52' then
    Str4:='K';
    if Str2='53' then
    Str4:='L';
    if Str2='61' then
    Str4:='M';
    if Str2='62' then
    Str4:='N';
    if Str2='63' then
    Str4:='O';
    if Str2='71' then
    Str4:='P';
    if Str2='72' then
    Str4:='Q';
    if Str2='73' then
    Str4:='R';
    if Str2='74' then
    Str4:='S';
    if Str2='81' then
    Str4:='T';
    if Str2='82' then
    Str4:='U';
    if Str2='83' then
    Str4:='V';
    if Str2='91' then
    Str4:='W';
    if Str2='92' then
    Str4:='X';
    if Str2='93' then
    Str4:='Y';
    if Str2='94' then
    Str4:='Z';
    edit2.text:=edit2.text+Str4;
  END;
  end;
end;


procedure TForm1.Button5Click(Sender: TObject);
var
     INt1,i,n,b:integer;
     s,M,H,L,A,k,C,Str1,Str2,O,Str3,P,Str4:string;
  begin
    Edit2.text:='';
    Edit3.text:='';
    Edit4.text:='';
    s:=Edit1.text;
    if length(s)<=0   then
    begin
      messagedlg('字符长度不能小于0',mterror,[mbok],0);
      exit;
    end;
    H:='';
    for   i:=1  to  length(s)   do
    begin
      M:=uppercase(copy(s,i,1));
      //将输入的字符转化成键盘密码值
      // L:=',Q,W,E,R,T,Y,U,I,O,P,A,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M,';
      L:=',Q,W,E,R,T,Y,U,I,O,P,A,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M,*,';
      K:='ABCDEFGHIJKLMNOPQRSTUVWXYZ!';
      A:=L;
      n:=0;
      //b:=0;
      b:=pos(',',A);
      while b <>0 do
      begin
        n:=n+1;
        A:=copy(A,b+1,length(A)-b);
        Str1:=copy(A,1,POS(',',A)-1);
        if Str1= M then
        begin
          C:=copy(k,n,length(K)-n);
          Str2:=copy(C,1,1);
           if Str2='A'  then
          O:='21';
          if Str2='B'  then
          O:='22';
          if Str2='C'  then
          O:='23';
          if Str2='D'  then
          O:='31';
          if Str2='E'  then
          O:='32';
          if Str2='F'  then
          O:='33';
          if Str2='G'  then
          O:='41';
          if Str2='H'  then
          O:='42';
          if Str2='I'  then
          O:='43';
          if Str2='J'  then
          O:='51';
          if Str2='K'  then
          O:='52';
          if Str2='L'  then
          O:='53';
          if Str2='M'  then
          O:='61';
          if Str2='N'  then
          O:='62';
          if Str2='O'  then
          O:='63';
          if Str2='P'  then
          O:='71';
          if Str2='Q'  then
          O:='72';
          if Str2='R'  then
          O:='73';
          if Str2='S'  then
          O:='74';
          if Str2='T'  then
          O:='81';
          if Str2='U'  then
          O:='82';
          if Str2='V'  then
          O:='83';
          if Str2='W'  then
          O:='91';
          if Str2='X'  then
          O:='92';
          if Str2='Y'  then
          O:='93';
          if Str2='Z'  then
          O:='94';
          edit2.Text:=edit2.Text+Str2;
          edit3.Text:=edit3.Text+O;
        end;
        b:=pos(',',A);
      end;
    end;
    Str3:= edit3.Text;
    for   INt1:=1  to  length(Str3)   do
    begin
      Str4:=uppercase(copy(Str3,INt1,1));
      if Str4='1' then
      P:='*----';
      if Str4='2' then
      P:='**---';
      if Str4='3' then
      P:='***--';
      if Str4='4' then
      P:='****-';
      if Str4='5' then
      P:='*****';
      if Str4='6' then
      P:='-****';
      if Str4='7' then
      P:='--***';
      if Str4='8' then
      P:='---**';
      if Str4='9' then
      P:='----*';
      if Str4='0' then
      P:='-----';
      Edit4.Text:=EDIT4.Text+' '+P;
    end;
  end;
procedure TForm1.Button6Click(Sender: TObject);
  var
    str :WideString;
    str1,str2,F,str3:String;
  begin
    Edit3.text:='';
    //Edit4.text:='';
    str:=Edit4.Text+' ';
    str1:=str;
    while POS(' ',str1) > 0 do
    begin
      str2:=Copy(str1,1,POS(' ',str1));
      str3:=Copy(str2,1,POS(' ',str2)-1);
      if str3='*-' Then
      F:='A';
      if str3='-***' Then
      F:='B';
      if str3='-*-*' Then
      F:='C';
      if str3='-**' Then
      F:='D';
      if str3='*' Then
      F:='E';
      if str3='**-*' Then
      F:='F';
      if str3='--*' Then
      F:='G';
      if str3='****' Then
      F:='H';
      if str3='**' Then
      F:='I';
      if str3='*---' Then
      F:='J';
      if str3='-*-' Then
      F:='K';
      if str3='*-**' Then
      F:='L';
      if str3='--' Then
      F:='M';
      if str3='-*' Then
      F:='N';
      if str3='---' Then
      F:='O';
      if str3='*--*' Then
      F:='P';
      if str3='--*-' Then
      F:='Q';
      if str3='*-*' Then
      F:='R';
      if str3='***' Then
      F:='S';
      if str3='-' Then
      F:='T';
      if str3='**-' Then
      F:='U';
      if str3='***-' Then
      F:='V';
      if str3='*--' Then
      F:='W';
      if str3='-**-' Then
      F:='X';
      if str3='-*--' Then
      F:='Y';
      if str3='--**' Then
      F:='Z';
      if str3='*----' Then
      F:='1';
      if str3='**---' Then
      F:='2';
      if str3='***--' Then
      F:='3';
      if str3='****-' Then
      F:='4';
      if str3='*****' Then
      F:='5';
      if str3='-****' Then
      F:='6';
      if str3='--***' Then
      F:='7';
      if str3='---**' Then
      F:='8';
      if str3='----*' Then
      F:='9';
      if str3='-----' Then
      F:='0';
      str1:=Copy(str1,POS(' ',str1)+1,Length(str1));
      Edit3.Text:=Edit3.Text+F;
    end;
  end;

procedure TForm1.Button7Click(Sender: TObject);
begin
edit2.Text:=' ';
 edit3.Text:=' ';
 edit4.Text:=' ';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
edit2.Text:=' ';
 edit3.Text:=' ';
 edit1.Text:=' ';
end;

end.
