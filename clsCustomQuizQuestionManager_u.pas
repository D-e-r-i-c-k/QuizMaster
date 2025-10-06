unit clsCustomQuizQuestionManager_u;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.WinXPanels, System.Generics.Collections;

type
  TCustomQuestionsManager = class
    private
      FQuestionTop: integer;
      FScrollerRange: integer;

      FQuestionNumber: integer;

      FQuestionBox: TPanel;
      FFromScroll: TScrollBox;
    public
      constructor Create(QuestionsBox: TPanel; FormScroll: TScrollBox);
      procedure AddQuestion;
      procedure AddQuestionClick(Sender: TObject);
      procedure RemoveQuestionClick(Sender: TObject);
      procedure RemoveQuestionFromButton(QuestionNumber: integer);
      procedure AddQuestionFromButton(QuestionNumber: integer);
  end;

implementation

constructor TCustomQuestionsManager.Create(QuestionsBox: TPanel; FormScroll: TScrollBox);
  begin
    FQuestionTop := 290;

    FQuestionNumber := 0;

    FQuestionBox := QuestionsBox;
    FFromScroll := FormScroll;
  end;

procedure TCustomQuestionsManager.AddQuestion;
  var
    pnlQuestion: TPanel;
    shpQuestionBG: TShape;
    lblQuestionNumber: TLabel;

    lblQuestionType: TLabel;
    pnlQuestionTypeSelector: TPanel;
    pnlQuestionTypeSelectorRemoveBorder: TPanel;
    cmbQuestionType: TComboBox;
    shpQuestionTypeSelectorBG: TShape;

    lblQuestionDifficulty: TLabel;
    pnlQuestionDifficultySelector: TPanel;
    shpQuestionDifficultyBG: TShape;
    pnlQuestionDificultySelectorRemoveBorder: TPanel;
    cmbQuestionDifficulty: TComboBox;

    cplQuestionTypeOptions: TCardPanel;

    crdTextAnswer: TCard;
    lblTextAnswerQuestion: TLabel;
    pnlTextAnswerQuestionInput: TPanel;
    shpTextAnswerQuestionInputBG: TShape;
    pnlTextAnswerQuestionInputRemoveBorder: TPanel;
    memTextAnswerQuestionInput: TMemo;

    lblTextAnswerAnswer: TLabel;
    pnlTextAnswerAnswerInput: TPanel;
    shpTextAnswerAnswerInputBG: TShape;
    pnlTextAnswerAnswerInputRemoveBorder: TPanel;
    memTextAnswerAnswerInput: TMemo;

    crdMultipleChoice: TCard;
    lblMultipleChoiceQuestion: TLabel;
    pnlMultipleChoiceQuestionInput: TPanel;
    shpMultipleChoiceQuestionInputBG: TShape;
    pnlMultipleChoiceQuestionInputRemoveBorder: TPanel;
    memMultipleChoiceQuestionInput: TMemo;

    lblMultipleChoiceAnswer: TLabel;
    rbtMultipleChoiceAnswer1: TRadioButton;
    pnlMultipleChoiceAnswer1: TPanel;
    shpMultipleChoiceAnswer1BG: TShape;
    pnlMultipleChoiceAnswer1RemoveBorder: TPanel;
    edtMultipleChoiceAnswer1: TEdit;
    rbtMultipleChoiceAnswer2: TRadioButton;
    pnlMultipleChoiceAnswer2: TPanel;
    shpMultipleChoiceAnswer2BG: TShape;
    pnlMultipleChoiceAnswer2RemoveBorder: TPanel;
    edtMultipleChoiceAnswer2: TEdit;
    rbtMultipleChoiceAnswer3: TRadioButton;
    pnlMultipleChoiceAnswer3: TPanel;
    shpMultipleChoiceAnswer3BG: TShape;
    pnlMultipleChoiceAnswer3RemoveBorder: TPanel;
    edtMultipleChoiceAnswer3: TEdit;
    rbtMultipleChoiceAnswer4: TRadioButton;
    pnlMultipleChoiceAnswer4: TPanel;
    shpMultipleChoiceAnswer4BG: TShape;
    pnlMultipleChoiceAnswer4RemoveBorder: TPanel;
    edtMultipleChoiceAnswer4: TEdit;

    crdBoolean: TCard;
    lblBooleanQuestion: TLabel;
    pnlBooleanQuestionInput: TPanel;
    shpBooleanQuestionInputBG: TShape;
    pnlBooleanQuestionInputRemoveBorder: TPanel;
    memBooleanQuestionInput: TMemo;

    lblBooleanAnswer: TLabel;
    rbtBooleanAnswerTrue: TRadioButton;
    lblBooleanAnswerTrue: TLabel;
    rbtBooleanAnswerFalse: TRadioButton;
    lblBooleanAnswerFalse: TLabel;

    pnlQuestionButtons: TPanel;
    shpNewQuestionBG: TShape;
    imgNewQuestion: TImage;
    shpRemoveQuestionBG: TShape;
    imgRemoveQuestion: TImage;
  begin
  //Update Question Number:
    Inc(FQuestionNumber);
  //Question Panel:
    pnlQuestion := TPanel.Create(FQuestionBox.Owner);
    with pnlQuestion do
      begin
        Parent := FQuestionBox;
        SetBounds(0, FQuestionTop, 769, 325);
        BevelOuter := bvNone;
        Tag := FQuestionNumber;
      end;

  //Question Background:
    shpQuestionBG := TShape.Create(FQuestionBox.Owner);
    with shpQuestionBG do
      begin
        Parent := pnlQuestion;
        SetBounds(0, 1, 769, 324);
        Shape := stRoundRect;
      end;

  //Question Number:
    lblQuestionNumber := TLabel.Create(FQuestionBox.Owner);
    with lblQuestionNumber do
      begin
        Parent := pnlQuestion;
        SetBounds(12, 7, 108, 28);
        Caption := 'Question ' + IntToStr(FQuestionNumber);
        Font.Height := 28;
        Font.Style := [fsBold];
        ParentFont := False;
      end;

  //Queston Type:
    lblQuestionType := TLabel.Create(FQuestionBox.Owner);
    with lblQuestionType do
      begin
        Parent := pnlQuestion;
        SetBounds(9, 39, 127, 25);
        Caption := 'Question Type:';
        Font.Height := 25;
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    pnlQuestionTypeSelector := TPanel.Create(FQuestionBox.Owner);
    with pnlQuestionTypeSelector do
      begin
        Parent := pnlQuestion;
        SetBounds(9, 64, 244, 34);
        BevelOuter := bvNone;
      end;

    shpQuestionTypeSelectorBG := TShape.Create(FQuestionBox.Owner);
    with shpQuestionTypeSelectorBG do
      begin
        Parent := pnlQuestionTypeSelector;
        SetBounds(0, 0, 244, 33);
        Shape := stRoundRect;
      end;

    pnlQuestionTypeSelectorRemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlQuestionTypeSelectorRemoveBorder do
      begin
        Parent := pnlQuestionTypeSelector;
        SetBounds(3, 3, 238, 28);
        BevelOuter := bvNone;
      end;

    cmbQuestionType := TComboBox.Create(FQuestionBox.Owner);
    with cmbQuestionType do
      begin
        cmbQuestionType.Parent := pnlQuestionTypeSelectorRemoveBorder;
        SetBounds(-1, -1, 240, 31);
        Font.Color := clWindowText;
        Font.Height := 24;
        Font.Style := [];
        ParentFont := False;
        Hint := 'Select the type of question.';
        Text := 'Type of Question';
        Items.AddStrings(['True/Fasle', 'Multiple Choice', 'Text Answer']);
      end;

  //Question Difficulty:
    lblQuestionDifficulty := TLabel.Create(FQuestionBox.Owner);
    with lblQuestionDifficulty do
      begin
        Parent := pnlQuestion;
        SetBounds(395, 39, 121, 25);
        Caption := 'Question Difficulty:';
        Font.Height := 25;
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    pnlQuestionDifficultySelector := TPanel.Create(FQuestionBox.Owner);
    with pnlQuestionDifficultySelector do
      begin
        Parent := pnlQuestion;
        SetBounds(395, 64, 244, 34);
        BevelOuter := bvNone;
      end;

    shpQuestionDifficultyBG := TShape.Create(FQuestionBox.Owner);
    with shpQuestionDifficultyBG do
      begin
        Parent := pnlQuestionDifficultySelector;
        SetBounds(0, 0, 244, 33);
        Shape := stRoundRect;
      end;

    pnlQuestionDificultySelectorRemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlQuestionDificultySelectorRemoveBorder do
      begin
        Parent := pnlQuestionDifficultySelector;
        SetBounds(3, 3, 238, 28);
        BevelOuter := bvNone;
      end;

    cmbQuestionDifficulty := TComboBox.Create(FQuestionBox.Owner);
    with cmbQuestionDifficulty do
      begin
        Parent := pnlQuestionDificultySelectorRemoveBorder;
        SetBounds(-1, -1, 240, 31);
        Font.Color := clWindowText;
        Font.Height := 25;
        Font.Style := [];
        ParentFont := False;
        Hint := 'Select question difficulty.';
        Text := 'Question Difficulty';
        Items.AddStrings(['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard']);
      end;

  //Add & Delete Question buttons:
    pnlQuestionButtons := TPanel.Create(FQuestionBox.Owner);
    with pnlQuestionButtons do
      begin
        Parent := pnlQuestion;
        SetBounds(648, 8, 85, 40);
        BevelOuter := bvNone;
      end;

    shpNewQuestionBG := TShape.Create(FQuestionBox.Owner);
    with shpNewQuestionBG do
      begin
        Parent := pnlQuestionButtons;
        SetBounds(0, 0, 40, 40);
        Shape := stRoundRect;
      end;

    imgNewQuestion := TImage.Create(FQuestionBox.Owner);
    with imgNewQuestion do
      begin
        Parent := pnlQuestionButtons;
        SetBounds(0, 0, 40, 40);
