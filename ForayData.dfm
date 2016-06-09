object ForayDM: TForayDM
  OldCreateOrder = False
  Height = 168
  Width = 242
  object NewForaysQuery: TIB_Query
    DatabaseName = '127.0.0.1:OLDIMS'
    IB_Connection = ForayConnection
    SQL.Strings = (
      'SELECT *'
      'FROM FORAYS'
      '')
    Left = 34
    Top = 77
  end
  object NewForaysDS: TIB_DataSource
    Dataset = NewForaysQuery
    Left = 139
    Top = 77
  end
  object ForayConnection: TIB_Connection
    CacheStatementHandles = False
    DefaultTransaction = FunTransaction
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=UTF8'
      'PATH=OLDIMS'
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'SERVER=127.0.0.1'
      'PROTOCOL=TCP/IP')
    Left = 48
    Top = 13
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object FunTransaction: TIB_Transaction
    IB_Connection = ForayConnection
    Isolation = tiCommitted
    Left = 138
    Top = 12
  end
end
