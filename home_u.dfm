object frmHome: TfrmHome
  Left = 0
  Top = 0
  VertScrollBar.Size = 10
  VertScrollBar.Tracking = True
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = 'Home'
  ClientHeight = 910
  ClientWidth = 810
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  Visible = True
  ShowInTaskBar = True
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 89
    BevelOuter = bvNone
    BevelWidth = 4
    BorderWidth = 8
    ShowCaption = False
    TabOrder = 0
    object lblTitle: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 788
      Height = 67
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'QuizMaster'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCornflowerblue
      Font.Height = 40
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitTop = 17
    end
    object lblSubTitle: TLabel
      Left = 0
      Top = 61
      Width = 810
      Height = 17
      Align = alCustom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Interactive Flashcard-Style Quiz App for Students and Teachers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowFrame
      Font.Height = 15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object sbMainSrcoll: TScrollBox
    Left = 0
    Top = 84
    Width = 810
    Height = 829
    VertScrollBar.Increment = 5
    VertScrollBar.Range = 1000
    AutoScroll = False
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 1
    UseWheelForScrolling = True
    object cdpQuizzSelection: TCardPanel
      Left = 48
      Top = 450
      Width = 713
      Height = 1126
      Align = alCustom
      ActiveCard = crdMyQuizzes
      BevelEdges = []
      BevelOuter = bvNone
      TabOrder = 0
      object crdMyQuizzes: TCard
        Left = 0
        Top = 0
        Width = 713
        Height = 1126
        Caption = 'MyQuizzes'
        CardIndex = 0
        TabOrder = 0
        object pnlMyQuizzes: TPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 1000
          BevelEdges = []
          BevelOuter = bvNone
          TabOrder = 0
          object shpMyQuizzesMain: TShape
            Left = 0
            Top = 0
            Width = 713
            Height = 261
            Shape = stRoundRect
          end
          object shpMyQuizzesCreateCustomQuiz: TShape
            Left = 0
            Top = 267
            Width = 350
            Height = 70
            Shape = stRoundRect
          end
          object shpMyQuizzesCreateAIQuiz: TShape
            Left = 363
            Top = 267
            Width = 350
            Height = 70
            Shape = stRoundRect
          end
        end
      end
      object crdOnlineQuizzes: TCard
        Left = 0
        Top = 0
        Width = 713
        Height = 1126
        Caption = 'OnlineQuizzes'
        CardIndex = 1
        TabOrder = 1
        object pnlOnlineQuizzes: TPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 1000
          BevelEdges = []
          BevelOuter = bvNone
          TabOrder = 0
          object Shape1: TShape
            Left = 0
            Top = 0
            Width = 713
            Height = 170
            Shape = stRoundRect
          end
          object Shape2: TShape
            Left = 0
            Top = 216
            Width = 713
            Height = 241
            Shape = stRoundRect
          end
        end
      end
    end
    object pnlDailyQuiz: TPanel
      Left = 48
      Top = 116
      Width = 713
      Height = 297
      BevelEdges = []
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object lblDailyButtonSubtext: TLabel
        Left = 176
        Top = 271
        Width = 354
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Complete Daily Challenges To Build Your Learning Streak'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = 14
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object shpDailyQuiz: TShape
        Left = 0
        Top = 0
        Width = 713
        Height = 297
        Brush.Color = clSkyBlue
        Shape = stRoundRect
      end
      object pnlStartDaily: TPanel
        Left = 179
        Top = 200
        Width = 355
        Height = 65
        BevelOuter = bvNone
        TabOrder = 0
        object shpButtonStartDaily: TShape
          Left = 0
          Top = 0
          Width = 354
          Height = 65
          Brush.Color = clHighlight
          Shape = stRoundRect
          OnMouseDown = shpButtonStartDailyMouseDown
        end
        object lblButtonStartDaily: TLabel
          Left = 1
          Top = 20
          Width = 352
          Height = 30
          Align = alCustom
          Alignment = taCenter
          AutoSize = False
          Caption = 'Start Daily Challenge'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlightText
          Font.Height = 24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = lblButtonStartDailyClick
        end
      end
      object pnlDailyQuizInfo: TPanel
        Left = 16
        Top = 17
        Width = 497
        Height = 169
        BevelEdges = []
        BevelOuter = bvNone
        TabOrder = 1
        object imgDaily1: TImage
          Left = 8
          Top = 8
          Width = 33
          Height = 33
          Center = True
          Stretch = True
        end
        object imgDaily2: TImage
          Left = 8
          Top = 136
          Width = 25
          Height = 25
          Center = True
          Stretch = True
        end
        object lblDailyTitle: TLabel
          Left = 47
          Top = 0
          Width = 148
          Height = 28
          Caption = 'Daily Challenge'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = 28
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDailyAmntQuestions: TLabel
          Left = 39
          Top = 145
          Width = 61
          Height = 13
          Caption = '3 Questions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = 14
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblDailyDate: TLabel
          Left = 8
          Top = 56
          Width = 177
          Height = 21
          Caption = 'Daily Quiz - 2025-08-25'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = 22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDailyMotivation: TLabel
          Left = 47
          Top = 29
          Width = 187
          Height = 13
          Alignment = taCenter
          Caption = 'Complete a quiz to build your streak'
          Color = clHighlight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = 14
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblDailyTopic: TLabel
          Left = 8
          Top = 77
          Width = 81
          Height = 13
          Alignment = taCenter
          Caption = 'Topic: Literature'
          Color = clHighlight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = 14
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblDailyStreak: TLabel
          Left = 39
          Top = 108
          Width = 123
          Height = 15
          Caption = 'Current Streak: 0 days'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = 16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgDaily3: TImage
          Left = 8
          Top = 103
          Width = 25
          Height = 25
          Center = True
          Stretch = True
        end
      end
    end
    object pnlQuizSelector: TPanel
      Left = 48
      Top = 419
      Width = 713
      Height = 25
      BevelEdges = []
      BevelOuter = bvNone
      TabOrder = 2
      object sbtnMyQuizzes: TSpeedButton
        Left = 0
        Top = 0
        Width = 356
        Height = 25
        AllowAllUp = True
        GroupIndex = 1
        Down = True
        Caption = 'My Quizzes'
        OnClick = sbtnMyQuizzesClick
      end
      object sbtnOnlineQuizzes: TSpeedButton
        Left = 357
        Top = 0
        Width = 356
        Height = 25
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'Online Quizzes'
        OnClick = sbtnOnlineQuizzesClick
      end
    end
    object pnlStat1: TPanel
      Left = 48
      Top = 16
      Width = 161
      Height = 81
      BevelEdges = []
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 3
      object shpStat1: TShape
        Left = 0
        Top = 0
        Width = 161
        Height = 81
        Shape = stRoundRect
      end
      object lblStat1Num: TLabel
        Left = 16
        Top = 16
        Width = 82
        Height = 33
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 35
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStat1Text: TLabel
        Left = 16
        Top = 55
        Width = 89
        Height = 16
        AutoSize = False
        Caption = 'Saved Quizzes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowFrame
        Font.Height = 16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object imgStat1: TImage
        Left = 104
        Top = 16
        Width = 41
        Height = 41
        Center = True
        Stretch = True
      end
    end
    object pnlStat2: TPanel
      Left = 232
      Top = 15
      Width = 161
      Height = 82
      BevelEdges = []
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 4
      object shpStat2: TShape
        Left = 0
        Top = 0
        Width = 161
        Height = 81
        Shape = stRoundRect
      end
      object lblStat2Num: TLabel
        Left = 16
        Top = 16
        Width = 82
        Height = 33
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 35
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStat2Text: TLabel
        Left = 16
        Top = 55
        Width = 89
        Height = 16
        AutoSize = False
        Caption = 'Quizzes Taken'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowFrame
        Font.Height = 16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object imgStat2: TImage
        Left = 104
        Top = 16
        Width = 41
        Height = 41
        Center = True
        Stretch = True
      end
    end
    object pnlStat3: TPanel
      Left = 416
      Top = 16
      Width = 161
      Height = 81
      BevelEdges = []
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 6
      object shpStat3: TShape
        Left = 0
        Top = 0
        Width = 161
        Height = 81
        Shape = stRoundRect
      end
      object lblStat3Num: TLabel
        Left = 16
        Top = 16
        Width = 82
        Height = 33
        AutoSize = False
        Caption = '0%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 35
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStat3Text: TLabel
        Left = 16
        Top = 55
        Width = 89
        Height = 16
        AutoSize = False
        Caption = 'Average Score'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowFrame
        Font.Height = 16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object imgStat3: TImage
        Left = 104
        Top = 16
        Width = 41
        Height = 41
        Center = True
        Stretch = True
      end
    end
    object pnlStat4: TPanel
      Left = 600
      Top = 16
      Width = 161
      Height = 81
      BevelEdges = []
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 5
      object shpStat4: TShape
        Left = 0
        Top = 0
        Width = 161
        Height = 81
        Shape = stRoundRect
      end
      object lblStat4Num: TLabel
        Left = 16
        Top = 16
        Width = 82
        Height = 33
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 35
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStat4Text: TLabel
        Left = 16
        Top = 55
        Width = 121
        Height = 16
        AutoSize = False
        Caption = 'Questions Answered'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowFrame
        Font.Height = 16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object imgStat4: TImage
        Left = 104
        Top = 16
        Width = 41
        Height = 41
        Center = True
        Stretch = True
      end
    end
  end
end
