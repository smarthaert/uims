object Frm_DM: TFrm_DM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 225
  Top = 182
  Height = 150
  Width = 253
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConn
    Parameters = <>
    SQL.Strings = (
      'SELECT  * FROM ALLMAN')
    Left = 144
    Top = 32
  end
end
