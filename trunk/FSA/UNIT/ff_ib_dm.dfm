object ff_dm: Tff_dm
  OldCreateOrder = False
  Height = 291
  Width = 382
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLNCLI.1;Password=gtja@123;Persist Security Info=True;' +
      'User ID=hxs;Data Source=10.100.16.45'
    DefaultDatabase = 'hlg'
    IsolationLevel = ilReadUncommitted
    LoginPrompt = False
    Provider = 'SQLNCLI.1'
    Left = 64
    Top = 65
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 64
    Top = 168
  end
end
