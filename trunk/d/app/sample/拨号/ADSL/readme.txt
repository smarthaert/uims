《ADSL自动拨号程序》源代码
源码来源于：http://www.samool.com/archives/9737

主要功能：自动换IP地址，自动获取本地ADSL连接，定时自动拨号，自动缩小到状态栏，拨号日志记录，IP地址记录

可以用来刷IP地址用，刷网站等等。呵呵，功能很少，但是很实用！现在发布出来给大家用用，并提供源码下载，代码有点乱，老鸟就可以略过了，仅供学习交流使用，欢迎大家提出建议！

开发平台：Delphi7 + WindowsXp xp2

使用控件：Dial拨号控件，cnPack Tray


需要安装控件：
DialUp.pas

老外写的一个用来管理RAS拨号的控件。
拨号例子
  DialUp1.ConnectTO:='宽带连接';
  DialUp1.GoOnline;