//        Picture.LoadFromFile();
        OnClick := AddQuestionClick;
      end;

    shpRemoveQuestionBG := TShape.Create(FQuestionBox.Owner);
    with shpRemoveQuestionBG do
      begin
        Parent := pnlQuestionButtons;
        SetBounds(45, 0, 40, 40);
        Shape := stRoundRect;
      end;

    imgRemoveQuestion := TImage.Create(FQuestionBox.Owner);
    with imgRemoveQuestion do
      begin
        Parent := pnlQuestionButtons;
        SetBounds(45, 0, 40, 40);
//        Picture.LoadFromFile();
        OnClick := RemoveQuestionClick;
      end;

  //Question Type Specific Cards:
    cplQuestionTypeOptions := TCardPanel.Create(FQuestionBox.Owner);
    with cplQuestionTypeOptions do
      begin
        Parent := pnlQuestion;
        SetBounds(9, 102, 753, 200);
        BevelOuter := bvNone;
      end;

    { Text Answer }
    crdTextAnswer := TCard.Create(FQuestionBox.Owner);
    with crdTextAnswer do
      begin
        Parent := cplQuestionTypeOptions;
        SetBounds(0, 0, 753, 200);
        CardIndex := 0;
      end;

    lblTextAnswerQuestion := TLabel.Create(FQuestionBox.Owner);
    with lblTextAnswerQuestion do
      begin
        Parent := crdTextAnswer;
        SetBounds(1, -4, 80, 25);
        Caption := 'Question';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clDefault;
        Font.Height := -19;
        Font.Name := 'Segoe UI';
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    pnlTextAnswerQuestionInput := TPanel.Create(FQuestionBox.Owner);
    with pnlTextAnswerQuestionInput do
      begin
        Parent := crdTextAnswer;
        SetBounds(0, 21, 751, 75);
        BevelOuter := bvNone
      end;

    shpTextAnswerQuestionInputBG := TShape.Create(FQuestionBox.Owner);
    with shpTextAnswerQuestionInputBG do
      begin
        Parent := pnlTextAnswerQuestionInput;
        SetBounds(0, 0, 751, 74);
        Shape := stRoundRect;
      end;

    pnlTextAnswerQuestionInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlTextAnswerQuestionInputRemoveBorder do
      begin
        Parent := pnlTextAnswerQuestionInput;
        SetBounds(6, 6, 741, 61);
        BevelOuter := bvNone;
      end;

    memTextAnswerQuestionInput := TMemo.Create(FQuestionBox.Owner);
    with memTextAnswerQuestionInput do
      begin
        Parent := pnlTextAnswerQuestionInputRemoveBorder;
        SetBounds(-1, -1, 743, 66);
        Hint := 'Enter the question.';
        TabStop := False;
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowFrame;
        Font.Height := 18;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        Lines.AddStrings(['Question Text']);
        ParentFont := False;
      end;

    lblTextAnswerAnswer := TLabel.Create(FQuestionBox.Owner);
    with lblTextAnswerAnswer do
      begin
        Parent := crdTextAnswer;
        SetBounds(1, 95, 66, 25);
        Caption := 'Answer';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clDefault;
        Font.Height := -19;
        Font.Name := 'Segoe UI';
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    pnlTextAnswerAnswerInput := TPanel.Create(FQuestionBox.Owner);
    with pnlTextAnswerAnswerInput do
      begin
        Parent := crdTextAnswer;
        SetBounds(0, 121, 751, 75);
        BevelOuter := bvNone;
      end;

    shpTextAnswerAnswerInputBG := TShape.Create(FQuestionBox.Owner);
    with shpTextAnswerAnswerInputBG do
      begin
        Parent := pnlTextAnswerAnswerInput;
        SetBounds(0, 0, 751, 74);
        Shape := stRoundRect;
      end;

    pnlTextAnswerAnswerInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlTextAnswerAnswerInputRemoveBorder do
      begin
        Parent := pnlTextAnswerAnswerInput;
        SetBounds(6, 6, 741, 61);
        BevelOuter := bvNone;
      end;

    memTextAnswerAnswerInput := TMemo.Create(FQuestionBox.Owner);
    with memTextAnswerAnswerInput do
      begin
        Parent := pnlTextAnswerAnswerInputRemoveBorder;
        SetBounds(-1, -1, 743, 66);
        Hint := 'Enter the answer for the question.';
        TabStop := False;
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowFrame;
        Font.Height := 18;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        Lines.AddStrings(['Answer Text']);
        ParentFont := False;
      end;

    { Multiple Choice }
    crdMultipleChoice := TCard.Create(FQuestionBox.Owner);
    with crdMultipleChoice do
      begin
        Parent := cplQuestionTypeOptions;
        SetBounds(0, 0, 753, 200);
        CardIndex := 0;
      end;

    lblMultipleChoiceQuestion := TLabel.Create(FQuestionBox.Owner);
    with lblMultipleChoiceQuestion do
      begin
        Parent := crdMultipleChoice;
        SetBounds(1, -4, 80, 25);
        Caption := 'Question';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clDefault;
        Font.Height := -19;
        Font.Name := 'Segoe UI';
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    pnlMultipleChoiceQuestionInput := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceQuestionInput do
      begin
        Parent := crdMultipleChoice;
        SetBounds(0, 21, 751, 75);
        BevelOuter := bvNone
      end;

    shpMultipleChoiceQuestionInputBG := TShape.Create(FQuestionBox.Owner);
    with shpMultipleChoiceQuestionInputBG do
      begin
        Parent := pnlMultipleChoiceQuestionInput;
        SetBounds(0, 0, 751, 74);
        Shape := stRoundRect;
      end;

    pnlMultipleChoiceQuestionInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceQuestionInputRemoveBorder do
      begin
        Parent := pnlMultipleChoiceQuestionInput;
        SetBounds(6, 6, 741, 61);
        BevelOuter := bvNone;
      end;

    memMultipleChoiceQuestionInput := TMemo.Create(FQuestionBox.Owner);
    with memMultipleChoiceQuestionInput do
      begin
        Parent := pnlMultipleChoiceQuestionInputRemoveBorder;
        SetBounds(-1, -1, 743, 66);
        Hint := 'Enter the question.';
        TabStop := False;
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowFrame;
        Font.Height := 18;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        Lines.AddStrings(['Question Text']);
        ParentFont := False;
      end;

    lblMultipleChoiceAnswer := TLabel.Create(FQuestionBox.Owner);
    with lblMultipleChoiceAnswer do
      begin
        Parent := crdMultipleChoice;
        SetBounds(1, 95, 66, 25);
        Caption := 'Answer';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clDefault;
        Font.Height := -19;
        Font.Name := 'Segoe UI';
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    rbtMultipleChoiceAnswer1 := TRadioButton.Create(FQuestionBox.Owner);
    with rbtMultipleChoiceAnswer1 do
      begin
        Parent := crdMultipleChoice;
        Tag := 1;
        SetBounds(3, 120, 28, 34);
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 20;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        TabStop := False;
      end;

    pnlMultipleChoiceAnswer1 := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer1 do
      begin
        Parent := crdMultipleChoice;
        Tag := 1;
        SetBounds(20, 120, 244, 34);
        BevelOuter := bvNone;
      end;

    shpMultipleChoiceAnswer1BG := TShape.Create(FQuestionBox.Owner);
    with shpMultipleChoiceAnswer1BG do
      begin
        Parent := pnlMultipleChoiceAnswer1;
        SetBounds(0, 0, 244, 33);
        Shape := stRoundRect;
      end;

    pnlMultipleChoiceAnswer1RemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer1RemoveBorder do
      begin
        Parent := pnlMultipleChoiceAnswer1;
        SetBounds(3, 3, 238, 28);
        BevelOuter := bvNone;
      end;

    edtMultipleChoiceAnswer1 := TEdit.Create(FQuestionBox.Owner);
    with edtMultipleChoiceAnswer1 do
      begin
        Parent := pnlMultipleChoiceAnswer1RemoveBorder;
        SetBounds(-1, -1, 240, 31);
        Hint := 'Enter the first possible answer or leave blank for no option.';
        TabStop := False;
        BevelEdges := [];
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 24;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        ParentShowHint := False;
        ShowHint := True;
        TextHint := 'Option 1';
        StyleElements := [seFont, seClient];
      end;

    rbtMultipleChoiceAnswer2 := TRadioButton.Create(FQuestionBox.Owner);
    with rbtMultipleChoiceAnswer2 do
      begin
        Parent := crdMultipleChoice;
        Tag := 2;
        SetBounds(3, 167, 28, 34);
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 20;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        TabStop := False;
      end;

    pnlMultipleChoiceAnswer2 := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer2 do
      begin
        Parent := crdMultipleChoice;
        Tag := 2;
        SetBounds(20, 167, 244, 34);
        BevelOuter := bvNone;
      end;

    shpMultipleChoiceAnswer2BG := TShape.Create(FQuestionBox.Owner);
    with shpMultipleChoiceAnswer2BG do
      begin
        Parent := pnlMultipleChoiceAnswer2;
        SetBounds(0, 0, 244, 33);
        Shape := stRoundRect;
      end;

    pnlMultipleChoiceAnswer2RemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer2RemoveBorder do
      begin
        Parent := pnlMultipleChoiceAnswer2;
        SetBounds(3, 3, 238, 28);
        BevelOuter := bvNone;
      end;

    edtMultipleChoiceAnswer2 := TEdit.Create(FQuestionBox.Owner);
    with edtMultipleChoiceAnswer2 do
      begin
        Parent := pnlMultipleChoiceAnswer2RemoveBorder;
        SetBounds(-1, -1, 240, 31);
        Hint := 'Enter the second possible answer or leave blank for no option.';
        TabStop := False;
        BevelEdges := [];
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 24;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        ParentShowHint := False;
        ShowHint := True;
        TextHint := 'Option 2';
        StyleElements := [seFont, seClient];
      end;

    rbtMultipleChoiceAnswer3 := TRadioButton.Create(FQuestionBox.Owner);
    with rbtMultipleChoiceAnswer3 do
      begin
        Parent := crdMultipleChoice;
        Tag := 3;
        SetBounds(395, 120, 28, 34);
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 20;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        TabStop := False;
      end;

    pnlMultipleChoiceAnswer3 := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer3 do
      begin
        Parent := crdMultipleChoice;
        Tag := 1;
        SetBounds(412, 120, 244, 34);
        BevelOuter := bvNone;
      end;

    shpMultipleChoiceAnswer3BG := TShape.Create(FQuestionBox.Owner);
    with shpMultipleChoiceAnswer3BG do
      begin
        Parent := pnlMultipleChoiceAnswer3;
        SetBounds(0, 0, 244, 33);
        Shape := stRoundRect;
      end;

    pnlMultipleChoiceAnswer3RemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer3RemoveBorder do
      begin
        Parent := pnlMultipleChoiceAnswer3;
        SetBounds(3, 3, 238, 28);
        BevelOuter := bvNone;
      end;

    edtMultipleChoiceAnswer3 := TEdit.Create(FQuestionBox.Owner);
    with edtMultipleChoiceAnswer3 do
      begin
        Parent := pnlMultipleChoiceAnswer3RemoveBorder;
        SetBounds(-1, -1, 240, 31);
        Hint := 'Enter the third possible answer or leave blank for no option.';
        TabStop := False;
        BevelEdges := [];
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 24;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        ParentShowHint := False;
        ShowHint := True;
        TextHint := 'Option 3';
        StyleElements := [seFont, seClient];
      end;

    rbtMultipleChoiceAnswer4 := TRadioButton.Create(FQuestionBox.Owner);
    with rbtMultipleChoiceAnswer4 do
      begin
        Parent := crdMultipleChoice;
        Tag := 4;
        SetBounds(395, 167, 28, 34);
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 20;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        TabStop := False;
      end;

    pnlMultipleChoiceAnswer4 := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer4 do
      begin
        Parent := crdMultipleChoice;
        Tag := 1;
        SetBounds(412, 167, 244, 34);
        BevelOuter := bvNone;
      end;

    shpMultipleChoiceAnswer4BG := TShape.Create(FQuestionBox.Owner);
    with shpMultipleChoiceAnswer4BG do
      begin
        Parent := pnlMultipleChoiceAnswer4;
        SetBounds(0, 0, 244, 33);
        Shape := stRoundRect;
      end;

    pnlMultipleChoiceAnswer4RemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlMultipleChoiceAnswer4RemoveBorder do
      begin
        Parent := pnlMultipleChoiceAnswer4;
        SetBounds(3, 3, 238, 28);
        BevelOuter := bvNone;
      end;

    edtMultipleChoiceAnswer4 := TEdit.Create(FQuestionBox.Owner);
    with edtMultipleChoiceAnswer4 do
      begin
        Parent := pnlMultipleChoiceAnswer4RemoveBorder;
        SetBounds(-1, -1, 240, 31);
        Hint := 'Enter the fourth possible answer or leave blank for no option.';
        TabStop := False;
        BevelEdges := [];
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 24;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        ParentShowHint := False;
        ShowHint := True;
        TextHint := 'Option 4';
        StyleElements := [seFont, seClient];
      end;

    { True/False }
    crdBoolean := TCard.Create(FQuestionBox.Owner);
    with crdBoolean do
      begin
        Parent := cplQuestionTypeOptions;
        SetBounds(0, 0, 753, 200);
        CardIndex := 0;
      end;

    lblBooleanQuestion := TLabel.Create(FQuestionBox.Owner);
    with lblBooleanQuestion do
      begin
        Parent := crdBoolean;
        SetBounds(1, -4, 80, 25);
        Caption := 'Question';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clDefault;
        Font.Height := -19;
        Font.Name := 'Segoe UI';
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    pnlBooleanQuestionInput := TPanel.Create(FQuestionBox.Owner);
    with pnlBooleanQuestionInput do
      begin
        Parent := crdBoolean;
        SetBounds(0, 21, 751, 75);
        BevelOuter := bvNone
      end;

    shpBooleanQuestionInputBG := TShape.Create(FQuestionBox.Owner);
    with shpBooleanQuestionInputBG do
      begin
        Parent := pnlBooleanQuestionInput;
        SetBounds(0, 0, 751, 74);
        Shape := stRoundRect;
      end;

    pnlBooleanQuestionInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
    with pnlBooleanQuestionInputRemoveBorder do
      begin
        Parent := pnlBooleanQuestionInput;
        SetBounds(6, 6, 741, 61);
        BevelOuter := bvNone;
      end;

    memBooleanQuestionInput := TMemo.Create(FQuestionBox.Owner);
    with memBooleanQuestionInput do
      begin
        Parent := pnlTextAnswerQuestionInputRemoveBorder;
        SetBounds(-1, -1, 743, 66);
        Hint := 'Enter the question.';
        TabStop := False;
        BevelInner := bvNone;
        BevelOuter := bvNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowFrame;
        Font.Height := 18;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        Lines.AddStrings(['Question Text']);
        ParentFont := False;
      end;

    lblBooleanAnswer := TLabel.Create(FQuestionBox.Owner);
    with lblBooleanAnswer do
      begin
        Parent := crdBoolean;
        SetBounds(1, 95, 66, 25);
        Caption := 'Answer';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clDefault;
        Font.Height := -19;
        Font.Name := 'Segoe UI';
        Font.Style := [fsBold];
        ParentFont := False;
      end;

    rbtBooleanAnswerTrue := TRadioButton.Create(FQuestionBox.Owner);
    with rbtBooleanAnswerTrue do
      begin
        Parent := crdBoolean;
        Tag := 1;
        SetBounds(3, 120, 20, 34);
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 20;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        TabStop := False;
      end;

    lblBooleanAnswerTrue := TLabel.Create(FQuestionBox.Owner);
    with lblBooleanAnswerTrue do
      begin
        Parent := crdBoolean;
        SetBounds(23, 125, 30, 21);
        Caption := 'True';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 21;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
      end;

    rbtBooleanAnswerFalse := TRadioButton.Create(FQuestionBox.Owner);
    with rbtBooleanAnswerFalse do
      begin
        Parent := crdBoolean;
        Tag := 2;
        SetBounds(3, 160, 20, 34);
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 20;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
        TabStop := False;
      end;
    lblBooleanAnswerFalse := TLabel.Create(FQuestionBox.Owner);
    with lblBooleanAnswerFalse do
      begin
        Parent := crdBoolean;
        SetBounds(23, 165, 34, 21);
        Caption := 'False';
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clWindowText;
        Font.Height := 21;
        Font.Name := 'Segoe UI';
        Font.Style := [];
        ParentFont := False;
      end;

    cplQuestionTypeOptions.ActiveCard := crdTextAnswer;
  end;

procedure TCustomQuestionsManager.AddQuestionFromButton(QuestionNumber: Integer);
  begin
    ShowMessage('Add question at index ' + IntToStr(QuestionNumber + 1));
  end;

procedure TCustomQuestionsManager.RemoveQuestionFromButton(QuestionNumber: Integer);
  begin
    ShowMessage('Remove question at index ' + IntToStr(QuestionNumber));
  end;

procedure TCustomQuestionsManager.AddQuestionClick(Sender: TObject);
  begin
    AddQuestionFromButton(TImage(Sender).Parent.Parent.Tag)
  end;

procedure TCustomQuestionsManager.RemoveQuestionClick(Sender: TObject);
  begin
    RemoveQuestionFromButton(TImage(Sender).Parent.Parent.Tag)
  end;

end.
