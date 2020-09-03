object DM: TDM
  OldCreateOrder = False
  Height = 150
  Width = 215
  object conFB: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Desenv\Documents\Embarcadero\Studio\Projects\M' +
        'enuToJson\Win32\Debug\app\SISTEMA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 48
    Top = 28
  end
  object qr1: TFDQuery
    Connection = conFB
    Left = 92
    Top = 64
  end
end
