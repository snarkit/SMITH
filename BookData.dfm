object BooksDM: TBooksDM
  OldCreateOrder = False
  Height = 210
  Width = 353
  object BookConnection: TIB_Connection
    CacheStatementHandles = False
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'SERVER=localhost'
      'PATH=OLDIMS'
      'USER NAME=SYSDBA'
      'PROTOCOL=TCP/IP'
      'SQL DIALECT=3'
      'CHARACTER SET=UTF8')
    Left = 48
    Top = 24
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object BookCursor: TIB_Cursor
    DatabaseName = 'localhost:OLDIMS'
    IB_Connection = BookConnection
    SQL.Strings = (
      'select * from BOOKS ')
    Left = 151
    Top = 32
  end
  object NewBooksQuery: TIB_Query
    DatabaseName = 'localhost:OLDIMS'
    FieldsReadOnly.Strings = (
      'BOOKID=TRUE')
    IB_Connection = BookConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.ORIGTITLE = :ORIGTITLE,'
      '   BOOKS.VOLUME = :VOLUME,'
      '   BOOKS.EDITION = :EDITION,'
      '   BOOKS.PUBLISHER = :PUBLISHER,'
      '   BOOKS.PLACE = :PLACE,'
      '   BOOKS.YEAR_PUBL = :YEAR_PUBL,'
      '   BOOKS.OPUBLISHER = :OPUBLISHER,'
      '   BOOKS.OPLACE = :OPLACE,'
      '   BOOKS.OYEAR = :OYEAR,'
      '   BOOKS.DATE_ACQ = :DATE_ACQ,'
      '   BOOKS.PRICE = :PRICE,'
      '   BOOKS.REF = :REF,'
      '   BOOKS.SUBJECT = :SUBJECT,'
      '   BOOKS.ISBN = :ISBN,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.NOTES = :NOTES,'
      '   BOOKS.MARKER = :MARKER'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   AUTHOR,'
      '   TITLE,'
      '   ORIGTITLE,'
      '   VOLUME,'
      '   EDITION,'
      '   PUBLISHER,'
      '   PLACE,'
      '   YEAR_PUBL,'
      '   OPUBLISHER,'
      '   OPLACE,'
      '   OYEAR,'
      '   DATE_ACQ,'
      '   PRICE,'
      '   REF,'
      '   SUBJECT,'
      '   ISBN,'
      '   PRINT,'
      '   NOTES,'
      '   MARKER)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :AUTHOR,'
      '   :TITLE,'
      '   :ORIGTITLE,'
      '   :VOLUME,'
      '   :EDITION,'
      '   :PUBLISHER,'
      '   :PLACE,'
      '   :YEAR_PUBL,'
      '   :OPUBLISHER,'
      '   :OPLACE,'
      '   :OYEAR,'
      '   :DATE_ACQ,'
      '   :PRICE,'
      '   :REF,'
      '   :SUBJECT,'
      '   :ISBN,'
      '   :PRINT,'
      '   :NOTES,'
      '   :MARKER)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    Left = 117
    Top = 113
  end
  object NewBooksDS: TIB_DataSource
    Dataset = NewBooksQuery
    Left = 224
    Top = 112
  end
end
