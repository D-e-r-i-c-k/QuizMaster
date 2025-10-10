object frmAnswerQuiz: TfrmAnswerQuiz
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmAnswerQuiz'
  ClientHeight = 450
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  ShowInTaskBar = True
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblAnswerQuizTile: TLabel
    Left = 8
    Top = 8
    Width = 109
    Height = 32
    Caption = 'Quiz Title'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = 32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pbAnswerProgress: TProgressBar
    Left = 8
    Top = 46
    Width = 793
    Height = 27
    Position = 50
    Smooth = True
    MarqueeInterval = 1
    Step = 1
    TabOrder = 0
  end
  object pnlQuestion: TPanel
    Left = 20
    Top = 80
    Width = 769
    Height = 325
    BevelOuter = bvNone
    TabOrder = 1
    object shpQuestionBG: TShape
      Left = 0
      Top = 1
      Width = 769
      Height = 324
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Shape = stRoundRect
    end
    object cplQuestions: TCardPanel
      Left = 0
      Top = 0
      Width = 769
      Height = 325
      ActiveCard = crdQuestion
      BevelOuter = bvNone
      Caption = 'cplQuestions'
      TabOrder = 0
      object crdQuestion: TCard
        Left = 0
        Top = 0
        Width = 769
        Height = 325
        Caption = 'crdQuestion'
        CardIndex = 0
        TabOrder = 0
        object lblQuestionNumber: TLabel
          Left = 12
          Top = 8
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
        object lblQuestionText: TLabel
          Left = 12
          Top = 88
          Width = 703
          Height = 25
          Caption = 
            'What is the capital of France lkjlkjlkj slkdjf lskdjf llkajd als' +
            'dkfj alsdjfalkjd l ajlofejlkjds'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = 26
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object pnlAnswer: TPanel
          Left = 10
          Top = 145
          Width = 750
          Height = 160
          BevelOuter = bvNone
          TabOrder = 0
          object cplAnswerType: TCardPanel
            Left = 0
            Top = 0
            Width = 750
            Height = 160
            ActiveCard = crdMultipleChoice
            BevelOuter = bvNone
            Caption = 'cplAnswerType'
            TabOrder = 0
            object crdTextAnswer: TCard
              Left = 0
              Top = 0
              Width = 750
              Height = 160
              Caption = 'Text'
              CardIndex = 0
              TabOrder = 0
              object pnlTextAnswer: TPanel
                Left = -1
                Top = 0
                Width = 750
                Height = 160
                Hint = 'Select a category.'
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                BevelOuter = bvNone
                TabOrder = 0
                object shpTextAnswerBG: TShape
                  Left = 1
                  Top = 0
                  Width = 748
                  Height = 160
                  Shape = stRoundRect
                end
                object pnlTextAnswerRemoveBorder: TPanel
                  Left = 7
                  Top = 7
                  Width = 736
                  Height = 146
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  BevelOuter = bvNone
                  TabOrder = 0
                  object memTextAnswer: TMemo
                    Left = -1
                    Top = -1
                    Width = 738
                    Height = 150
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
                      'Answer Text')
                    ParentFont = False
                    TabOrder = 0
                  end
                end
              end
            end
            object crdBoolean: TCard
              Left = 0
              Top = 0
              Width = 750
              Height = 160
              Caption = 'crdBoolean'
              CardIndex = 1
              TabOrder = 1
              object shpBooleanAnswerBG: TShape
                Left = 2
                Top = 0
                Width = 748
                Height = 160
                Shape = stRoundRect
              end
              object lblFalse: TLabel
                Left = 37
                Top = 24
                Width = 41
                Height = 25
                Caption = 'False'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 26
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
              end
              object lblTrue: TLabel
                Left = 37
                Top = 92
                Width = 36
                Height = 25
                Caption = 'True'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 26
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
              end
              object rbtBooleanTrue: TRadioButton
                Tag = 1
                Left = 11
                Top = 90
                Width = 20
                Height = 34
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object rbtBooleanFalse: TRadioButton
                Tag = 2
                Left = 11
                Top = 22
                Width = 20
                Height = 34
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
            end
            object crdMultipleChoice: TCard
              Left = 0
              Top = 0
              Width = 750
              Height = 160
              Caption = 'crdMultipleChoice'
              CardIndex = 2
              TabOrder = 2
              object lblMultipleChoiceAnswer1: TLabel
                Left = 45
                Top = 28
                Width = 56
                Height = 25
                Caption = 'Venice'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 26
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
              end
              object lblMultipleChoiceAnswer2: TLabel
                Left = 45
                Top = 84
                Width = 47
                Height = 25
                Caption = 'Rome'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 26
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
              end
              object lblMultipleChoiceAnswer3: TLabel
                Left = 428
                Top = 28
                Width = 40
                Height = 25
                Caption = 'Paris'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 26
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
              end
              object lblMultipleChoiceAnswer4: TLabel
                Left = 428
                Top = 84
                Width = 92
                Height = 25
                Caption = 'Cape Town'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 26
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
              end
              object rbtMultipleChoice1: TRadioButton
                Tag = 1
                Left = 11
                Top = 22
                Width = 28
                Height = 42
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object rbtMultipleChoice2: TRadioButton
                Tag = 2
                Left = 11
                Top = 78
                Width = 28
                Height = 42
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object rbtMultipleChoice3: TRadioButton
                Tag = 3
                Left = 394
                Top = 78
                Width = 28
                Height = 42
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object rbtMultipleChoice4: TRadioButton
                Tag = 4
                Left = 394
                Top = 22
                Width = 28
                Height = 42
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = 20
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
            end
          end
        end
        object pnlQuestionDifficulty: TPanel
          Left = 32
          Top = 40
          Width = 70
          Height = 25
          BevelOuter = bvNone
          TabOrder = 1
          object shpQuestionDifficultyBG: TShape
            Left = 0
            Top = 0
            Width = 70
            Height = 25
            Brush.Color = clAppWorkSpace
            Pen.Color = clMedGray
            Shape = stRoundRect
          end
          object lblQuestionDifficulty: TLabel
            Left = 22
            Top = 4
            Width = 27
            Height = 17
            Caption = 'Easy'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 18
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
  end
  object pnlNextQuestion: TPanel
    Left = 621
    Top = 412
    Width = 174
    Height = 33
    Cursor = crHandPoint
    BevelOuter = bvNone
    TabOrder = 2
    object shpNextQuestionBG: TShape
      Left = 0
      Top = 0
      Width = 168
      Height = 33
      Brush.Color = clBackground
      Shape = stRoundRect
      OnMouseDown = shpNextQuestionBGMouseDown
    end
    object lblNextQuestion: TLabel
      Left = 37
      Top = 7
      Width = 101
      Height = 20
      Align = alCustom
      Alignment = taCenter
      Caption = 'Next Question'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = 20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblNextQuestionClick
    end
  end
  object pnlPrevQuestion: TPanel
    Left = 20
    Top = 412
    Width = 174
    Height = 33
    Cursor = crHandPoint
    BevelOuter = bvNone
    TabOrder = 3
    object shpPrevQuestionBG: TShape
      Left = 0
      Top = 0
      Width = 168
      Height = 33
      Shape = stRoundRect
      OnMouseDown = shpPrevQuestionBGMouseDown
    end
    object lblPrevQuestion: TLabel
      Left = 24
      Top = 7
      Width = 127
      Height = 20
      Align = alCustom
      Alignment = taCenter
      Caption = 'Previous Question'
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = 20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      OnClick = lblPrevQuestionClick
    end
  end
end
