object UserDM: TUserDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 472
  Top = 220
  Height = 204
  Width = 267
  object adcUser: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 56
    Top = 24
  end
  object adqByName: TADOQuery
    Connection = adcUser
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'name'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'select * from jbqk '
      'where name like :name')
    Left = 152
    Top = 24
  end
  object dspUser: TDataSetProvider
    DataSet = adqByName
    Left = 56
    Top = 88
  end
  object adqTemp: TADOQuery
    Connection = adcUser
    Parameters = <>
    Left = 152
    Top = 88
  end
end
