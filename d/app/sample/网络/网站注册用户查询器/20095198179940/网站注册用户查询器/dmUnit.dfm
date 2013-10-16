object dm: Tdm
  OldCreateOrder = False
  Left = 410
  Top = 207
  Height = 365
  Width = 431
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=webst' +
      'ation.mdb;Mode=Share Deny None;Extended Properties="";Persist Se' +
      'curity Info=False;Jet OLEDB:System database="";Jet OLEDB:Registr' +
      'y Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5' +
      ';Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk' +
      ' Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Databa' +
      'se Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:' +
      'Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=Fa' +
      'lse;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP' +
      '=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 200
    Top = 16
  end
  object ADOZJWZQuery: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 56
    Top = 80
  end
  object ADOZJWZTable: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #32593#31449#27880#20876#29992#25143#23494#30721#34920
    Left = 160
    Top = 80
  end
  object DataWZBJSource: TDataSource
    DataSet = ADOZJWZQuery
    Left = 256
    Top = 80
  end
  object ADOZJWZQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 56
    Top = 128
  end
  object ADOZJWZQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 56
    Top = 184
  end
  object DataEXCELSource: TDataSource
    DataSet = ADOEXCELTable
    Left = 256
    Top = 128
  end
  object ADOEXCELTable: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #32593#31449#27880#20876#29992#25143#23494#30721#34920
    Left = 160
    Top = 128
  end
end
