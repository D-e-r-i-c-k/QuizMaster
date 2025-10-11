object frmEditQuiz: TfrmEditQuiz
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Edit Quiz'
  ClientHeight = 348
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
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
    object lblQuizEditHeader: TLabel
      Left = 20
      Top = 0
      Width = 110
      Height = 32
      Caption = 'Edit Quiz:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = 32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuizEditSubTitle: TLabel
      Left = 21
      Top = 38
      Width = 194
      Height = 17
      Caption = 'Edit your quiz as you whould like.'
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = 18
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object pnlCustomQuizHeader: TPanel
    Left = 20
    Top = 80
    Width = 769
    Height = 250
    BevelOuter = bvNone
    TabOrder = 1
    object shpCustomQuizHeaderBG: TShape
      Left = 0
      Top = 1
      Width = 769
      Height = 249
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Shape = stRoundRect
    end
    object lblCustomQuizTitle: TLabel
      Left = 9
      Top = 54
      Width = 88
      Height = 25
      Caption = 'Quiz Title:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCustomQuizCategory: TLabel
      Left = 395
      Top = 54
      Width = 132
      Height = 25
      Caption = 'Quiz Category:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCustomQuizDescription: TLabel
      Left = 9
      Top = 116
      Width = 102
      Height = 25
      Caption = 'Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlCustomQuizTitle: TPanel
      Left = 9
      Top = 79
      Width = 244
      Height = 34
      Hint = 'Select a category.'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvNone
      TabOrder = 0
      object shpCustomQuizTitleBG: TShape
        Left = 0
        Top = 0
        Width = 244
        Height = 33
        Shape = stRoundRect
      end
      object pnlCustomQuizTitleRemoveBorder: TPanel
        Left = 3
        Top = 3
        Width = 238
        Height = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        BevelOuter = bvNone
        TabOrder = 0
        object edtCustomQuizTitle: TEdit
          Left = -1
          Top = -1
          Width = 240
          Height = 31
          Hint = 'Enter a title for your quiz.'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabStop = False
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TextHint = 'Enter a title for your quiz.'
          StyleElements = [seFont, seClient]
        end
      end
    end
    object pnlCustomQuizCategory: TPanel
      Left = 395
      Top = 79
      Width = 244
      Height = 34
      Hint = 'Select a category.'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvNone
      TabOrder = 1
      object shpCustomQuizCategoryBG: TShape
        Left = 0
        Top = 0
        Width = 244
        Height = 33
        Shape = stRoundRect
      end
      object pnlCustomQuizCategoryRemoveBorder: TPanel
        Left = 3
        Top = 3
        Width = 238
        Height = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        BevelOuter = bvNone
        TabOrder = 0
        object edtCustomQuizCategory: TEdit
          Left = -1
          Top = -1
          Width = 240
          Height = 31
          Hint = 'Enter a category for the quiz'
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabStop = False
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TextHint = 'Enter quiz category.'
          StyleElements = [seFont, seClient]
        end
      end
    end
    object pnlCustomQuizDescription: TPanel
      Left = 9
      Top = 141
      Width = 751
      Height = 75
      Hint = 'Select a category.'
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvNone
      TabOrder = 2
      object shpCustomQuizDescriptionBG: TShape
        Left = 0
        Top = 0
        Width = 751
        Height = 74
        Shape = stRoundRect
      end
      object pnlCustomQuizDescriptionRemoveBorder: TPanel
        Left = 6
        Top = 6
        Width = 741
        Height = 61
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        BevelOuter = bvNone
        TabOrder = 0
        object memCustomQuizDescription: TMemo
          Left = -1
          Top = -1
          Width = 743
          Height = 66
          Hint = 'Give a description of the your quiz'
          TabStop = False
          BevelInner = bvNone
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowFrame
          Font.Height = 18
          Font.Name = 'Segoe UI'
          Font.Style = []
          Lines.Strings = (
            'Describe what the quiz is about')
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object pnlButtonCreateCustomQuiz: TPanel
      Left = 586
      Top = 20
      Width = 174
      Height = 33
      Cursor = crHandPoint
      BevelOuter = bvNone
      TabOrder = 3
      OnClick = pnlButtonCreateCustomQuizClick
      object shpButtonCreateCustomQuiz: TShape
        Left = 0
        Top = 0
        Width = 168
        Height = 33
        Brush.Color = clBackground
        Shape = stRoundRect
        OnMouseDown = shpButtonCreateCustomQuizMouseDown
      end
      object lblCreateCustomQuiz: TLabel
        Left = 47
        Top = 7
        Width = 62
        Height = 20
        Align = alCustom
        Alignment = taCenter
        Caption = 'Edit Quiz'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = 20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = lblCreateCustomQuizClick
      end
    end
  end
end
