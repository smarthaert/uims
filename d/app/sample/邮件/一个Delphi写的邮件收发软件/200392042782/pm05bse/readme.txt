{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}


  这是我程序设计比赛的作品，由于当时接到通知的时间很晚，只剩一个月
的时间，本来想用VC++，但一看到参考书就头痛，因此转向了Delphi，我原
来可是学C++的，于是硬着头皮往前闯，发现其实学了一门语言后转向另一种
语言是很容易的，这也是我的第一个Windows应用程序，在查资料的的时候发现
大部分的Demo都是单帐户，没有多帐户，而且没有地址簿功能，于是我自己干
刚开始的时候程序很简单，是用对ini文件的读写来实现多帐户的，后来在老师
的鼓励下，转用数据库处理，由于数据库编程我也是第一次接触，刚开始感觉特
难，但在csdn各位大虾的帮助下，奋战了整个五一长假，终于初具成型（当然也
得了第一），当然这个程序仍有很多问题，这也是我为什么将其放在原代码区的
原因，也正因为如此，我才公开原代码，希望各位同好给予指点！

说明：我既提供原代码，也提供控件，还有编译好的程序，另附一份开发文档说明，不
过已与程序有了一定的出入，敬请注意！

本程序所需的第三方控件
Mail2000
XPMenu
CoolTrayIcon
Delphi6自带的Id系列控件



-----------本程序的一个严重bug,敬请注意！！！------------------

急切希望各位帮助！

{地址簿的姓名字段可以重名，但e-mail地址不能重；
在修改地址时，首先显示的是该记录的相应字段，然后根据下列情况
进行操作：
1。姓名，e-mail地址不变，保持原样；
2。姓名变，且可与表中已有姓名一样，e-mail地址不变；
3。姓名不变，e-mail地址变，但必须与表中已有e-mail地址
（当然除这个记录的原有的那个e-mail地址）不重复；
4.姓名变，且可与表中已有姓名一样，e-mail地址也变，但必须
与表中已有e-mail地址（当然除这个记录的原有的那个e-mail地址）
不重复。
代码如下：
procedure TfmAsSet.btnSetClick(Sender: TObject);
begin
       with fmAsN.adoqAsN do
       begin
                close;
                sql.Clear;
                sql.Add('select * from AddressNote where FromAddress=:FromAddress');	//查找是否有地址重复
                Parameters.ParamByName('FromAddress').Value:=edtFromAddress.Text;
                open;
       end;

       if fmAsN.adoqAsN.RecordCount=1 then	//记录条数等于1，有两种情况
       begin
                if  edtFromAddress.Text<>fmAsN.lvAddress.Selected.SubItems.Text then	//如果输入的原有地址不相同，则肯定是地址重复了
                begin
                        showmessage('地址重名！');
                        fmAsN.adoqAsN.Close;
                        exit;
                end



                else			//如果相同，则说明是地址不变的那种情况
                begin
                     with fmAsN.adoqAsN do
                     begin
                                close;
                                sql.Clear;
                                SQL.Text:='select * from AddressNote where FromAddress='''+trim(fmAsN.lvAddress.Selected.SubItems.Text)+'''';
                                Open; 
                                Edit;
                                FieldByName('FromName').AsString:=edtFromName.Text;
                                FieldByName('FromAddress').AsString:=edtFromAddress.Text;
                                Post;
                                Close;
                     end;

                     {fmAsN.lvAddress.Selected.Caption:=edtFromName.Text;
                     fmAsN.lvAddress.Selected.SubItems.Text:=edtFromAddress.Text;
                     fmAsN.lvAddress.Update;}
                     fmAsN.lvAddress.Clear;
                     fmAsN.UpdatelvAddress(Sender);

                     fmAsN.labFromName.Caption:=fmAsN.lvAddress.Selected.Caption;
                     fmAsN.labFormAddress.Caption:=fmAsN.lvAddress.Selected.SubItems.Strings[0];
                     fmAsSet.Close;

                end;

       end;
       with fmAsN.adoqAsN do
       begin
                close;
                sql.Clear;
                SQL.Text:='select * from AddressNote where FromAddress='''+fmAsN.lvAddress.Selected.SubItems.Text+'''';
                Open; 
                Edit;
                FieldByName('FromName').AsString:=edtFromName.Text;
                FieldByName('FromAddress').AsString:=edtFromAddress.Text;
                Post;
                Close;
        end;

        {fmAsN.lvAddress.Selected.Caption:=edtFromName.Text;
        fmAsN.lvAddress.Selected.SubItems.Text:=edtFromAddress.Text;
        fmAsN.lvAddress.Update;}

        fmAsN.lvAddress.Clear;
        fmAsN.UpdatelvAddress(Sender);		//实际上是从地址簿表中重新读入数据

        fmAsN.labFromName.Caption:=fmAsN.lvAddress.Selected.Caption;
        fmAsN.labFormAddress.Caption:=fmAsN.lvAddress.Selected.SubItems.Strings[0];
        fmAsSet.Close;

end;

现在的问题是这样的：我故意将e-mail地址修改得与表中原有e-mail地址相同时， 程序能正常
出现提示重新输入 ，然后我关闭修改地址窗口，再次选择刚才那个记录，打开修改地址窗口
又故意将e-mail地址修改得与表中原有e-mail地址相同时，程序竟然没提示，连ODBC的字段
索引重复的警告也没有，可我已经将e-mail地址字段设为有索引且不可重复了啊！开始我以为
只是在lvAddress中出现相同记录，但当我打开表时发现也有两个相同的记录，更糟的是，发生
这样的操作以后，对表的操作全乱了，添加新记录时，地址可任意重复，删除记录删不了，除非
手动打开表，将所有记录全部删除，程序才恢复正常。}