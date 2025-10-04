object dmDatabase: TdmDatabase
  OnCreate = DataModuleCreate
  Height = 600
  Width = 800
  object conDB: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=database.mdb;Mode=R' +
      'eadWrite;Persist Security Info=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 29
  end
  object tblQuizzes: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Quizzes'
    Left = 42
    Top = 94
  end
  object dsQuizzes: TDataSource
    DataSet = tblQuizzes
    Left = 104
    Top = 98
  end
  object tblQuestions: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Questions'
    Left = 42
    Top = 171
  end
  object dsQuestions: TDataSource
    DataSet = tblQuestions
    Left = 115
    Top = 174
  end
  object tblQCS: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'QuizCompletionSummary'
    Left = 49
    Top = 229
  end
  object dsQCS: TDataSource
    DataSet = tblQCS
    Left = 122
    Top = 232
  end
  object tblAnswers: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Answers'
    Left = 49
    Top = 293
  end
  object dsAnswers: TDataSource
    DataSet = tblAnswers
    Left = 122
    Top = 296
  end
  object tblDailyQuizzes: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'DailyQuizzes'
    Left = 49
    Top = 357
  end
  object dsDailyQuizzes: TDataSource
    DataSet = tblDailyQuizzes
    Left = 122
    Top = 360
  end
end
