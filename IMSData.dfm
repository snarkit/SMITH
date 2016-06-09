object IMSDM: TIMSDM
  OldCreateOrder = False
  Height = 700
  Width = 903
  object FBConnection: TIB_Connection
    CacheStatementHandles = False
    DefaultTransaction = IMSTransaction
    PasswordStorage = psNotSecure
    SQLDialect = 3
    DatabaseName = 'LocalIMSDB'
    Params.Strings = (
      'PATH=LocalIMSDB'
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'SERVER=localhost'
      'CHARACTER SET=UTF8'
      'ClientLibrary := '#39'fbclient.dll'#39)
    Left = 32
    Top = 12
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object IMSTransaction: TIB_Transaction
    IB_Connection = FBConnection
    AutoCommit = True
    Isolation = tiCommitted
    Left = 108
    Top = 12
  end
  object RefsByOrgQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'NOTES=0'
      'PAGENO=60'
      'VOLUME=60')
    FieldsVisible.Strings = (
      'ORGCODE=FALSE'
      'REFID=TRUE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKREFS'
      'WHERE ORGCODE=:orgcode')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKREFS '
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE BOOKREFS SET'
      '   BOOKREFS.BOOKCODE = :BOOKCODE,'
      '   BOOKREFS.VOLUME = :VOLUME,'
      '   BOOKREFS.PAGENO = :PAGENO,'
      '   BOOKREFS.ORGCODE = :ORGCODE,'
      '   BOOKREFS.NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'BOOKREFS.REFID')
    KeyLinksAutoDefine = False
    RefreshAction = raKeepDataPosOrRowNum
    CommitAction = caRefresh
    Left = 32
    Top = 184
    ParamValues = (
      'ORGCODE=')
  end
  object RefsByOrgDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = RefsByOrgQuery
    Left = 104
    Top = 208
  end
  object FindsByOrgDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = FindsByOrgQuery
    Left = 288
    Top = 144
  end
  object FindsByForayQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'F.NOTES=0'
      'F.ORGCODE=100'
      'N.NAME=200')
    FieldsReadOnly.Strings = (
      'N.NAME=TRUE')
    FieldsVisible.Strings = (
      'F.FORAYCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT F.FINDID'
      '     , F.FORAYCODE'
      '     , F.ORGCODE'
      '     , F.NOTES'
      '     , O.PREFERREDNAME'
      'from FINDS F'
      'JOIN ORGANISMS O'
      'ON O.ORGCODE = F.ORGCODE'
      'where (F.foraycode = :foraycode)'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM FINDS F'
      'WHERE'
      '   FINDID = :OLD_FINDID')
    EditSQL.Strings = (
      'UPDATE FINDS F SET'
      '   F.FORAYCODE = :FORAYCODE,'
      '   F.ORGCODE = :ORGCODE,'
      '   F.NOTES = :NOTES'
      'WHERE'
      '   FINDID = :OLD_FINDID')
    InsertSQL.Strings = (
      'INSERT INTO FINDS('
      '   FORAYCODE,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :FORAYCODE,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'FINDS.FINDID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'F.ORGCODE=F.ORGCODE;F.ORGCODE DESC'
      'O.PREFERREDNAME=O.PREFERREDNAME;O.PREFERREDNAME DESC')
    OrderingLinks.Strings = (
      'F.ORGCODE=ITEM=2'
      'O.PREFERREDNAME=ITEM=1')
    Left = 196
    Top = 188
    ParamValues = (
      'FORAYCODE=')
  end
  object FindsByForayDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = FindsByForayQuery
    Left = 292
    Top = 212
  end
  object BooksByUseQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'BOOKCODE=104'
      'AUTHOR=206'
      'NOTES=0')
    FieldsReadOnly.Strings = (
      'BOOKID=TRUE')
    FieldsVisible.Strings = (
      'BOOKID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'WHERE (USEDBY LIKE :usedby)'
      'AND (PRINT LIKE :print)')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.NOTES = :NOTES,'
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
      '   BOOKS."REF" = :"REF",'
      '   BOOKS.SUBJECT = :SUBJECT,'
      '   BOOKS.ISBN = :ISBN,'
      '   BOOKS.NUMBERPAGES = :NUMBERPAGES,'
      '   BOOKS.USEDBY = :USEDBY,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.MARKER = :MARKER,'
      '   BOOKS.SHORTCODE = :SHORTCODE'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    GeneratorLinks.Strings = (
      'BOOKS.BOOKID=BOOKID_NO')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   SHORTCODE,'
      '   TITLE,'
      '   AUTHOR,'
      '   NOTES,'
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
      '   NUMBERPAGES,'
      '   PRINT,'
      '   MARKER,'
      '   USEDBY)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :SHORTCODE,'
      '   :TITLE,'
      '   :AUTHOR,'
      '   :NOTES,'
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
      '   :NUMBERPAGES,'
      '   :PRINT,'
      '   :MARKER,'
      '   :USEDBY)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    KeyLinksAutoDefine = False
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'BOOKCODE=BOOKCODE;BOOKCODE DESC'
      'AUTHOR=AUTHOR;AUTHOR DESC'
      'DATE_ACQ=DATE_ACQ;DATE_ACQ DESC'
      'SUBJECT=SUBJECT;SUBJECT DESC'
      'BOOKID=BOOKID;BOOKID DESC'
      'REF=REF;REF DESC'
      'TITLE=TITLE;TITLE DESC'
      'SHORTCODE=SHORTCODE;SHORTCODE DESC')
    OrderingLinks.Strings = (
      'BOOKCODE=1'
      'AUTHOR=2'
      'DATE_ACQ=3'
      'SUBJECT=4'
      'BOOKID=5'
      'REF=6'
      'TITLE=7'
      'SHORTCODE=8')
    RequestLive = True
    Left = 23
    Top = 65
    ParamValues = (
      'USEDBY='#39'%'#39
      'PRINT='#39'%'#39)
  end
  object BooksByUseDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = BooksByUseQuery
    Left = 105
    Top = 74
  end
  object AllForaysQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'FORAYCOMMENTS=0')
    FieldsReadOnly.Strings = (
      'FORAYID=TRUE')
    FieldsVisible.Strings = (
      'FORAYID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT FORAYID'
      '     , FORAYCODE'
      '     , FORAYNAME'
      '     , FORAYDATE'
      '     , FORAYCOUNTRY'
      '     , FORAYPLACE'
      '     , FORAYCOMMENTS'
      'FROM FORAYS')
    DeleteSQL.Strings = (
      'DELETE FROM FORAYS FORAYS'
      'WHERE'
      '   FORAYID = :OLD_FORAYID')
    EditSQL.Strings = (
      'UPDATE FORAYS FORAYS SET'
      '   FORAYS.FORAYCODE = :FORAYCODE,'
      '   FORAYS.FORAYNAME = :FORAYNAME,'
      '   FORAYS.FORAYDATE = :FORAYDATE,'
      '   FORAYS.FORAYCOUNTRY = :FORAYCOUNTRY,'
      '   FORAYS.FORAYPLACE = :FORAYPLACE,'
      '   FORAYS.FORAYCOMMENTS = :FORAYCOMMENTS'
      'WHERE'
      '   FORAYID = :OLD_FORAYID')
    InsertSQL.Strings = (
      'INSERT INTO FORAYS('
      '   FORAYCODE,'
      '   FORAYNAME,'
      '   FORAYDATE,'
      '   FORAYCOUNTRY,'
      '   FORAYPLACE,'
      '   FORAYCOMMENTS)'
      'VALUES ('
      '   :FORAYCODE,'
      '   :FORAYNAME,'
      '   :FORAYDATE,'
      '   :FORAYCOUNTRY,'
      '   :FORAYPLACE,'
      '   :FORAYCOMMENTS)')
    KeyLinks.Strings = (
      'FORAYS.FORAYID')
    KeyLinksAutoDefine = False
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'FORAYCODE=FORAYCODE;FORAYCODE DESC')
    OrderingLinks.Strings = (
      'FORAYCODE=1')
    Left = 200
    Top = 72
  end
  object AllForaysDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = AllForaysQuery
    Left = 288
    Top = 80
  end
  object RefsByBookQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsVisible.Strings = (
      'R.REFID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT N.NAME'
      '     , R.REFID'
      '     , R.BOOKCODE'
      '     , R.VOLUME'
      '     , R.PAGENO'
      '     , R.REFCODE'
      '     , R.ORGCODE'
      '     , R.NOTES'
      'FROM BOOKREFS R'
      'JOIN ORGNAMES N '
      'ON N.ORGCODE = R.ORGCODE'
      'WHERE (R.BOOKCODE = :bookcode)'
      'AND (R.VOLUME LIKE :volume)'
      'AND (N.PREFERRED<>0)'
      'ORDER BY N.FULLNAME')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKREFS '
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE BOOKREFS SET'
      '   BOOKCODE = :BOOKCODE,'
      '   VOLUME = :VOLUME,'
      '   PAGENO = :PAGENO,'
      '   ORGCODE = :ORGCODE,'
      '   NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'BOOKREFS.REFID')
    KeyLinksAutoDefine = False
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'Code=ORGCODE;ORGCODE DESC'
      'Name=NAME;NAME DESC'
      'Refcode=REFCODE;REFCODE DESC'
      'Pageno=PAGENO;PAGENO DESC')
    OrderingLinks.Strings = (
      'Code=1'
      'Name=2'
      'Refcode=3'
      'Pageno=4')
    CommitAction = caRefresh
    Left = 33
    Top = 248
    ParamValues = (
      'BOOKCODE='#39'Bon'#39
      'VOLUME='#39'%'#39)
  end
  object RefsByBookDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = RefsByBookQuery
    Left = 112
    Top = 280
  end
  object OpenDialog1: TOpenDialog
    Left = 200
    Top = 16
  end
  object FindsByOrgQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM FINDS'
      'WHERE ORGCODE = :ORGCODE')
    DeleteSQL.Strings = (
      'DELETE FROM FINDS FINDS'
      'WHERE'
      '   FINDID = :OLD_FINDID')
    EditSQL.Strings = (
      'UPDATE FINDS FINDS SET'
      '   FINDS.FORAYCODE = :FORAYCODE,'
      '   FINDS.ORGCODE = :ORGCODE,'
      '   FINDS.NOTES = :NOTES'
      'WHERE'
      '   FINDID = :OLD_FINDID')
    InsertSQL.Strings = (
      'INSERT INTO FINDS('
      '   FORAYCODE,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :FORAYCODE,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'FINDS.FINDID')
    Left = 200
    Top = 128
  end
  object AllEUPlantNames: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsCharCase.Strings = (
      'O.ORGCODE=UPPER')
    FieldsDisplayWidth.Strings = (
      'O.ORGCODE=90'
      'O.IMS=24'
      'O.COMMENTS=0'
      'O.CARD=0'
      'O.POLNO=100')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT O.ORGCODE'
      '     , O.COMMENTS'
      '     , O.CARD'
      '     , O.POLNO'
      '     , N.FULLNAME'
      'FROM ORGANISMS O'
      'INNER JOIN ORGNAMES N'
      'ON O.ORGCODE=N.ORGCODE'
      'WHERE (O.ORGCODE LIKE '#39'_____ '#39')'
      'AND (O.POLNO<>'#39#39')')
    AutoFetchAll = True
    JoinLinks.Strings = (
      'O.ORGCODE=N.ORGCODE')
    OrderingItems.Strings = (
      'O.ORGCODE=O.ORGCODE;O.ORGCODE DESC'
      'N.FULLNAME=N.FULLNAME;N.FULLNAME DESC'
      'O.POLNO=O.POLNO;O.POLNO DESC')
    OrderingLinks.Strings = (
      'O.ORGCODE=1'
      'N.FULLNAME=2'
      'O.POLNO=3')
    Left = 400
    Top = 24
  end
  object AllPlantsDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = AllPlantsQuery
    Left = 792
    Top = 456
  end
  object OrgByCodeQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsCharCase.Strings = (
      'ORGCODE=UPPER')
    FieldsEditMask.Strings = (
      'ORGCODE=>LLLLL<A')
    FieldsReadOnly.Strings = (
      'ORGID=TRUE')
    FieldsVisible.Strings = (
      'ORGID=FALSE'
      'ORGCODE=TRUE'
      'IMS=TRUE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGANISMS'
      'WHERE ORGCODE=:orgcode')
    DefaultValues.Strings = (
      'IMS=True')
    DeleteSQL.Strings = (
      'DELETE FROM ORGANISMS ORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE ORGANISMS ORGANISMS SET'
      '   ORGANISMS.ORGCODE = :ORGCODE,'
      '   ORGANISMS.COMMENTS = :COMMENTS,'
      '   ORGANISMS.CARD = :CARD,'
      '   ORGANISMS.FAMILY = :FAMILY,'
      '   ORGANISMS.POLNO = :POLNO,'
      '   ORGANISMS.DATEMODIFIED = :DATEMODIFIED,'
      '   ORGANISMS.USEDBY = :USEDBY,'
      '   ORGANISMS.PREFERREDNAME = :PREFERREDNAME,'
      '   ORGANISMS.EPPTVALIDATE = :EPPTVALIDATE'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO ORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY,'
      '   POLNO,'
      '   DATEMODIFIED,'
      '   USEDBY,'
      '   PREFERREDNAME,'
      '   EPPTVALIDATE)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY,'
      '   :POLNO,'
      '   :DATEMODIFIED,'
      '   :USEDBY,'
      '   :PREFERREDNAME,'
      '   :EPPTVALIDATE)')
    KeyLinks.Strings = (
      'ORGANISMS.ORGID')
    Left = 399
    Top = 82
    ParamValues = (
      'ORGCODE='#39'VERCN'#39)
  end
  object OrgByCodeDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = OrgByCodeQuery
    Left = 488
    Top = 84
  end
  object OrgNamesDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = OrgNamesROQuery
    Left = 489
    Top = 144
  end
  object OrgNamesROQuery: TIB_Query
    ColumnAttributes.Strings = (
      'NAME=BLANKISNULL'
      'LANGUAGE=BLANKISNULL')
    DatabaseName = 'LocalIMSDB'
    FieldsAlignment.Strings = (
      'LANGUAGE=CENTER'
      'LN=CENTER')
    FieldsCharCase.Strings = (
      'LANGUAGE=LOWER')
    FieldsDisplayLabel.Strings = (
      'COMMENTS=Comments')
    FieldsGridLabel.Strings = (
      'LN=No'
      'NAME=Name'
      'AUTHORITY=Authority'
      'LANGUAGE=Lang')
    FieldsDisplayWidth.Strings = (
      'LN=15'
      'LANGUAGE=25'
      'AUTHORITY=194'
      'COMMENTS=0'
      'NAME=200'
      'PREFERRED=106')
    FieldsEditMask.Strings = (
      'L'
      'LANGUAGE=L')
    FieldsReadOnly.Strings = (
      'NAMEID=TRUE')
    FieldsVisible.Strings = (
      'NAMEID=FALSE'
      'ORGCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGNAMES '
      'WHERE ORGNAMES.ORGCODE = :orgcode')
    AutoFetchAll = True
    DefaultValues.Strings = (
      'LN=0'
      'LANGUAGE=A')
    DeleteSQL.Strings = (
      'DELETE FROM ORGNAMES ORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE ORGNAMES ORGNAMES SET'
      '   ORGNAMES.ORGCODE = :ORGCODE,'
      '   ORGNAMES.FULLNAME = :FULLNAME,'
      '   ORGNAMES.AUTHORITY = :AUTHORITY,'
      '   ORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   ORGNAMES.COMMENTS = :COMMENTS,'
      '   ORGNAMES.PREFERRED = :PREFERRED,'
      '   ORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   ORGNAMES.EPPTACTION = :EPPTACTION'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO ORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTACTION)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTACTION)')
    KeyLinks.Strings = (
      'ORGNAMES.NAMEID')
    OrderingItems.Strings = (
      'NAME=NAME;NAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE DESC')
    OrderingLinks.Strings = (
      'NAME=ITEM=1'
      'LANGUAGE=ITEM=2')
    ReadOnly = True
    Left = 389
    Top = 149
    ParamValues = (
      'ORGCODE='#39'ABIAL'#39)
  end
  object MarkedBooksQuery: TIB_Query
    ColumnAttributes.Strings = (
      'PRICE=CURRENCY')
    DatabaseName = 'LocalIMSDB'
    FieldsCharCase.Strings = (
      'PRINT=UPPER'
      'USEDBY=UPPER')
    FieldsGridLabel.Strings = (
      'PRINT=X'
      'USEDBY=USE')
    FieldsDisplayWidth.Strings = (
      'PRINT=30'
      'RECNO=60'
      'DATE_ACQ=80'
      'VOLUME=40'
      'EDITION=60'
      'OYEAR=60'
      'PRICE=80'
      'YEAR_PUBL=60'
      'ISBN=80'
      'REF=50'
      'BOOKID=52'
      'USEDBY=70'
      'SUBJECT=120'
      'TITLE=220')
    FieldsEditMask.Strings = (
      'AAAAA')
    FieldsTrimming.Strings = (
      'USEDBY=NONE')
    FieldsVisible.Strings = (
      'BOOKCODE=TRUE'
      'BOOKID=TRUE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'WHERE MARKER = '#39'S'#39)
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.SHORTCODE = :SHORTCODE,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.NOTES = :NOTES,'
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
      '   BOOKS.NUMBERPAGES = :NUMBERPAGES,'
      '   BOOKS.USEDBY = :USEDBY,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.MARKER = :MARKER'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    GeneratorLinks.Strings = (
      'BOOKS.BOOKID=BOOKID_NO')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   SHORTCODE,'
      '   TITLE,'
      '   AUTHOR,'
      '   NOTES,'
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
      '   NUMBERPAGES,'
      '   USEDBY,'
      '   PRINT,'
      '   MARKER)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :SHORTCODE,'
      '   :TITLE,'
      '   :AUTHOR,'
      '   :NOTES,'
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
      '   :NUMBERPAGES,'
      '   :USEDBY,'
      '   :PRINT,'
      '   :MARKER)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    KeyLinksAutoDefine = False
    OrderingItemNo = 5
    OrderingItems.Strings = (
      'BOOKCODE=BOOKCODE;BOOKCODE DESC'
      'AUTHOR=AUTHOR;AUTHOR DESC'
      'DATE_ACQ=DATE_ACQ;DATE_ACQ DESC'
      'SUBJECT=SUBJECT;SUBJECT DESC'
      'BOOKID=BOOKID;BOOKID DESC'
      'REF=REF;REF DESC'
      'TITLE=TITLE;TITLE DESC'
      'SHORTCODE=SHORTCODE;SHORTCODE DESC')
    OrderingLinks.Strings = (
      'BOOKCODE=ITEM=1'
      'AUTHOR=ITEM=2'
      'DATE_ACQ=ITEM=3'
      'SUBJECT=ITEM=4'
      'BOOKID=ITEM=5'
      'REF=ITEM=6'
      'TITLE=ITEM=7'
      'SHORT=ITEM=8')
    RefreshAction = raKeepDataPosOrRowNum
    BeforePost = MarkedBooksQueryBeforePost
    CommitAction = caRefresh
    Left = 198
    Top = 256
  end
  object RefsByBookPageQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT R.REFID'
      '     , R.BOOKCODE'
      '     , R.ORGCODE'
      '     , N.NAME'
      '     , R.PAGENO'
      '     , R.REFCODE'
      '     , R.VOLUME'
      '     , R.NOTES'
      'FROM BOOKREFS R'
      'JOIN ORGNAMES N'
      'ON N.ORGCODE=R.ORGCODE'
      'WHERE (R.BOOKCODE = :bookcode)'
      'AND (R.VOLUME LIKE :volume)'
      'AND (R.PAGENO > :lowpageno)'
      'AND (R.PAGENO < :highpageno)'
      'AND (N.PREFERRED<>0)')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKREFS BOOKREFS'
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE BOOKREFS BOOKREFS SET'
      '   BOOKREFS.BOOKCODE = :BOOKCODE,'
      '   BOOKREFS.VOLUME = :VOLUME,'
      '   BOOKREFS.PAGENO = :PAGENO,'
      '   BOOKREFS.REFCODE = :REFCODE,'
      '   BOOKREFS.ORGCODE = :ORGCODE,'
      '   BOOKREFS.NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   REFCODE,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :REFCODE,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'BOOKREFS.REFID')
    KeyLinksAutoDefine = False
    Left = 40
    Top = 311
    ParamValues = (
      'BOOKCODE='#39'Japan handy guide 1'#39
      'VOLUME='#39'%'#39
      'PAGENO='#39'312'#39)
  end
  object RefsByBookPageDS: TIB_DataSource
    Dataset = RefsByBookPageQuery
    Left = 128
    Top = 342
  end
  object MarkedBooksDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = MarkedBooksQuery
    Left = 320
    Top = 264
  end
  object BookByCodeQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'where bookcode=:bookcode')
    AutoFetchAll = True
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.NOTES = :NOTES,'
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
      '   BOOKS."REF" = :"REF",'
      '   BOOKS.SUBJECT = :SUBJECT,'
      '   BOOKS.ISBN = :ISBN,'
      '   BOOKS.NUMBERPAGES = :NUMBERPAGES,'
      '   BOOKS.USEDBY = :USEDBY,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.MARKER = :MARKER,'
      '   BOOKS.SHORTCODE = :SHORTCODE'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   TITLE,'
      '   AUTHOR,'
      '   NOTES,'
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
      '   "REF",'
      '   SUBJECT,'
      '   ISBN,'
      '   NUMBERPAGES,'
      '   USEDBY,'
      '   PRINT,'
      '   MARKER,'
      '   SHORTCODE)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :TITLE,'
      '   :AUTHOR,'
      '   :NOTES,'
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
      '   :"REF",'
      '   :SUBJECT,'
      '   :ISBN,'
      '   :NUMBERPAGES,'
      '   :USEDBY,'
      '   :PRINT,'
      '   :MARKER,'
      '   :SHORTCODE)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    KeyLinksAutoDefine = False
    RequestLive = True
    Left = 30
    Top = 120
    ParamValues = (
      'BOOKCODE='#39'Bon'#39)
  end
  object BookByCodeDS: TIB_DataSource
    Left = 104
    Top = 144
  end
  object OrgsByNameQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGANISMS o'
      'JOIN ORGNAMES n'
      'ON n.ORGCODE = O.ORGCODE'
      'WHERE n.FULLNAME like :FULLNAME')
    Left = 407
    Top = 217
    ParamValues = (
      'NAME=')
  end
  object OrgsByNameQueryDS: TIB_DataSource
    Dataset = OrgsByNameQuery
    Left = 482
    Top = 243
  end
  object OrgsByGenusDS: TIB_DataSource
    Dataset = OrgsByGenusQuery
    Left = 312
    Top = 328
  end
  object OrgsByGenusQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsReadOnly.Strings = (
      'ORGID=TRUE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGNAMES N'
      'JOIN SPECIESGENUSLINK G'
      'ON N.ORGCODE=G.SPECIESCODE'
      'WHERE (G.GENUSCODE = :GENUS)'
      'AND (N.language='#39'la'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM ORGANISMS ORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE ORGANISMS ORGANISMS SET'
      '   ORGANISMS.ORGCODE = :ORGCODE,'
      '   ORGANISMS.COMMENTS = :COMMENTS,'
      '   ORGANISMS.CARD = :CARD,'
      '   ORGANISMS.FAMILY = :FAMILY'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO ORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY)')
    KeyLinks.Strings = (
      'ORGANISMS.ORGID')
    Left = 208
    Top = 318
    ParamValues = (
      'GENUS=')
  end
  object FungalBooksQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'BOOKCODE=104'
      'AUTHOR=206'
      'NOTES=0')
    FieldsReadOnly.Strings = (
      'BOOKID=TRUE')
    FieldsVisible.Strings = (
      'BOOKID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'WHERE USEDBY LIKE '#39'%F%'#39)
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.NOTES = :NOTES,'
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
      '   BOOKS.NUMBERPAGES = :NUMBERPAGES,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.MARKER = :MARKER,'
      '   BOOKS.USEDBY = :USEDBY'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   TITLE,'
      '   AUTHOR,'
      '   NOTES,'
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
      '   NUMBERPAGES,'
      '   PRINT,'
      '   MARKER,'
      '   USEDBY)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :TITLE,'
      '   :AUTHOR,'
      '   :NOTES,'
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
      '   :NUMBERPAGES,'
      '   :PRINT,'
      '   :MARKER,'
      '   :USEDBY)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'BOOKCODE=BOOKCODE;BOOKCODE DESC'
      'BOOKNAME=BOOKNAME;BOOKNAME DESC')
    OrderingLinks.Strings = (
      'BOOKCODE=ITEM=1'
      'BOOKNAME=ITEM=2')
    Left = 40
    Top = 416
  end
  object FungalBooksDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = FungalBooksQuery
    Left = 120
    Top = 398
  end
  object JapaneseBooksQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'BOOKCODE=104'
      'AUTHOR=206'
      'NOTES=0')
    FieldsReadOnly.Strings = (
      'BOOKID=TRUE')
    FieldsVisible.Strings = (
      'BOOKID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'WHERE (USEDBY LIKE :USEDBY)'
      'AND (PRINT LIKE :PRINT)')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.NOTES = :NOTES,'
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
      '   BOOKS.NUMBERPAGES = :NUMBERPAGES,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.MARKER = :MARKER,'
      '   BOOKS.USEDBY = :USEDBY'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   TITLE,'
      '   AUTHOR,'
      '   NOTES,'
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
      '   NUMBERPAGES,'
      '   PRINT,'
      '   MARKER,'
      '   USEDBY)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :TITLE,'
      '   :AUTHOR,'
      '   :NOTES,'
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
      '   :NUMBERPAGES,'
      '   :PRINT,'
      '   :MARKER,'
      '   :USEDBY)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'BOOKCODE=BOOKCODE;BOOKCODE DESC'
      'BOOKNAME=BOOKNAME;BOOKNAME DESC')
    OrderingLinks.Strings = (
      'BOOKCODE=ITEM=1'
      'BOOKNAME=ITEM=2')
    Left = 233
    Top = 384
  end
  object JapaneseBooksDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = JapaneseBooksQuery
    Left = 232
    Top = 448
  end
  object AllOrganismsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGANISMS')
    DeleteSQL.Strings = (
      'DELETE FROM ORGANISMS ORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE ORGANISMS ORGANISMS SET'
      '   ORGANISMS.ORGCODE = :ORGCODE,'
      '   ORGANISMS.COMMENTS = :COMMENTS,'
      '   ORGANISMS.CARD = :CARD,'
      '   ORGANISMS.FAMILY = :FAMILY,'
      '   ORGANISMS.POLNO = :POLNO,'
      '   ORGANISMS.DATEMODIFIED = :DATEMODIFIED,'
      '   ORGANISMS.USEDBY = :USEDBY,'
      '   ORGANISMS.PREFERREDNAME = :PREFERREDNAME,'
      '   ORGANISMS.EPPTCHECK = :EPPTCHECK'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO ORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY,'
      '   POLNO,'
      '   DATEMODIFIED,'
      '   USEDBY,'
      '   PREFERREDNAME,'
      '   EPPTCHECK)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY,'
      '   :POLNO,'
      '   :DATEMODIFIED,'
      '   :USEDBY,'
      '   :PREFERREDNAME,'
      '   :EPPTCHECK)')
    KeyLinks.Strings = (
      'ORGANISMS.ORGID')
    KeyLinksAutoDefine = False
    Left = 584
    Top = 32
  end
  object FamilyByOrgQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT GF.FAMILYCODE'
      'FROM GENUSFAMILYLINK GF'
      'INNER JOIN SPECIESGENUSLINK SG'
      'ON GF.GENUSCODE=SG.GENUSCODE'
      'WHERE (SG.SPECIESCODE=:SPECIESCODE)')
    EditSQL.Strings = (
      '')
    ReadOnly = True
    Left = 672
    Top = 16
    ParamValues = (
      'SPECIESCODE='#39'AAELI'#39)
  end
  object FamilyByOrgDS: TIB_DataSource
    Dataset = FamilyByOrgQuery
    Left = 672
    Top = 80
  end
  object TestJPOrgsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM JPORGS')
    DeleteSQL.Strings = (
      'DELETE FROM JPORGS JPORGS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE JPORGS JPORGS SET'
      '   JPORGS.ORGCODE = :ORGCODE,'
      '   JPORGS.IMS = :IMS,'
      '   JPORGS.COMMENTS = :COMMENTS,'
      '   JPORGS.FAMILY = :FAMILY'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO JPORGS('
      '   ORGCODE,'
      '   IMS,'
      '   COMMENTS,'
      '   FAMILY)'
      'VALUES ('
      '   :ORGCODE,'
      '   :IMS,'
      '   :COMMENTS,'
      '   :FAMILY)')
    KeyLinks.Strings = (
      'JPORGS.ORGID')
    Left = 464
    Top = 384
  end
  object GenusBySpeciesQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT GENUSCODE'
      'FROM SPECIESGENUSLINK'
      'where (SPECIESCODE=:speciescode)'
      '')
    Left = 616
    Top = 152
    ParamValues = (
      'SPECIESCODE='#39'AAELI'#39)
  end
  object GenusBySpeciesDS: TIB_DataSource
    Dataset = GenusBySpeciesQuery
    Left = 696
    Top = 184
  end
  object OrgsByFamilyQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'N.ORGCODE=92')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT N.ORGCODE, N.name, O.DATEMODIFIED'
      'FROM ORGNAMES N'
      'JOIN ORGANISMS O'
      'ON N.ORGCODE=O.ORGCODE'
      'WHERE (O.FAMILY=:FAMILY)'
      'AND (N.PREFERRED<>0)')
    Left = 640
    Top = 247
    ParamValues = (
      'FAMILY='#39'HELO'#39)
  end
  object OrgsByFamilyDS: TIB_DataSource
    Dataset = OrgsByFamilyQuery
    Left = 736
    Top = 256
  end
  object Links: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT * '
      'FROM LINKS')
    DeleteSQL.Strings = (
      'DELETE FROM LINKS LINKS'
      'WHERE'
      '   LINKID = :OLD_LINKID')
    EditSQL.Strings = (
      'UPDATE LINKS LINKS SET'
      '   LINKS.LINKID = :LINKID, /*PK*/'
      '   LINKS.CODEID = :CODEID,'
      '   LINKS.CODE = :CODE,'
      '   LINKS.DATATYPE = :DATATYPE,'
      '   LINKS.IDLINKCODE = :IDLINKCODE,'
      '   LINKS.CODEID_PARENT = :CODEID_PARENT,'
      '   LINKS.CODEPARENT = :CODEPARENT,'
      '   LINKS.DATATYPE_PARENT = :DATATYPE_PARENT,'
      '   LINKS.STATUSLINK = :STATUSLINK,'
      '   LINKS.CREATIONLINK = :CREATIONLINK,'
      '   LINKS.MODIFICATIONLINK = :MODIFICATIONLINK'
      'WHERE'
      '   LINKID = :OLD_LINKID')
    InsertSQL.Strings = (
      'INSERT INTO LINKS('
      '   LINKID, /*PK*/'
      '   CODEID,'
      '   CODE,'
      '   DATATYPE,'
      '   IDLINKCODE,'
      '   CODEID_PARENT,'
      '   CODEPARENT,'
      '   DATATYPE_PARENT,'
      '   STATUSLINK,'
      '   CREATIONLINK,'
      '   MODIFICATIONLINK)'
      'VALUES ('
      '   :LINKID,'
      '   :CODEID,'
      '   :CODE,'
      '   :DATATYPE,'
      '   :IDLINKCODE,'
      '   :CODEID_PARENT,'
      '   :CODEPARENT,'
      '   :DATATYPE_PARENT,'
      '   :STATUSLINK,'
      '   :CREATIONLINK,'
      '   :MODIFICATIONLINK)')
    Left = 600
    Top = 344
  end
  object AllOrganismsDS: TIB_DataSource
    Dataset = AllOrganismsQuery
    Left = 592
    Top = 88
  end
  object TestJPRefsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM JPBOOKREFS')
    DeleteSQL.Strings = (
      'DELETE FROM JPBOOKREFS JPBOOKREFS'
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE JPBOOKREFS JPBOOKREFS SET'
      '   JPBOOKREFS.BOOKCODE = :BOOKCODE,'
      '   JPBOOKREFS.VOLUME = :VOLUME,'
      '   JPBOOKREFS.PAGENO = :PAGENO,'
      '   JPBOOKREFS.ORGCODE = :ORGCODE,'
      '   JPBOOKREFS.NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO JPBOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'JPBOOKREFS.REFID')
    Left = 552
    Top = 371
    ParamValues = (
      'ORGCODE=')
  end
  object TestJPNamesByOrgQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM JPNAMES'
      'WHERE orgcode = :orgcode')
    DeleteSQL.Strings = (
      'DELETE FROM JPNAMES JPNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE JPNAMES JPNAMES SET'
      '   JPNAMES.ORGCODE = :ORGCODE,'
      '   JPNAMES.FULLNAME = :FULLNAME,'
      '   JPNAMES.AUTHORITY = :AUTHORITY,'
      '   JPNAMES.LANGUAGE = :LANGUAGE,'
      '   JPNAMES.COMMENTS = :COMMENTS,'
      '   JPNAMES.PREFERRED = :PREFERRED'
      '   JPNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO JPNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   LANGUAGE,'
      '   COMMENTS,'
      '   PREFERRED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :LANGUAGE,'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'JPNAMES.NAMEID')
    KeyLinksAutoDefine = False
    Left = 632
    Top = 408
  end
  object BookByShortCodeQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'WHERE SHORTCODE=:SHORTCODE')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    Left = 352
    Top = 408
  end
  object BooksCursor: TIB_Cursor
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    Left = 752
    Top = 144
  end
  object FamilyByGenusQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM GENUSFAMILYLINK'
      'where (GENUSCODE=:genuscode)'
      'AND (FAMILYCODE='#39'1%F'#39')')
    Left = 568
    Top = 208
    ParamValues = (
      'GENUSCODE='#39'1AAEG'#39)
  end
  object AllNamesDS: TIB_DataSource
    Left = 752
    Top = 88
  end
  object AllFamiliesQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM FAMILIES')
    DeleteSQL.Strings = (
      'DELETE FROM FAMILIES FAMILIES'
      'WHERE'
      '   FAMILYID = :OLD_FAMILYID')
    EditSQL.Strings = (
      'UPDATE FAMILIES FAMILIES SET'
      '   FAMILIES.FAMILYCODE = :FAMILYCODE,'
      '   FAMILIES.FAMILYNAME = :FAMILYNAME'
      'WHERE'
      '   FAMILYID = :OLD_FAMILYID')
    InsertSQL.Strings = (
      'INSERT INTO FAMILIES('
      '   FAMILYCODE,'
      '   FAMILYNAME)'
      'VALUES ('
      '   :FAMILYCODE,'
      '   :FAMILYNAME)')
    KeyLinks.Strings = (
      'FAMILIES.FAMILYID')
    KeyLinksAutoDefine = False
    Left = 753
    Top = 345
  end
  object AllFamiliesDS: TIB_DataSource
    Dataset = AllFamiliesQuery
    Left = 744
    Top = 408
  end
  object AllPageRefsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKREFS')
    ConfirmDeletePrompt.Strings = (
      'Delete?')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKREFS BOOKREFS'
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE BOOKREFS BOOKREFS SET'
      '   BOOKREFS.BOOKCODE = :BOOKCODE,'
      '   BOOKREFS.VOLUME = :VOLUME,'
      '   BOOKREFS.PAGENO = :PAGENO,'
      '   BOOKREFS.ORGCODE = :ORGCODE,'
      '   BOOKREFS.NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'BOOKREFS.REFID')
    KeyLinksAutoDefine = False
    Left = 16
    Top = 360
  end
  object OrgsByUseQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGANISMS'
      'WHERE USEDBY like :use '
      '')
    DeleteSQL.Strings = (
      'DELETE FROM ORGANISMS ORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE ORGANISMS ORGANISMS SET'
      '   ORGANISMS.ORGCODE = :ORGCODE,'
      '   ORGANISMS.COMMENTS = :COMMENTS,'
      '   ORGANISMS.CARD = :CARD,'
      '   ORGANISMS.FAMILY = :FAMILY,'
      '   ORGANISMS.POLNO = :POLNO,'
      '   ORGANISMS.DATEMODIFIED = :DATEMODIFIED,'
      '   ORGANISMS.USEDBY = :USEDBY,'
      '   ORGANISMS.PREFERREDNAME = :PREFERREDNAME,'
      '   ORGANISMS.EPPTVALIDATE = :EPPTVALIDATE'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO ORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY,'
      '   POLNO,'
      '   DATEMODIFIED,'
      '   USEDBY,'
      '   PREFERREDNAME,'
      '   EPPTVALIDATE)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY,'
      '   :POLNO,'
      '   :DATEMODIFIED,'
      '   :USEDBY,'
      '   :PREFERREDNAME,'
      '   :EPPTVALIDATE)')
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'CODE=ORGCODE; ORGCODE DESC'
      'POLNO=POLNO; POLNO DESC'
      'PREFNAME=PREFERREDNAME ; PREFERREDNAME DESC ')
    OrderingLinks.Strings = (
      'ORGCODE=ITEM=1'
      'POLNO=ITEM=2'
      'PREFERREDNAME=ITEM=3')
    Left = 491
    Top = 301
    ParamValues = (
      'USE='#39'F'#39)
  end
  object AllPlantsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGANISMS'
      'WHERE ORGCODE LIKE '#39'_____ '#39)
    Left = 571
    Top = 303
  end
  object AllEUPlantNamesDS: TIB_DataSource
    Dataset = AllEUPlantNames
    Left = 488
    Top = 8
  end
  object TestEURefsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUROBOOKREFS')
    DeleteSQL.Strings = (
      'DELETE FROM EUROBOOKREFS EUROBOOKREFS'
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE EUROBOOKREFS EUROBOOKREFS SET'
      '   EUROBOOKREFS.ORGCODE = :ORGCODE,'
      '   EUROBOOKREFS.BOOKCODE = :BOOKCODE,'
      '   EUROBOOKREFS.VOLUME = :VOLUME,'
      '   EUROBOOKREFS.PAGENO = :PAGENO,'
      '   EUROBOOKREFS.REFCODE = :REFCODE,'
      '   EUROBOOKREFS.NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO EUROBOOKREFS('
      '   ORGCODE,'
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   REFCODE,'
      '   NOTES)'
      'VALUES ('
      '   :ORGCODE,'
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :REFCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'EUROBOOKREFS.REFID')
    Left = 416
    Top = 464
  end
  object TestOrgsByUseQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGANISMS'
      'WHERE USEDBY like :use ')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGANISMS EUORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE EUORGANISMS EUORGANISMS SET'
      '   EUORGANISMS.ORGCODE = :ORGCODE,'
      '   EUORGANISMS.COMMENTS = :COMMENTS,'
      '   EUORGANISMS.CARD = :CARD,'
      '   EUORGANISMS.FAMILY = :FAMILY,'
      '   EUORGANISMS.POLNO = :POLNO,'
      '   EUORGANISMS.PREFERREDNAME = :PREFERREDNAME, '
      '   EUORGANISMS.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGANISMS.USEDBY = :USEDBY'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY,'
      '   POLNO,'
      '   PREFERREDNAME,'
      '   DATEMODIFIED,'
      '   USEDBY)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY,'
      '   :POLNO,'
      '   :PREFERREDNAME,'
      '   :DATEMODIFIED,'
      '   :USEDBY)')
    KeyLinks.Strings = (
      'EUORGANISMS.ORGID')
    OrderingItems.Strings = (
      'CODE=ORGCODE; ORGCODE DESC'
      'POLNO=POLNO; POLNO DESC'
      'PREFNAME=PREFERREDNAME ; PREFERREDNAME DESC ')
    OrderingLinks.Strings = (
      'ORGCODE=ITEM=1'
      'POLNO=ITEM=2'
      'PREFERREDNAME=ITEM=3')
    Left = 513
    Top = 452
    ParamValues = (
      'USE='#39'%FU%'#39)
  end
  object EuroBooksQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'BOOKCODE=104'
      'AUTHOR=206'
      'NOTES=0')
    FieldsReadOnly.Strings = (
      'BOOKID=TRUE')
    FieldsVisible.Strings = (
      'BOOKID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM BOOKS'
      'WHERE USEDBY LIKE '#39'%E%'#39)
    DeleteSQL.Strings = (
      'DELETE FROM BOOKS BOOKS'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    EditSQL.Strings = (
      'UPDATE BOOKS BOOKS SET'
      '   BOOKS.BOOKCODE = :BOOKCODE,'
      '   BOOKS.TITLE = :TITLE,'
      '   BOOKS.AUTHOR = :AUTHOR,'
      '   BOOKS.NOTES = :NOTES,'
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
      '   BOOKS.NUMBERPAGES = :NUMBERPAGES,'
      '   BOOKS.PRINT = :PRINT,'
      '   BOOKS.MARKER = :MARKER,'
      '   BOOKS.USEDBY = :USEDBY'
      'WHERE'
      '   BOOKID = :OLD_BOOKID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKS('
      '   BOOKCODE,'
      '   TITLE,'
      '   AUTHOR,'
      '   NOTES,'
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
      '   NUMBERPAGES,'
      '   PRINT,'
      '   MARKER,'
      '   USEDBY)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :TITLE,'
      '   :AUTHOR,'
      '   :NOTES,'
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
      '   :NUMBERPAGES,'
      '   :PRINT,'
      '   :MARKER,'
      '   :USEDBY)')
    KeyLinks.Strings = (
      'BOOKS.BOOKID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'BOOKCODE=BOOKCODE;BOOKCODE DESC'
      'BOOKNAME=BOOKNAME;BOOKNAME DESC')
    OrderingLinks.Strings = (
      'BOOKCODE=ITEM=1'
      'BOOKNAME=ITEM=2')
    Left = 128
    Top = 460
  end
  object OrgRefInSourceQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUROBOOKREFS'
      'WHERE (ORGCODE = :orgcode)'
      '     and (BOOKCODE = :bookcode)')
    ConfirmDeletePrompt.Strings = (
      'Delete?')
    DeleteSQL.Strings = (
      'DELETE FROM BOOKREFS BOOKREFS'
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE BOOKREFS BOOKREFS SET'
      '   BOOKREFS.BOOKCODE = :BOOKCODE,'
      '   BOOKREFS.VOLUME = :VOLUME,'
      '   BOOKREFS.PAGENO = :PAGENO,'
      '   BOOKREFS.ORGCODE = :ORGCODE,'
      '   BOOKREFS.NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO BOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'EUROBOOKREFS.REFID')
    KeyLinksAutoDefine = False
    Left = 40
    Top = 488
    ParamValues = (
      'ORGCODE='
      'BOOKCODE=')
  end
  object AllLanguagesQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM LANGUAGES'
      '')
    KeyLinks.Strings = (
      'LANGUAGES.LANGID ')
    OrderingItems.Strings = (
      'SORTORDER=SORTORDER; SORTORDER DESC'
      'CODE=LANGCODE; LANGCODE DESC')
    OrderingLinks.Strings = (
      'SORTORDER=ITEM=1'
      'LANGCODE=ITEM=2')
    Left = 668
    Top = 313
  end
  object AllLanguagesDS: TIB_DataSource
    Dataset = AllLanguagesQuery
    Left = 421
    Top = 315
  end
  object PlantCardQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'PLANTCODE=100')
    FieldsEditMask.Strings = (
      'PLANTCODE=LLLLL')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM PLANTCARDS')
    DeleteSQL.Strings = (
      'DELETE FROM PLANTCARDS PLANTCARDS'
      'WHERE'
      '   CARDID = :OLD_CARDID')
    EditSQL.Strings = (
      'UPDATE PLANTCARDS PLANTCARDS SET'
      '   PLANTCARDS.PLANTCODE = :PLANTCODE,'
      '   PLANTCARDS.FORM = :FORM,'
      '   PLANTCARDS.MINSIZE = :MINSIZE,'
      '   PLANTCARDS.MAXSIZE = :MAXSIZE,'
      '   PLANTCARDS.MEDIUM = :MEDIUM,'
      '   PLANTCARDS.ENDEMIC = :ENDEMIC,'
      '   PLANTCARDS.GUILD = :GUILD,'
      '   PLANTCARDS.VULNERABILITY = :VULNERABILITY,'
      '   PLANTCARDS.PROTECTION = :PROTECTION,'
      '   PLANTCARDS.FLOWERSTART = :FLOWERSTART,'
      '   PLANTCARDS.FLOWEREND = :FLOWEREND,'
      '   PLANTCARDS.MINALTITUDE = :MINALTITUDE,'
      '   PLANTCARDS.MAXALTITUDE = :MAXALTITUDE,'
      '   PLANTCARDS.WORLDDIST = :WORLDDIST,'
      '   PLANTCARDS.HABITAT = :HABITAT,'
      '   PLANTCARDS.PTSTATUS = :PTSTATUS,'
      '   PLANTCARDS.PTABUNDANCE = :PTABUNDANCE,'
      '   PLANTCARDS.PTPROVINCES = :PTPROVINCES,'
      '   PLANTCARDS.PTFLORISTIC = :PTFLORISTIC,'
      '   PLANTCARDS.AZSTATUS = :AZSTATUS,'
      '   PLANTCARDS.AZABUNDANCE = :AZABUNDANCE,'
      '   PLANTCARDS.AZISLANDS = :AZISLANDS,'
      '   PLANTCARDS.MDSTATUS = :MDSTATUS,'
      '   PLANTCARDS.MDABUNDANCE = :MDABUNDANCE,'
      '   PLANTCARDS.MDISLANDS = :MDISLANDS'
      'WHERE'
      '   CARDID = :OLD_CARDID')
    InsertSQL.Strings = (
      'INSERT INTO PLANTCARDS('
      '   PLANTCODE,'
      '   FORM,'
      '   MINSIZE,'
      '   MAXSIZE,'
      '   MEDIUM,'
      '   ENDEMIC,'
      '   GUILD,'
      '   VULNERABILITY,'
      '   PROTECTION,'
      '   FLOWERSTART,'
      '   FLOWEREND,'
      '   MINALTITUDE,'
      '   MAXALTITUDE,'
      '   WORLDDIST,'
      '   HABITAT,'
      '   PTSTATUS,'
      '   PTABUNDANCE,'
      '   PTPROVINCES,'
      '   PTFLORISTIC,'
      '   AZSTATUS,'
      '   AZABUNDANCE,'
      '   AZISLANDS,'
      '   MDSTATUS,'
      '   MDABUNDANCE,'
      '   MDISLANDS)'
      'VALUES ('
      '   :PLANTCODE,'
      '   :FORM,'
      '   :MINSIZE,'
      '   :MAXSIZE,'
      '   :MEDIUM,'
      '   :ENDEMIC,'
      '   :GUILD,'
      '   :VULNERABILITY,'
      '   :PROTECTION,'
      '   :FLOWERSTART,'
      '   :FLOWEREND,'
      '   :MINALTITUDE,'
      '   :MAXALTITUDE,'
      '   :WORLDDIST,'
      '   :HABITAT,'
      '   :PTSTATUS,'
      '   :PTABUNDANCE,'
      '   :PTPROVINCES,'
      '   :PTFLORISTIC,'
      '   :AZSTATUS,'
      '   :AZABUNDANCE,'
      '   :AZISLANDS,'
      '   :MDSTATUS,'
      '   :MDABUNDANCE,'
      '   :MDISLANDS)')
    KeyLinks.Strings = (
      'PLANTCARDS.CARDID')
    KeyLinksAutoDefine = False
    Left = 53
    Top = 552
  end
  object ForayByCodeQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM FORAYS'
      'where foraycode=:foraycode')
    DeleteSQL.Strings = (
      'DELETE FROM FORAYS FORAYS'
      'WHERE'
      '   FORAYID = :OLD_FORAYID')
    EditSQL.Strings = (
      'UPDATE FORAYS FORAYS SET'
      '   FORAYS.FORAYCODE = :FORAYCODE,'
      '   FORAYS.FORAYNAME = :FORAYNAME,'
      '   FORAYS.FORAYDATE = :FORAYDATE,'
      '   FORAYS.FORAYCOUNTRY = :FORAYCOUNTRY,'
      '   FORAYS.FORAYPLACE = :FORAYPLACE,'
      '   FORAYS.FORAYCOMMENTS = :FORAYCOMMENTS'
      'WHERE'
      '   FORAYID = :OLD_FORAYID')
    InsertSQL.Strings = (
      'INSERT INTO FORAYS('
      '   FORAYCODE,'
      '   FORAYNAME,'
      '   FORAYDATE,'
      '   FORAYCOUNTRY,'
      '   FORAYPLACE,'
      '   FORAYCOMMENTS)'
      'VALUES ('
      '   :FORAYCODE,'
      '   :FORAYNAME,'
      '   :FORAYDATE,'
      '   :FORAYCOUNTRY,'
      '   :FORAYPLACE,'
      '   :FORAYCOMMENTS)')
    KeyLinks.Strings = (
      'FORAYS.FORAYID')
    KeyLinksAutoDefine = False
    Left = 152
    Top = 525
    ParamValues = (
      'FORAYCODE=')
  end
  object ForayByCodeDS: TIB_DataSource
    Left = 246
    Top = 553
  end
  object orgNamesByLanguageQuery: TIB_Query
    ColumnAttributes.Strings = (
      'NAME=BLANKISNULL'
      'LANGUAGE=BLANKISNULL')
    DatabaseName = 'LocalIMSDB'
    FieldsAlignment.Strings = (
      'LANGUAGE=CENTER'
      'LN=CENTER')
    FieldsCharCase.Strings = (
      'LANGUAGE=LOWER')
    FieldsDisplayLabel.Strings = (
      'COMMENTS=Comments')
    FieldsGridLabel.Strings = (
      'LN=No'
      'NAME=Name'
      'AUTHORITY=Authority'
      'LANGUAGE=Lang')
    FieldsDisplayWidth.Strings = (
      'LN=15'
      'LANGUAGE=25'
      'AUTHORITY=194'
      'COMMENTS=0'
      'NAME=200')
    FieldsEditMask.Strings = (
      'L'
      'LANGUAGE=L')
    FieldsReadOnly.Strings = (
      'NAMEID=TRUE')
    FieldsVisible.Strings = (
      'NAMEID=FALSE'
      'ORGCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGNAMES '
      'WHERE (ORGNAMES.ORGCODE = :orgcode)'
      'AND (ORGNAMES.LANGUAGE = :language)'
      'ORDER BY PREFERRED')
    AutoFetchAll = True
    DefaultValues.Strings = (
      'LN=0'
      'LANGUAGE=A')
    DeleteSQL.Strings = (
      'DELETE FROM ORGNAMES ORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE ORGNAMES ORGNAMES SET'
      '   ORGNAMES.ORGCODE = :ORGCODE,'
      '   ORGNAMES.FULLNAME = :FULLNAME,'
      '   ORGNAMES.AUTHORITY = :AUTHORITY,'
      '   ORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   ORGNAMES.COMMENTS = :COMMENTS,'
      '   ORGNAMES.PREFERRED = :PREFERRED,'
      '   ORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   ORGNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO ORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'ORGNAMES.NAMEID')
    OrderingItems.Strings = (
      'LANGUAGE=LANGUAGE;LANGUAGE DESC'
      'LN=LN;LN DESC')
    OrderingLinks.Strings = (
      'LANGUAGE=ITEM=1'
      'LN=ITEM=2')
    Left = 363
    Top = 524
    ParamValues = (
      'ORGCODE='#39'ROSSE'#39
      '"LANGUAGE"=')
  end
  object OrgNamesByLanguageDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = orgNamesByLanguageQuery
    Left = 510
    Top = 520
  end
  object NamesByOrgDS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Left = 733
    Top = 525
  end
  object TestEUOrgByCodeQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsCharCase.Strings = (
      'ORGCODE=UPPER')
    FieldsEditMask.Strings = (
      'ORGCODE=>LLLLL<A')
    FieldsReadOnly.Strings = (
      'ORGID=TRUE')
    FieldsVisible.Strings = (
      'ORGID=FALSE'
      'ORGCODE=TRUE'
      'IMS=TRUE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGANISMS'
      'WHERE ORGCODE=:orgcode')
    DefaultValues.Strings = (
      'IMS=True')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGANISMS EUORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE EUORGANISMS EUORGANISMS SET'
      '   EUORGANISMS.ORGCODE = :ORGCODE,'
      '   EUORGANISMS.COMMENTS = :COMMENTS,'
      '   EUORGANISMS.CARD = :CARD,'
      '   EUORGANISMS.FAMILY = :FAMILY,'
      '   EUORGANISMS.POLNO = :POLNO,'
      '   EUORGANISMS.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGANISMS.USEDBY = :USEDBY,'
      '   EUORGANISMS.PREFERREDNAME = :PREFERREDNAME,'
      '   EUORGANISMS.EPPTVALIDATE = :EPPTVALIDATE'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY,'
      '   POLNO,'
      '   DATEMODIFIED,'
      '   USEDBY,'
      '   PREFERREDNAME,'
      '   EPPTVALIDATE)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY,'
      '   :POLNO,'
      '   :DATEMODIFIED,'
      '   :USEDBY,'
      '   :PREFERREDNAME,'
      '   :EPPTVALIDATE)')
    KeyLinks.Strings = (
      'EUORGANISMS.ORGID')
    KeyLinksAutoDefine = False
    Left = 513
    Top = 599
    ParamValues = (
      'ORGCODE=')
  end
  object NamesByOrgQuery: TIB_Query
    ColumnAttributes.Strings = (
      'NAME=BLANKISNULL'
      'LANGUAGE=BLANKISNULL')
    DatabaseName = 'LocalIMSDB'
    FieldsAlignment.Strings = (
      'LANGUAGE=CENTER'
      'LN=CENTER')
    FieldsCharCase.Strings = (
      'LANGUAGE=LOWER')
    FieldsDisplayLabel.Strings = (
      'COMMENTS=Comments')
    FieldsGridLabel.Strings = (
      'LN=No'
      'NAME=Name'
      'AUTHORITY=Authority'
      'LANGUAGE=Lang')
    FieldsDisplayWidth.Strings = (
      'LN=15'
      'LANGUAGE=25'
      'AUTHORITY=194'
      'COMMENTS=0'
      'NAME=200'
      'PREFERRED=106')
    FieldsEditMask.Strings = (
      'L'
      'LANGUAGE=L')
    FieldsReadOnly.Strings = (
      'NAMEID=TRUE')
    FieldsVisible.Strings = (
      'NAMEID=FALSE'
      'ORGCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGNAMES '
      'WHERE ORGNAMES.ORGCODE = :orgcode')
    AutoFetchAll = True
    DefaultValues.Strings = (
      'LN=0'
      'LANGUAGE=A')
    DeleteSQL.Strings = (
      'DELETE FROM ORGNAMES ORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE ORGNAMES ORGNAMES SET'
      '   ORGNAMES.ORGCODE = :ORGCODE,'
      '   ORGNAMES.FULLNAME = :FULLNAME,'
      '   ORGNAMES.AUTHORITY = :AUTHORITY,'
      '   ORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   ORGNAMES.COMMENTS = :COMMENTS,'
      '   ORGNAMES.PREFERRED = :PREFERRED,'
      '   ORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   ORGNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO ORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'ORGNAMES.NAMEID')
    OrderingItems.Strings = (
      'FULLNAME=FULLNAME;FULLNAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE DESC')
    OrderingLinks.Strings = (
      'FULLNAME=1'
      'LANGUAGE=2')
    Left = 625
    Top = 565
    ParamValues = (
      'ORGCODE='#39'ABIAL'#39)
  end
  object AllNamesQuery: TIB_Query
    ColumnAttributes.Strings = (
      'PREFERRED=BOOLEAN='#39',0'#39)
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM ORGNAMES')
    DeleteSQL.Strings = (
      'DELETE FROM ORGNAMES ORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE ORGNAMES ORGNAMES SET'
      '   ORGNAMES.ORGCODE = :ORGCODE,'
      '   ORGNAMES.FULLNAME = :FULLNAME,'
      '   ORGNAMES.AUTHORITY = :AUTHORITY,'
      '   ORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   ORGNAMES.COMMENTS = :COMMENTS,'
      '   ORGNAMES.PREFERRED = :PREFERRED'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO ORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED)')
    KeyLinks.Strings = (
      'ORGNAMES.NAMEID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'CODE=ORGCODE;ORGCODE DESC'
      'FULLNAME=FULLNAME;FULLNAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE')
    OrderingLinks.Strings = (
      'CODE=ITEM=1'
      'FULLNAME=ITEM=2'
      'LANGUAGE=ITEM=3')
    ReadOnly = True
    Left = 751
    Top = 32
  end
  object TestEUNamesByOrgLangQuery: TIB_Query
    ColumnAttributes.Strings = (
      'PREFERRED=BOOLEAN;'
      'ORGCODE=NOCASE')
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayLabel.Strings = (
      'LANGUAGE=Lang'
      'ORGCODE=Code'
      'NAME=Name'
      'AUTHORITY=Author'
      'DATEMODIFIED=Date modified'
      'PREFERRED=P'
      'COMMENTS=Comments')
    FieldsDisplayWidth.Strings = (
      '"LANGUAGE"=60'
      'PREFERRED=30'
      'NAME=300')
    FieldsReadOnly.Strings = (
      'NAMEID=TRUE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGNAMES'
      
        'where (EUORGNAMES.orgcode=:orgcode) and (EUORGNAMES.language=:la' +
        'nguage)'
      'ORDER BY EUORGNAMES.PREFERRED')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGNAMES EUORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE EUORGNAMES EUORGNAMES SET'
      '   EUORGNAMES.ORGCODE = :ORGCODE,'
      '   EUORGNAMES.FULLNAME = :FULLNAME,'
      '   EUORGNAMES.AUTHORITY = :AUTHORITY,'
      '   EUORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   EUORGNAMES.COMMENTS = :COMMENTS,'
      '   EUORGNAMES.PREFERRED = :PREFERRED,'
      '   EUORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'EUORGNAMES.NAMEID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'CODE=ORGCODE;ORGCODE DESC'
      'FULLNAME=FULLNAME;FULLNAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE')
    OrderingLinks.Strings = (
      'CODE=1'
      'FULLNAME=2'
      'LANGUAGE=3')
    Left = 253
    Top = 631
    ParamValues = (
      'ORGCODE='
      '"LANGUAGE"=')
  end
  object TestEUNamesByOrgQuery: TIB_Query
    ColumnAttributes.Strings = (
      'NAME=BLANKISNULL'
      'LANGUAGE=BLANKISNULL')
    DatabaseName = 'LocalIMSDB'
    FieldsAlignment.Strings = (
      'LANGUAGE=CENTER'
      'LN=CENTER')
    FieldsCharCase.Strings = (
      'LANGUAGE=LOWER')
    FieldsDisplayLabel.Strings = (
      'COMMENTS=Comments')
    FieldsGridLabel.Strings = (
      'LN=No'
      'NAME=Name'
      'AUTHORITY=Authority'
      'LANGUAGE=Lang')
    FieldsDisplayWidth.Strings = (
      'LN=15'
      'LANGUAGE=25'
      'AUTHORITY=194'
      'COMMENTS=0'
      'NAME=200'
      'PREFERRED=106')
    FieldsEditMask.Strings = (
      'L'
      'LANGUAGE=L')
    FieldsReadOnly.Strings = (
      'NAMEID=TRUE')
    FieldsVisible.Strings = (
      'NAMEID=FALSE'
      'ORGCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGNAMES'
      'WHERE EUORGNAMES.ORGCODE = :orgcode')
    AutoFetchAll = True
    DefaultValues.Strings = (
      'LN=0'
      'LANGUAGE=A')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGNAMES EUORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE EUORGNAMES EUORGNAMES SET'
      '   EUORGNAMES.ORGCODE = :ORGCODE,'
      '   EUORGNAMES.FULLNAME = :FULLNAME,'
      '   EUORGNAMES.AUTHORITY = :AUTHORITY,'
      '   EUORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   EUORGNAMES.COMMENTS = :COMMENTS,'
      '   EUORGNAMES.PREFERRED = :PREFERRED,'
      '   EUORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'EUORGNAMES.NAMEID')
    OrderingItems.Strings = (
      'FULLNAME=FULLNAME;FULLNAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE DESC')
    OrderingLinks.Strings = (
      'FULLNAME=ITEM=1'
      'LANGUAGE=ITEM=2')
    Left = 813
    Top = 597
    ParamValues = (
      'ORGCODE='#39'ABIAL'#39)
  end
  object TestEUOrgsQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGANISMS')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGANISMS EUORGANISMS'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    EditSQL.Strings = (
      'UPDATE EUORGANISMS EUORGANISMS SET'
      '   EUORGANISMS.ORGCODE = :ORGCODE,'
      '   EUORGANISMS.COMMENTS = :COMMENTS,'
      '   EUORGANISMS.CARD = :CARD,'
      '   EUORGANISMS.FAMILY = :FAMILY,'
      '   EUORGANISMS.POLNO = :POLNO,'
      '   EUORGANISMS.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGANISMS.USEDBY = :USEDBY,'
      '   EUORGANISMS.PREFERREDNAME = :PREFERREDNAME,'
      '   EUORGANISMS.EPPTVALIDATE = :EPPTVALIDATE'
      'WHERE'
      '   ORGID = :OLD_ORGID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGANISMS('
      '   ORGCODE,'
      '   COMMENTS,'
      '   CARD,'
      '   FAMILY,'
      '   POLNO,'
      '   DATEMODIFIED,'
      '   USEDBY,'
      '   PREFERREDNAME,'
      '   EPPTVALIDATE)'
      'VALUES ('
      '   :ORGCODE,'
      '   :COMMENTS,'
      '   :CARD,'
      '   :FAMILY,'
      '   :POLNO,'
      '   :DATEMODIFIED,'
      '   :USEDBY,'
      '   :PREFERREDNAME,'
      '   :EPPTVALIDATE)')
    KeyLinks.Strings = (
      'EUORGANISMS.ORGID')
    KeyLinksAutoDefine = False
    Left = 341
    Top = 604
  end
  object TestEUNamesQuery: TIB_Query
    ColumnAttributes.Strings = (
      'PREFERRED=BOOLEAN='#39',0'#39)
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGNAMES')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGNAMES EUORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE EUORGNAMES EUORGNAMES SET'
      '   EUORGNAMES.ORGCODE = :ORGCODE,'
      '   EUORGNAMES.FULLNAME = :FULLNAME,'
      '   EUORGNAMES.AUTHORITY = :AUTHORITY,'
      '   EUORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   EUORGNAMES.COMMENTS = :COMMENTS,'
      '   EUORGNAMES.PREFERRED = :PREFERRED,'
      '   EUORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'EUORGNAMES.NAMEID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'CODE=ORGCODE;ORGCODE DESC'
      'FULLNAME=FULLNAME;FULLNAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE')
    OrderingLinks.Strings = (
      'CODE=ITEM=1'
      'FULLNAME=ITEM=2'
      'LANGUAGE=ITEM=3')
    Left = 159
    Top = 596
  end
  object TestEURefsByOrgQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'NOTES=0'
      'PAGENO=60'
      'VOLUME=60'
      'REFCODE=80')
    FieldsVisible.Strings = (
      'ORGCODE=FALSE'
      'REFID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUROBOOKREFS'
      'WHERE ORGCODE=:orgcode'
      'ORDER BY BOOKCODE')
    DeleteSQL.Strings = (
      'DELETE FROM EUROBOOKREFS EUROBOOKREFS'
      'WHERE'
      '   EUROBOOKREFS.REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE EUROBOOKREFS EUROBOOKREFS SET'
      '   EUROBOOKREFS.ORGCODE = :ORGCODE,'
      '   EUROBOOKREFS.BOOKCODE = :BOOKCODE,'
      '   EUROBOOKREFS.PAGENO = :PAGENO,'
      '   EUROBOOKREFS.REFCODE = :REFCODE,'
      '   EUROBOOKREFS.NOTES = :NOTES,'
      '   EUROBOOKREFS.VOLUME = :VOLUME,'
      '   EUROBOOKREFS.DATEMODIFIED = :DATEMODIFIED'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO EUROBOOKREFS('
      '   ORGCODE,'
      '   BOOKCODE,'
      '   PAGENO,'
      '   REFCODE,'
      '   NOTES,'
      '   VOLUME,'
      '   DATEMODIFIED)'
      'VALUES ('
      '   :ORGCODE,'
      '   :BOOKCODE,'
      '   :PAGENO,'
      '   :REFCODE,'
      '   :NOTES,'
      '   :VOLUME,'
      '   :DATEMODIFIED)')
    KeyLinks.Strings = (
      'EUROBOOKREFS.REFID')
    KeyLinksAutoDefine = False
    RefreshAction = raKeepDataPosOrRowNum
    CommitAction = caRefresh
    Left = 415
    Top = 576
    ParamValues = (
      'ORGCODE='#39'FANCY'#39)
  end
  object TestEUOrgNamesROQuery: TIB_Query
    ColumnAttributes.Strings = (
      'NAME=BLANKISNULL'
      'LANGUAGE=BLANKISNULL')
    DatabaseName = 'LocalIMSDB'
    FieldsAlignment.Strings = (
      'LANGUAGE=CENTER'
      'LN=CENTER')
    FieldsCharCase.Strings = (
      'LANGUAGE=LOWER')
    FieldsDisplayLabel.Strings = (
      'COMMENTS=Comments')
    FieldsGridLabel.Strings = (
      'LN=No'
      'NAME=Name'
      'AUTHORITY=Authority'
      'LANGUAGE=Lang')
    FieldsDisplayWidth.Strings = (
      'LN=15'
      'LANGUAGE=25'
      'AUTHORITY=194'
      'COMMENTS=0'
      'NAME=200'
      'PREFERRED=106')
    FieldsEditMask.Strings = (
      'L'
      'LANGUAGE=L')
    FieldsReadOnly.Strings = (
      'NAMEID=TRUE')
    FieldsVisible.Strings = (
      'NAMEID=FALSE'
      'ORGCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT *'
      'FROM EUORGNAMES '
      'WHERE EUORGNAMES.ORGCODE = :orgcode')
    AutoFetchAll = True
    DefaultValues.Strings = (
      'LN=0'
      'LANGUAGE=A')
    DeleteSQL.Strings = (
      'DELETE FROM EUORGNAMES EUORGNAMES'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    EditSQL.Strings = (
      'UPDATE EUORGNAMES EUORGNAMES SET'
      '   EUORGNAMES.ORGCODE = :ORGCODE,'
      '   EUORGNAMES.FULLNAME = :FULLNAME,'
      '   EUORGNAMES.AUTHORITY = :AUTHORITY,'
      '   EUORGNAMES."LANGUAGE" = :"LANGUAGE",'
      '   EUORGNAMES.COMMENTS = :COMMENTS,'
      '   EUORGNAMES.PREFERRED = :PREFERRED,'
      '   EUORGNAMES.DATEMODIFIED = :DATEMODIFIED,'
      '   EUORGNAMES.EPPTSTATUS = :EPPTSTATUS'
      'WHERE'
      '   NAMEID = :OLD_NAMEID')
    InsertSQL.Strings = (
      'INSERT INTO EUORGNAMES('
      '   ORGCODE,'
      '   FULLNAME,'
      '   AUTHORITY,'
      '   "LANGUAGE",'
      '   COMMENTS,'
      '   PREFERRED,'
      '   DATEMODIFIED,'
      '   EPPTSTATUS)'
      'VALUES ('
      '   :ORGCODE,'
      '   :FULLNAME,'
      '   :AUTHORITY,'
      '   :"LANGUAGE",'
      '   :COMMENTS,'
      '   :PREFERRED,'
      '   :DATEMODIFIED,'
      '   :EPPTSTATUS)')
    KeyLinks.Strings = (
      'EUORGNAMES.NAMEID')
    OrderingItems.Strings = (
      'FULLNAME=FULLNAME;FULLNAME DESC'
      'LANGUAGE=LANGUAGE;LANGUAGE DESC')
    OrderingLinks.Strings = (
      'FULLNAME=1'
      'LANGUAGE=2')
    ReadOnly = True
    Left = 40
    Top = 605
    ParamValues = (
      'ORGCODE='#39'ABIAL'#39)
  end
  object TestEURefsByBookQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'NOTES=0'
      'PAGENO=60'
      'VOLUME=60')
    FieldsVisible.Strings = (
      'ORGCODE=FALSE'
      'REFID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT N.FULLNAME'
      '     , R.REFID'
      '     , R.BOOKCODE'
      '     , R.VOLUME'
      '     , R.PAGENO'
      '     , R.REFCODE'
      '     , R.ORGCODE'
      '     , R.NOTES'
      'FROM EUROBOOKREFS R'
      'JOIN EUORGNAMES N '
      'ON N.ORGCODE = R.ORGCODE'
      'WHERE (R.BOOKCODE = :bookcode)'
      'AND (R.VOLUME like :volume)'
      'AND (N.PREFERRED<>0)'
      'ORDER BY N.FULLNAME')
    DeleteSQL.Strings = (
      'DELETE FROM EUROBOOKREFS '
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE EUROBOOKREFS SET'
      '   ORGCODE = :ORGCODE,'
      '   BOOKCODE = :BOOKCODE,'
      '   VOLUME = :VOLUME,'
      '   PAGENO = :PAGENO,'
      '   REFCODE = :REFCODE,'
      '   NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO EUROBOOKREFS('
      '   ORGCODE,'
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   REFCODE,'
      '   NOTES)'
      'VALUES ('
      '   :ORGCODE,'
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :REFCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'EUROBOOKREFS.REFID')
    KeyLinksAutoDefine = False
    RefreshAction = raKeepDataPosOrRowNum
    CommitAction = caRefresh
    Left = 635
    Top = 624
    ParamValues = (
      'BOOKCODE='#39'Mushrooms North America'#39
      'VOLUME='#39'%'#39)
  end
  object TestFindsByForayQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'FORAYCOMMENTS=0')
    FieldsReadOnly.Strings = (
      'FORAYID=TRUE')
    FieldsVisible.Strings = (
      'FORAYID=FALSE'
      'F.FORAYCODE=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT F.FINDID'
      '     , F.FORAYCODE'
      '     , F.ORGCODE'
      '     , O.PREFERREDNAME'
      '     , F.NOTES'
      'from FINDS F'
      'JOIN ORGANISMS O'
      'ON F.ORGCODE = O.ORGCODE'
      'where (F.foraycode = :foraycode)'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM FINDS F'
      'WHERE'
      '   FINDID = :OLD_FINDID')
    EditSQL.Strings = (
      'UPDATE FINDS F SET'
      '   F.FORAYCODE = :FORAYCODE,'
      '   F.ORGCODE = :ORGCODE,'
      '   F.NOTES = :NOTES'
      'WHERE'
      '   FINDID = :OLD_FINDID')
    InsertSQL.Strings = (
      'INSERT INTO FINDS('
      '   FORAYCODE,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :FORAYCODE,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'FINDS.FINDID')
    KeyLinksAutoDefine = False
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'O.PREFERREDNAME=O.PREFERREDNAME;O.PREFERREDNAME DESC '
      'F.ORGCODE=F.ORGCODE;F.ORGCODE DESC')
    OrderingLinks.Strings = (
      'O.PREFERREDNAME=ITEM=1'
      'F.ORGCODE=ITEM=2')
    Left = 266
    Top = 504
    ParamValues = (
      'FORAYCODE=')
  end
  object TestorgsByFamilyQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsDisplayWidth.Strings = (
      'N.ORGCODE=92')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT N.ORGCODE, N.name, O.DATEMODIFIED'
      'FROM EUORGNAMES N'
      'JOIN EUORGANISMS O'
      'ON N.ORGCODE=O.ORGCODE'
      'WHERE (O.FAMILY=:FAMILY)'
      'AND (N.PREFERRED<>0)')
    ReadOnly = True
    Left = 835
    Top = 510
    ParamValues = (
      'FAMILY='#39'HELO'#39)
  end
  object TestRefsbybookQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    FieldsVisible.Strings = (
      'R.REFID=FALSE')
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT N.NAME'
      '     , R.REFID'
      '     , R.BOOKCODE'
      '     , R.VOLUME'
      '     , R.PAGENO'
      '     , R.REFCODE'
      '     , R.ORGCODE'
      '     , R.NOTES'
      'FROM EUROBOOKREFS R'
      'JOIN EUORGNAMES N '
      'ON N.ORGCODE = R.ORGCODE'
      'WHERE (R.BOOKCODE = :bookcode)'
      'AND (R.VOLUME LIKE :volume)'
      'AND (N.PREFERRED<>0)'
      'ORDER BY N.NAME')
    DeleteSQL.Strings = (
      'DELETE FROM EUROBOOKREFS '
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE EUROBOOKREFS SET'
      '   BOOKCODE = :BOOKCODE,'
      '   VOLUME = :VOLUME,'
      '   PAGENO = :PAGENO,'
      '   REFCODE = :REFCODE,'
      '   ORGCODE = :ORGCODE,'
      '   NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO EUROBOOKREFS('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   REFCODE,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :REFCODE,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'EUROBOOKREFS.REFID')
    KeyLinksAutoDefine = False
    OrderingItems.Strings = (
      'Code=ORGCODE;ORGCODE DESC'
      'Name=NAME;NAME DESC'
      'Refcode=REFCODE;REFCODE DESC'
      'Pageno=PAGENO;PAGENO DESC')
    OrderingLinks.Strings = (
      'Code=1'
      'Name=2'
      'Refcode=3'
      'Pageno=4')
    CommitAction = caRefresh
    Left = 666
    Top = 473
    ParamValues = (
      'BOOKCODE='#39'Japan alien plants/animals'#39
      'VOLUME='#39'%'#39)
  end
  object TestJPRefsbybookPageQuery: TIB_Query
    DatabaseName = 'LocalIMSDB'
    IB_Connection = FBConnection
    SQL.Strings = (
      'SELECT R.BOOKCODE'
      '     , R.ORGCODE'
      '     , N.NAME'
      '     , R.PAGENO'
      '     , R.VOLUME'
      '     , R.NOTES'
      '     , R.REFCODE'
      '     , R.REFID'
      'FROM JPBOOKREFS R'
      'JOIN JPNAMES N'
      'ON N.ORGCODE=R.ORGCODE'
      'WHERE (R.BOOKCODE = :bookcode)'
      'AND (R.VOLUME like :volume)'
      'AND (R.PAGENO > :lowpageno)'
      'AND (R.PAGENO < :highpageno)'
      'AND (N.PREFERRED<>0)')
    DeleteSQL.Strings = (
      'DELETE FROM JPBOOKREFS '
      'WHERE'
      '   REFID = :OLD_REFID')
    EditSQL.Strings = (
      'UPDATE JPBOOKREFS SET'
      '   BOOKCODE = :BOOKCODE,'
      '   VOLUME = :VOLUME,'
      '   PAGENO = :PAGENO,'
      '   REFCODE = :REFCODE,'
      '   ORGCODE = :ORGCODE,'
      '   NOTES = :NOTES'
      'WHERE'
      '   REFID = :OLD_REFID')
    InsertSQL.Strings = (
      'INSERT INTO JPBOOKREFS ('
      '   BOOKCODE,'
      '   VOLUME,'
      '   PAGENO,'
      '   REFCODE,'
      '   ORGCODE,'
      '   NOTES)'
      'VALUES ('
      '   :BOOKCODE,'
      '   :VOLUME,'
      '   :PAGENO,'
      '   :REFCODE,'
      '   :ORGCODE,'
      '   :NOTES)')
    KeyLinks.Strings = (
      'EUROBOOKREFS.REFID')
    KeyLinksAutoDefine = False
    Left = 714
    Top = 579
    ParamValues = (
      'BOOKCODE='#39'Japan alien plants/animals'#39
      'VOLUME='#39'%'#39
      'PAGENO='#39'313'#39)
  end
end
