object dmDatabase: TdmDatabase
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object conDB: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=database.mdb;Mode=R' +
      'eadWrite;Persist Security Info=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 50
    Top = 36
  end
  object tblQuizzes: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Quizzes'
    Left = 53
    Top = 118
  end
  object dsQuizzes: TDataSource
    DataSet = tblQuizzes
    Left = 130
    Top = 123
  end
  object tblQuestions: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Questions'
    Left = 53
    Top = 214
  end
  object dsQuestions: TDataSource
    DataSet = tblQuestions
    Left = 144
    Top = 218
  end
end
