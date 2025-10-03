object frmCreateQuiz: TfrmCreateQuiz
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Create Quiz'
  ClientHeight = 911
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  Scaled = False
  ScreenSnap = True
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object sbxMainScroll: TScrollBox
    Left = 0
    Top = 0
    Width = 809
    Height = 913
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
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
      object lblCreateNewQuizTitle: TLabel
        Left = 20
        Top = 0
        Width = 190
        Height = 32
        Caption = 'Create New Quiz'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = 32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCreateNewQuizSubTitle: TLabel
        Left = 21
        Top = 38
        Width = 411
        Height = 17
        Caption = 
          'Create custom quizzes, load quizzes from API or create quizzes w' +
          'ith AI'
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
    object pnlOnlineCreate: TPanel
      Left = 20
      Top = 105
      Width = 769
      Height = 143
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvNone
      TabOrder = 1
      object shpOnlineCreateBG: TShape
        Left = 0
        Top = 0
        Width = 769
        Height = 143
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Shape = stRoundRect
      end
      object cpnAPI: TCardPanel
        Left = 7
        Top = 7
        Width = 755
        Height = 130
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ActiveCard = crdAiQuizCreator
        BevelOuter = bvNone
        Caption = 'API'
        TabOrder = 0
        object crdApiSearch: TCard
          Left = 0
          Top = 0
          Width = 755
          Height = 130
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'API Search'
          CardIndex = 0
          TabOrder = 0
          object pnlApiSearch: TPanel
            Left = 0
            Top = 1
            Width = 755
            Height = 128
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            BevelOuter = bvNone
            TabOrder = 0
            object lblApiSearchTitle: TLabel
              Left = 48
              Top = -1
              Width = 150
              Height = 28
              Caption = 'Search Quiz API'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clDefault
              Font.Height = 28
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object imgApiSearch1: TImage
              Left = 4
              Top = 4
              Width = 33
              Height = 33
              Center = True
              Stretch = True
            end
            object lblApiSearchSubTitle: TLabel
              Left = 48
              Top = 27
              Width = 258
              Height = 13
              Alignment = taCenter
              Caption = 'Get community created quizzes from OpenTriviaDB'
              Color = clGrayText
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGrayText
              Font.Height = 14
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentColor = False
              ParentFont = False
            end
            object lblApiCategory: TLabel
              Left = 1
              Top = 46
              Width = 189
              Height = 25
              Caption = 'Select Quiz Category:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clDefault
              Font.Height = -19
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object pnlApiCategories: TPanel
              Left = 1
              Top = 71
              Width = 344
              Height = 34
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              BevelOuter = bvNone
              TabOrder = 0
              object shpMyQuizzesSearch: TShape
                Left = 0
                Top = 0
                Width = 344
                Height = 33
                Shape = stRoundRect
              end
              object pnlACRemoveBorder: TPanel
                Left = 3
                Top = 3
                Width = 338
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                BevelOuter = bvNone
                TabOrder = 0
                object cbxApiCategories: TComboBox
                  Left = -1
                  Top = -1
                  Width = 340
                  Height = 31
                  Hint = 'Select a category.'
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  AutoDropDown = True
                  AutoDropDownWidth = True
                  BevelEdges = []
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  ExtendedUI = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = 24
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  TabStop = False
                  Text = 'Categories'
                  StyleElements = [seFont, seClient]
                end
              end
            end
            object pnlCreateQuiz: TPanel
              Left = 579
              Top = 59
              Width = 174
              Height = 33
              BevelOuter = bvNone
              TabOrder = 1
              OnClick = pnlCreateQuizClick
              object shpButtonCreateQuiz: TShape
                Left = 0
                Top = 0
                Width = 168
                Height = 33
                Brush.Color = clBackground
                Shape = stRoundRect
                OnMouseDown = shpButtonCreateQuizMouseDown
              end
              object lblCreateQuiz: TLabel
                Left = 47
                Top = 7
                Width = 80
                Height = 20
                Align = alCustom
                Alignment = taCenter
                Caption = 'Create Quiz'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clHighlightText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = [fsBold]
                ParentFont = False
                OnClick = pnlCreateQuizClick
              end
            end
            object pnlAmntOfApiQuestions: TPanel
              Left = 350
              Top = 71
              Width = 170
              Height = 34
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              BevelOuter = bvNone
              TabOrder = 2
              object shpAOACRemoveBorderBG: TShape
                Left = 0
                Top = 0
                Width = 170
                Height = 33
                Shape = stRoundRect
              end
              object pnlAOACRemoveBorder: TPanel
                Left = 3
                Top = 3
                Width = 164
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                BevelOuter = bvNone
                TabOrder = 0
                object speAmntOfApiQuestions: TSpinEdit
                  Left = -1
                  Top = -1
                  Width = 172
                  Height = 34
                  Hint = 'Enter the amount of questions.'
                  Margins.Left = 0
                  Margins.Top = 0
                  Margins.Right = 0
                  Margins.Bottom = 0
                  TabStop = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = 24
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  MaxValue = 999999
                  MinValue = 1
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  StyleElements = [seFont, seClient]
                  TabOrder = 0
                  Value = 1
                end
              end
            end
          end
        end
        object crdAiQuizCreator: TCard
          Left = 0
          Top = 0
          Width = 755
          Height = 130
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'AI Quiz Creator'
          CardIndex = 1
          TabOrder = 1
          object pnlAiCreate: TPanel
            Left = 0
            Top = 1
            Width = 755
            Height = 128
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            BevelOuter = bvNone
            TabOrder = 0
            object lblAiCreateTitle: TLabel
              Left = 48
              Top = -1
              Width = 193
              Height = 28
              Caption = 'Create Quiz With AI.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clDefault
              Font.Height = 28
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object imgAiCreate1: TImage
              Left = 4
              Top = 4
              Width = 33
              Height = 33
              Center = True
              Stretch = True
            end
            object lblAiCreateSubTitle: TLabel
              Left = 48
              Top = 27
              Width = 258
              Height = 13
              Alignment = taCenter
              Caption = 'Get community created quizzes from OpenTriviaDB'
              Color = clGrayText
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGrayText
              Font.Height = 14
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentColor = False
              ParentFont = False
            end
            object lblAiCategory: TLabel
              Left = 1
              Top = 46
              Width = 189
              Height = 25
              Caption = 'Select Quiz Category:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clDefault
              Font.Height = -19
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object pnlAiCategories: TPanel
              Left = 1
              Top = 71
              Width = 244
              Height = 34
              Hint = 'Select a category.'
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              BevelOuter = bvNone
              TabOrder = 0
              object shpAIQuizzesSearch: TShape
                Left = 0
                Top = 0
                Width = 244
                Height = 33
                Shape = stRoundRect
              end
              object pnlAiCRemoveBorder: TPanel
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
                object edtAiCategories: TEdit
                  Left = -1
                  Top = -1
                  Width = 240
                  Height = 31
                  Hint = 'Enter a topic for the quiz to be about.'
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
                  TextHint = 'Enter a topic(s) for the AI...'
                  StyleElements = [seFont, seClient]
                end
              end
            end
            object pnlCreateAiQuiz: TPanel
              Left = 579
              Top = 59
              Width = 174
              Height = 33
              BevelOuter = bvNone
              TabOrder = 1
              OnClick = pnlCreateAiQuizClick
              object shpButtonCreateAiQuiz: TShape
                Left = 0
                Top = 0
                Width = 168
                Height = 33
                Brush.Color = clBackground
                Shape = stRoundRect
                OnMouseDown = shpButtonCreateAiQuizMouseDown
              end
              object lblCreateAiQuiz: TLabel
                Left = 47
                Top = 7
                Width = 80
                Height = 20
                Align = alCustom
                Alignment = taCenter
                Caption = 'Create Quiz'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clHighlightText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = [fsBold]
                ParentFont = False
                OnClick = pnlCreateAiQuizClick
              end
            end
            object pnlAmntOfAiQuestions: TPanel
              Left = 439
              Top = 71
              Width = 100
              Height = 34
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              BevelOuter = bvNone
              TabOrder = 2
              object pnlAOAiCRemoveBorderBG: TShape
                Left = 0
                Top = 0
                Width = 100
                Height = 33
                Shape = stRoundRect
              end
              object pnlAOAiCRemoveBorder: TPanel
                Left = 3
                Top = 3
                Width = 94
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                BevelOuter = bvNone
                TabOrder = 0
                object speAmntOfAiQuestions: TSpinEdit
                  Left = -1
                  Top = -1
                  Width = 102
                  Height = 34
                  Hint = 'Enter the amount of questions.'
                  Margins.Left = 0
                  Margins.Top = 0
                  Margins.Right = 0
                  Margins.Bottom = 0
                  TabStop = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = 24
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  MaxValue = 999999
                  MinValue = 1
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  StyleElements = [seFont, seClient]
                  TabOrder = 0
                  Value = 1
                end
              end
            end
            object pnlAiDifficulty: TPanel
              Left = 260
              Top = 71
              Width = 164
              Height = 34
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              BevelOuter = bvNone
              TabOrder = 3
              object shpAiDifficultyBG: TShape
                Left = 0
                Top = 0
                Width = 164
                Height = 33
                Shape = stRoundRect
              end
              object pnlAiDifficultyRemoveBorder: TPanel
                Left = 3
                Top = 3
                Width = 158
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                BevelOuter = bvNone
                TabOrder = 0
                object cbxAiDifficultySelector: TComboBox
                  Left = -1
                  Top = -1
                  Width = 160
                  Height = 31
                  Hint = 'Select a difficulty.'
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  AutoDropDown = True
                  AutoDropDownWidth = True
                  BevelEdges = []
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  ExtendedUI = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = 24
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  TabStop = False
                  Text = 'Difficulty'
                  StyleElements = [seFont, seClient]
                end
              end
            end
          end
        end
      end
    end
    object pnlCreateTypeSelector: TPanel
      Left = 20
      Top = 73
      Width = 769
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvNone
      TabOrder = 2
      object sbtAPI: TSpeedButton
        Left = 0
        Top = 0
        Width = 383
        Height = 32
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        AllowAllUp = True
        GroupIndex = 1
        Down = True
        Caption = 'API'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbtAPIClick
      end
      object sbtAI: TSpeedButton
        Left = 386
        Top = 0
        Width = 383
        Height = 32
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'AI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbtAIClick
      end
    end
    object pnlCustomQuizCreator: TPanel
      Left = 21
      Top = 255
      Width = 769
      Height = 655
      BevelOuter = bvNone
      TabOrder = 3
      object pnlCustomQuizHeader: TPanel
        Left = 0
        Top = 0
        Width = 769
        Height = 250
        BevelOuter = bvNone
        TabOrder = 0
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
        object imgCustomQuizHeader1: TImage
          Left = 12
          Top = 12
          Width = 33
          Height = 33
          Center = True
          Stretch = True
        end
        object lblCustomQuizHeaderSubtitle: TLabel
          Left = 56
          Top = 35
          Width = 242
          Height = 13
          Alignment = taCenter
          Caption = 'Create your own custom quiz just as you like it!'
          Color = clGrayText
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = 14
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblCustomQuizHeaderTitle: TLabel
          Left = 56
          Top = 7
          Width = 313
          Height = 28
          Caption = 'Or Create Your Own Custom Quiz'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = 28
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
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
              OnEnter = memCustomQuizDescriptionEnter
              OnExit = memCustomQuizDescriptionExit
            end
          end
        end
      end
    end
  end
end
