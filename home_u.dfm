object frmHome: TfrmHome
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = 'Home'
  ClientHeight = 900
  ClientWidth = 810
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowInTaskBar = True
  OnCreate = FormCreate
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
  object pnlStat1: TPanel
    Left = 48
    Top = 128
    Width = 161
    Height = 81
    BevelEdges = []
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
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
    Top = 127
    Width = 161
    Height = 82
    BevelEdges = []
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
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
    Top = 128
    Width = 161
    Height = 81
    BevelEdges = []
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 3
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
    Top = 128
    Width = 161
    Height = 81
    BevelEdges = []
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
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
  object pnlDailyQuiz: TPanel
    Left = 48
    Top = 240
    Width = 705
    Height = 297
    BevelEdges = []
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 5
    object shpDailyQuiz: TShape
      Left = 0
      Top = 0
      Width = 705
      Height = 297
      Brush.Color = clSkyBlue
      Shape = stRoundRect
    end
    object Button3: TButton
      Left = 169
      Top = 208
      Width = 360
      Height = 57
      Caption = 'Button1'
      StylusHotImageIndex = -2
      TabOrder = 0
      StyleName = 'Windows'
    end
  end
end
