object dmDatabase: TdmDatabase
  OnCreate = DataModuleCreate
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
  object tblQCS: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'QuizCompletionSummary'
    Left = 61
    Top = 286
  end
  object dsQCS: TDataSource
    DataSet = tblQCS
    Left = 153
    Top = 290
  end
  object tblAnswers: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Answers'
    Left = 61
    Top = 366
  end
  object dsAnswers: TDataSource
    DataSet = tblAnswers
    Left = 153
    Top = 370
  end
  object tblDailyQuizzes: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'DailyQuizzes'
    Left = 61
    Top = 446
  end
  object dsDailyQuizzes: TDataSource
    DataSet = tblDailyQuizzes
    Left = 153
    Top = 450
  end
  object tblStreak: TADOTable
    Connection = conDB
    CursorType = ctStatic
    TableName = 'Streak'
    Left = 61
    Top = 518
  end
  object dsStreak: TDataSource
    DataSet = tblStreak
    Left = 153
    Top = 522
  end
end
