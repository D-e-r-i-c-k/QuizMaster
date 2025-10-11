object frmResults: TfrmResults
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Results'
  ClientHeight = 911
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 809
    Height = 73
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelOuter = bvNone
    TabOrder = 0
    object lblQuizResultsHeader: TLabel
      Left = 20
      Top = 0
      Width = 95
      Height = 32
      Caption = 'Results: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = 32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuizResultsSubTitle: TLabel
      Left = 21
      Top = 38
      Width = 304
      Height = 17
      Caption = 'See all your results with AI marking the Text Answers'
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = 18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblQuizResult: TLabel
      Left = 658
      Top = 29
      Width = 58
      Height = 28
      Caption = '70,2%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = 28
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object sbxMain: TScrollBox
    Left = 0
    Top = 80
    Width = 809
    Height = 830
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    AutoScroll = False
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 1
    UseWheelForScrolling = True
    object pnlQuestion: TPanel
      Left = 21
      Top = 3
      Width = 764
      Height = 281
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object shpQuestionBG: TShape
        Left = 0
        Top = 0
        Width = 764
        Height = 281
        Brush.Color = clSalmon
        Shape = stRoundRect
      end
      object lblQuestionNumber: TLabel
        Left = 12
        Top = 7
        Width = 108
        Height = 28
        Caption = 'Question 1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = 28
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblUserAnswerHeader: TLabel
        Left = 20
        Top = 95
        Width = 46
        Height = 25
        Caption = 'User:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = 26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbExpecteAnswerHeader: TLabel
        Left = 20
        Top = 180
        Width = 81
        Height = 25
        Caption = 'Expected'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = 26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object memQuestion: TMemo
        Left = 20
        Top = 36
        Width = 725
        Height = 53
        TabStop = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 24
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'What is the capital of France?')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object memUserAnswer: TMemo
        Left = 20
        Top = 126
        Width = 725
        Height = 53
        TabStop = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 24
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Paris is the capital of France.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object memExpectedAnswer: TMemo
        Left = 20
        Top = 211
        Width = 725
        Height = 53
        TabStop = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 24
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Paris')
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
end
