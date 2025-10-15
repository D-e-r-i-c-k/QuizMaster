// clsEditQuizManager_u.pas
// Purpose: Contains logic for editing quizzes: updating metadata and
// questions.

unit clsEditQuizManager_u;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils,
  System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons,
  Vcl.WinXPanels, System.Generics.Collections, clsQuestion_u, dbMain_u;

type
  TEditQuizManager = class
    private
      FQuestionTop: integer;
      FScrollerRange: integer;

      FQuestions: TList<TPanel>;
      FNonDeletedQuestions: TList<TPanel>;
      FQuestionOptions: TList<TComboBox>;

      FQuestionNumber: integer;

      FQuestionBox: TScrollBox;
      FFromScroll: TScrollBox;
      function CheckFields(var Memos: TList<TMemo>; var Edits: TList<TEdit>; var RadioButtons: TList<TRadioButton>): integer;
    public
      constructor Create(FormScroll: TScrollBox);

      procedure AddQuestion;
      procedure AddQuestionClick(Sender: TObject);
      procedure RemoveQuestionClick(Sender: TObject);
      procedure RemoveQuestionFromButton(QuestionNumber: integer);
      procedure AddQuestionFromButton(QuestionNumber: integer);
      procedure ChangeQuestionType(Sender: TObject);
      procedure ShowMemoHint(Sender: TObject);
      procedure ClearMemoHint(Sender: TObject);
      procedure GetQuestionControls(Card: TCard; var Memos: TList<TMemo>; var Edits: TList<TEdit>; var RadioButtons: TList<TRadioButton>);

      function CheckForFields(Sender: TObject): Integer;
      function GetComponent(Name: string): TComponent;
      function CheckAllFields: integer;
      function CreateQuestion(QuestionID: integer; var Memos: TList<TMemo>; var Edits: TList<TEdit>; var RadioButtons: TList<TRadioButton>): TQuestion;
      function CheckTextEmpty(Edit: TEdit): Boolean; overload;
      function CheckTextEmpty(Memo: TMemo): Boolean; overload;
      function TryAddQuiz: Integer;
  end;

var
  Question: TQuestion;

implementation

constructor TEditQuizManager.Create(FormScroll: TScrollBox);
begin
  FQuestionTop := 290;

  FQuestionNumber := 0;

  FQuestionBox := FormScroll;
  FFromScroll := FormScroll;

  FScrollerRange := FFromScroll.VertScrollBar.Range;

  FQuestionOptions := TList<TComboBox>.Create;
  FQuestions := TList<TPanel>.Create;
  FNonDeletedQuestions := TList<TPanel>.Create;

  FFromScroll.VertScrollBar.Position := 0;
end;

procedure TEditQuizManager.AddQuestion;
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
  pnlQuestionDifficultySelectorRemoveBorder: TPanel;
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
    Name := 'pnlQuestion' + IntToStr(FQuestionNumber);
    Parent := FQuestionBox;
    SetBounds(20, FQuestionTop, 769, 325);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  //Question Background:
  shpQuestionBG := TShape.Create(FQuestionBox.Owner);
  with shpQuestionBG do
  begin
    Name := 'shpQuestionBG' + IntToStr(FQuestionNumber);
    Parent := pnlQuestion;
    SetBounds(0, 1, 769, 324);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  //Question Number:
  lblQuestionNumber := TLabel.Create(FQuestionBox.Owner);
  with lblQuestionNumber do
  begin
    Name := 'lblQuestionNumber' + IntToStr(FQuestionNumber);
    Parent := pnlQuestion;
    SetBounds(12, 7, 108, 28);
          //GetQuestionNumber:
    if FNonDeletedQuestions.Count = 0 then
    begin
      Caption := 'Question ' + IntToStr(FQuestionNumber);
    end
    else
    begin
      Caption := 'Question ' + IntToStr(FNonDeletedQuestions.Count + 1)
    end;
    Font.Height := 28;
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  //Queston Type:
  lblQuestionType := TLabel.Create(FQuestionBox.Owner);
  with lblQuestionType do
  begin
    Name := 'lblQuestionType' + IntToStr(FQuestionNumber);
    Parent := pnlQuestion;
    SetBounds(9, 39, 127, 25);
    Caption := 'Question Type:';
    Font.Height := 25;
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  pnlQuestionTypeSelector := TPanel.Create(FQuestionBox.Owner);
  with pnlQuestionTypeSelector do
  begin
    Name := 'pnlQuestionTypeSelector' + IntToStr(FQuestionNumber);
    Parent := pnlQuestion;
    SetBounds(9, 64, 244, 34);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpQuestionTypeSelectorBG := TShape.Create(FQuestionBox.Owner);
  with shpQuestionTypeSelectorBG do
  begin
    Name := 'shpQuestionTypeSelectorBG' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionTypeSelector;
    SetBounds(0, 0, 244, 33);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlQuestionTypeSelectorRemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlQuestionTypeSelectorRemoveBorder do
  begin
    Name := 'pnlQuestionTypeSelectorRemoveBorder' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionTypeSelector;
    SetBounds(3, 3, 238, 28);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  cmbQuestionType := TComboBox.Create(FQuestionBox.Owner);
  with cmbQuestionType do
  begin
    Name := 'cmbQuestionType' + IntToStr(FQuestionNumber);
    cmbQuestionType.Parent := pnlQuestionTypeSelectorRemoveBorder;
    SetBounds(-1, -1, 240, 31);
    Font.Color := clWindowText;
    Font.Height := 24;
    Font.Style := [];
    ParentFont := False;
    Hint := 'Select the type of question.';
    Text := 'Type of Question';
    Items.AddStrings(['Text Answer', 'Multiple Choice', 'True/False']);
    Tag := FQuestionNumber;
    TabStop := False;

    OnChange := ChangeQuestionType;
  end;
  FQuestionOptions.Add(cmbQuestionType);

  //Question Difficulty:
  lblQuestionDifficulty := TLabel.Create(FQuestionBox.Owner);
  with lblQuestionDifficulty do
  begin
    Name := 'lblQuestionDifficulty' + IntToStr(FQuestionNumber);
    Parent := pnlQuestion;
    SetBounds(395, 39, 121, 25);
    Caption := 'Question Difficulty:';
    Font.Height := 25;
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  pnlQuestionDifficultySelector := TPanel.Create(FQuestionBox.Owner);
  with pnlQuestionDifficultySelector do
  begin
    Name := 'pnlQuestionDifficultySelector' + IntToStr(FQuestionNumber);
    Parent := pnlQuestion;
    SetBounds(395, 64, 244, 34);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpQuestionDifficultyBG := TShape.Create(FQuestionBox.Owner);
  with shpQuestionDifficultyBG do
  begin
    Name := 'shpQuestionDifficultyBG' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionDifficultySelector;
    SetBounds(0, 0, 244, 33);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlQuestionDifficultySelectorRemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlQuestionDifficultySelectorRemoveBorder do
  begin
    Name := 'pnlQuestionDifficultySelectorRemoveBorder' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionDifficultySelector;
    SetBounds(3, 3, 238, 28);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  cmbQuestionDifficulty := TComboBox.Create(FQuestionBox.Owner);
  with cmbQuestionDifficulty do
  begin
    Name := 'cmbQuestionDifficulty' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionDifficultySelectorRemoveBorder;
    SetBounds(-1, -1, 240, 31);
    Font.Color := clWindowText;
    Font.Height := 25;
    Font.Style := [];
    ParentFont := False;
    Hint := 'Select question difficulty.';
    Text := 'Question Difficulty';
    Items.AddStrings(['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard']);
    Tag := FQuestionNumber;
    TabStop := False;
  end;
  FQuestionOptions.Add(cmbQuestionDifficulty);


  //Add & Delete Question buttons:
  pnlQuestionButtons := TPanel.Create(FQuestionBox.Owner);
  with pnlQuestionButtons do
  begin
    Name := 'pnlQuestionButtons' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlQuestion;
    SetBounds(648, 8, 85, 40);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpNewQuestionBG := TShape.Create(FQuestionBox.Owner);
  with shpNewQuestionBG do
  begin
    Name := 'shpNewQuestionBG' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionButtons;
    SetBounds(0, 0, 40, 40);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  imgNewQuestion := TImage.Create(FQuestionBox.Owner);
  with imgNewQuestion do
  begin
    Name := 'imgNewQuestion' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionButtons;
    SetBounds(0, 0, 40, 40);
    Stretch := True;
    Proportional := True;
    Cursor := crHandPoint;
    Picture.LoadFromFile('icons/imgAdd.png');
    BringToFront;
    Visible := True;
    Tag := FQuestionNumber;

    OnClick := AddQuestionClick
  end;

  shpRemoveQuestionBG := TShape.Create(FQuestionBox.Owner);
  with shpRemoveQuestionBG do
  begin
    Name := 'shpRemoveQuestionBG' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionButtons;
    SetBounds(45, 0, 40, 40);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  imgRemoveQuestion := TImage.Create(FQuestionBox.Owner);
  with imgRemoveQuestion do
  begin
    Name := 'imgRemoveQuestion' + IntToStr(FQuestionNumber);
    Parent := pnlQuestionButtons;
    SetBounds(45, 0, 40, 40);
    Stretch := True;
    Proportional := True;
    Cursor := crHandPoint;
    Picture.LoadFromFile('icons/imgDelete.png');
    BringToFront;
    Visible := True;
    Tag := FQuestionNumber;

    OnClick := RemoveQuestionClick
  end;

  //Question Type Specific Cards:
  cplQuestionTypeOptions := TCardPanel.Create(FQuestionBox.Owner);
  with cplQuestionTypeOptions do
  begin
    Name := 'cplQuestionTypeOptions' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlQuestion;
    SetBounds(9, 102, 753, 200);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

    { Text Answer }
  crdTextAnswer := TCard.Create(FQuestionBox.Owner);
  with crdTextAnswer do
  begin
    Name := 'crdTextAnswer' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := cplQuestionTypeOptions;
    SetBounds(0, 0, 753, 200);
    CardIndex := 0;
    Tag := FQuestionNumber;
  end;

  lblTextAnswerQuestion := TLabel.Create(FQuestionBox.Owner);
  with lblTextAnswerQuestion do
  begin
    Name := 'lblTextAnswerQuestion' + IntToStr(FQuestionNumber);
    Parent := crdTextAnswer;
    SetBounds(1, -4, 80, 25);
    Caption := 'Question';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clDefault;
    Font.Height := -19;
    Font.Name := 'Segoe UI';
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  pnlTextAnswerQuestionInput := TPanel.Create(FQuestionBox.Owner);
  with pnlTextAnswerQuestionInput do
  begin
    Name := 'pnlTextAnswerQuestionInput' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdTextAnswer;
    SetBounds(0, 21, 751, 75);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpTextAnswerQuestionInputBG := TShape.Create(FQuestionBox.Owner);
  with shpTextAnswerQuestionInputBG do
  begin
    Name := 'shpTextAnswerQuestionInputBG' + IntToStr(FQuestionNumber);
    Parent := pnlTextAnswerQuestionInput;
    SetBounds(0, 0, 751, 74);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlTextAnswerQuestionInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlTextAnswerQuestionInputRemoveBorder do
  begin
    Name := 'pnlTextAnswerQuestionInputRemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlTextAnswerQuestionInput;
    SetBounds(6, 6, 741, 61);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  memTextAnswerQuestionInput := TMemo.Create(FQuestionBox.Owner);
  with memTextAnswerQuestionInput do
  begin
    Name := 'memTextAnswerQuestionInput' + IntToStr(FQuestionNumber);
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
    Lines.Clear;
    Lines.AddStrings(['Question Text']);
    ParentFont := False;
    Tag := FQuestionNumber;
    TabStop := False;

    OnEnter := ClearMemoHint;
    OnExit := ShowMemoHint;
  end;

  lblTextAnswerAnswer := TLabel.Create(FQuestionBox.Owner);
  with lblTextAnswerAnswer do
  begin
    Name := 'lblTextAnswerAnswer' + IntToStr(FQuestionNumber);
    Parent := crdTextAnswer;
    SetBounds(1, 95, 66, 25);
    Caption := 'Answer';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clDefault;
    Font.Height := -19;
    Font.Name := 'Segoe UI';
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  pnlTextAnswerAnswerInput := TPanel.Create(FQuestionBox.Owner);
  with pnlTextAnswerAnswerInput do
  begin
    Name := 'pnlTextAnswerAnswerInput' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdTextAnswer;
    SetBounds(0, 121, 751, 75);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpTextAnswerAnswerInputBG := TShape.Create(FQuestionBox.Owner);
  with shpTextAnswerAnswerInputBG do
  begin
    Name := 'shpTextAnswerAnswerInputBG' + IntToStr(FQuestionNumber);
    Parent := pnlTextAnswerAnswerInput;
    SetBounds(0, 0, 751, 74);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlTextAnswerAnswerInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlTextAnswerAnswerInputRemoveBorder do
  begin
    Name := 'pnlTextAnswerAnswerInputRemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlTextAnswerAnswerInput;
    SetBounds(6, 6, 741, 61);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  memTextAnswerAnswerInput := TMemo.Create(FQuestionBox.Owner);
  with memTextAnswerAnswerInput do
  begin
    Name := 'memTextAnswerAnswerInput' + IntToStr(FQuestionNumber);
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
    Lines.Clear;
    Lines.AddStrings(['Answer Text']);
    ParentFont := False;
    Tag := FQuestionNumber;
    TabStop := False;

    OnEnter := ClearMemoHint;
    OnExit := ShowMemoHint;
  end;

    { Multiple Choice }
  crdMultipleChoice := TCard.Create(FQuestionBox.Owner);
  with crdMultipleChoice do
  begin
    Name := 'crdMultipleChoice' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := cplQuestionTypeOptions;
    SetBounds(0, 0, 753, 200);
    CardIndex := 1;
    Tag := FQuestionNumber;
  end;

  lblMultipleChoiceQuestion := TLabel.Create(FQuestionBox.Owner);
  with lblMultipleChoiceQuestion do
  begin
    Name := 'lblMultipleChoiceQuestion' + IntToStr(FQuestionNumber);
    Parent := crdMultipleChoice;
    SetBounds(1, -4, 80, 25);
    Caption := 'Question';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clDefault;
    Font.Height := -19;
    Font.Name := 'Segoe UI';
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceQuestionInput := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceQuestionInput do
  begin
    Name := 'pnlMultipleChoiceQuestionInput' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(0, 21, 751, 75);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpMultipleChoiceQuestionInputBG := TShape.Create(FQuestionBox.Owner);
  with shpMultipleChoiceQuestionInputBG do
  begin
    Name := 'shpMultipleChoiceQuestionInputBG' + IntToStr(FQuestionNumber);
    Parent := pnlMultipleChoiceQuestionInput;
    SetBounds(0, 0, 751, 74);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceQuestionInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceQuestionInputRemoveBorder do
  begin
    Name := 'pnlMultipleChoiceQuestionInputRemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlMultipleChoiceQuestionInput;
    SetBounds(6, 6, 741, 61);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  memMultipleChoiceQuestionInput := TMemo.Create(FQuestionBox.Owner);
  with memMultipleChoiceQuestionInput do
  begin
    Name := 'memMultipleChoiceQuestionInput' + IntToStr(FQuestionNumber);
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
    Lines.Clear;
    Lines.AddStrings(['Question Text']);
    ParentFont := False;
    Tag := FQuestionNumber;
    TabStop := False;

    OnEnter := ClearMemoHint;
    OnExit := ShowMemoHint;
  end;

  lblMultipleChoiceAnswer := TLabel.Create(FQuestionBox.Owner);
  with lblMultipleChoiceAnswer do
  begin
    Name := 'lblMultipleChoiceAnswer' + IntToStr(FQuestionNumber);
    Parent := crdMultipleChoice;
    SetBounds(1, 95, 66, 25);
    Caption := 'Answer';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clDefault;
    Font.Height := -19;
    Font.Name := 'Segoe UI';
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  rbtMultipleChoiceAnswer1 := TRadioButton.Create(FQuestionBox.Owner);
  with rbtMultipleChoiceAnswer1 do
  begin
    Name := 'rbtMultipleChoiceAnswer1' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(3, 120, 28, 34);
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 20;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    TabStop := False;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer1 := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer1 do
  begin
    Name := 'pnlMultipleChoiceAnswer1' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(20, 120, 244, 34);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpMultipleChoiceAnswer1BG := TShape.Create(FQuestionBox.Owner);
  with shpMultipleChoiceAnswer1BG do
  begin
    Name := 'shpMultipleChoiceAnswer1BG' + IntToStr(FQuestionNumber);
    Parent := pnlMultipleChoiceAnswer1;
    SetBounds(0, 0, 244, 33);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer1RemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer1RemoveBorder do
  begin
    Name := 'pnlMultipleChoiceAnswer1RemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlMultipleChoiceAnswer1;
    SetBounds(3, 3, 238, 28);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  edtMultipleChoiceAnswer1 := TEdit.Create(FQuestionBox.Owner);
  with edtMultipleChoiceAnswer1 do
  begin
    Name := 'edtMultipleChoiceAnswer1' + IntToStr(FQuestionNumber);
    Text := '';
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
    Tag := FQuestionNumber;
  end;

  rbtMultipleChoiceAnswer2 := TRadioButton.Create(FQuestionBox.Owner);
  with rbtMultipleChoiceAnswer2 do
  begin
    Name := 'rbtMultipleChoiceAnswer2' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(3, 167, 28, 34);
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 20;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    TabStop := False;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer2 := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer2 do
  begin
    Name := 'pnlMultipleChoiceAnswer2' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(20, 167, 244, 34);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpMultipleChoiceAnswer2BG := TShape.Create(FQuestionBox.Owner);
  with shpMultipleChoiceAnswer2BG do
  begin
    Name := 'shpMultipleChoiceAnswer2BG' + IntToStr(FQuestionNumber);
    Parent := pnlMultipleChoiceAnswer2;
    SetBounds(0, 0, 244, 33);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer2RemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer2RemoveBorder do
  begin
    Name := 'pnlMultipleChoiceAnswer2RemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlMultipleChoiceAnswer2;
    SetBounds(3, 3, 238, 28);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  edtMultipleChoiceAnswer2 := TEdit.Create(FQuestionBox.Owner);
  with edtMultipleChoiceAnswer2 do
  begin
    Name := 'edtMultipleChoiceAnswer2' + IntToStr(FQuestionNumber);
    Text := '';
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
    Tag := FQuestionNumber;
  end;

  rbtMultipleChoiceAnswer3 := TRadioButton.Create(FQuestionBox.Owner);
  with rbtMultipleChoiceAnswer3 do
  begin
    Name := 'rbtMultipleChoiceAnswer3' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(395, 120, 28, 34);
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 20;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    TabStop := False;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer3 := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer3 do
  begin
    Name := 'pnlMultipleChoiceAnswer3' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(412, 120, 244, 34);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpMultipleChoiceAnswer3BG := TShape.Create(FQuestionBox.Owner);
  with shpMultipleChoiceAnswer3BG do
  begin
    Name := 'shpMultipleChoiceAnswer3BG' + IntToStr(FQuestionNumber);
    Parent := pnlMultipleChoiceAnswer3;
    SetBounds(0, 0, 244, 33);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer3RemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer3RemoveBorder do
  begin
    Name := 'pnlMultipleChoiceAnswer3RemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlMultipleChoiceAnswer3;
    SetBounds(3, 3, 238, 28);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  edtMultipleChoiceAnswer3 := TEdit.Create(FQuestionBox.Owner);
  with edtMultipleChoiceAnswer3 do
  begin
    Name := 'edtMultipleChoiceAnswer3' + IntToStr(FQuestionNumber);
    Text := '';
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
    Tag := FQuestionNumber;
  end;

  rbtMultipleChoiceAnswer4 := TRadioButton.Create(FQuestionBox.Owner);
  with rbtMultipleChoiceAnswer4 do
  begin
    Name := 'rbtMultipleChoiceAnswer4' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(395, 167, 28, 34);
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 20;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    TabStop := False;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer4 := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer4 do
  begin
    Name := 'pnlMultipleChoiceAnswer4' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdMultipleChoice;
    SetBounds(412, 167, 244, 34);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpMultipleChoiceAnswer4BG := TShape.Create(FQuestionBox.Owner);
  with shpMultipleChoiceAnswer4BG do
  begin
    Name := 'shpMultipleChoiceAnswer4BG' + IntToStr(FQuestionNumber);
    Parent := pnlMultipleChoiceAnswer4;
    SetBounds(0, 0, 244, 33);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlMultipleChoiceAnswer4RemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlMultipleChoiceAnswer4RemoveBorder do
  begin
    Name := 'pnlMultipleChoiceAnswer4RemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlMultipleChoiceAnswer4;
    SetBounds(3, 3, 238, 28);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  edtMultipleChoiceAnswer4 := TEdit.Create(FQuestionBox.Owner);
  with edtMultipleChoiceAnswer4 do
  begin
    Name := 'edtMultipleChoiceAnswer4' + IntToStr(FQuestionNumber);
    Text := '';
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
    Tag := FQuestionNumber;
  end;

    { True/False }
  crdBoolean := TCard.Create(FQuestionBox.Owner);
  with crdBoolean do
  begin
    Name := 'crdBoolean' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := cplQuestionTypeOptions;
    SetBounds(0, 0, 753, 200);
    CardIndex := 2;
    Tag := FQuestionNumber;
  end;

  lblBooleanQuestion := TLabel.Create(FQuestionBox.Owner);
  with lblBooleanQuestion do
  begin
    Name := 'lblBooleanQuestion' + IntToStr(FQuestionNumber);
    Parent := crdBoolean;
    SetBounds(1, -4, 80, 25);
    Caption := 'Question';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clDefault;
    Font.Height := -19;
    Font.Name := 'Segoe UI';
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  pnlBooleanQuestionInput := TPanel.Create(FQuestionBox.Owner);
  with pnlBooleanQuestionInput do
  begin
    Name := 'pnlBooleanQuestionInput' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdBoolean;
    SetBounds(0, 21, 751, 75);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  shpBooleanQuestionInputBG := TShape.Create(FQuestionBox.Owner);
  with shpBooleanQuestionInputBG do
  begin
    Name := 'shpBooleanQuestionInputBG' + IntToStr(FQuestionNumber);
    Parent := pnlBooleanQuestionInput;
    SetBounds(0, 0, 751, 74);
    Shape := stRoundRect;
    Tag := FQuestionNumber;
  end;

  pnlBooleanQuestionInputRemoveBorder := TPanel.Create(FQuestionBox.Owner);
  with pnlBooleanQuestionInputRemoveBorder do
  begin
    Name := 'pnlBooleanQuestionInputRemoveBorder' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := pnlBooleanQuestionInput;
    SetBounds(6, 6, 741, 61);
    BevelOuter := bvNone;
    Tag := FQuestionNumber;
  end;

  memBooleanQuestionInput := TMemo.Create(FQuestionBox.Owner);
  with memBooleanQuestionInput do
  begin
    Name := 'memBooleanQuestionInput' + IntToStr(FQuestionNumber);
    Parent := pnlBooleanQuestionInputRemoveBorder;
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
    Lines.Clear;
    Lines.AddStrings(['Question Text']);
    ParentFont := False;
    Tag := FQuestionNumber;

    OnEnter := ClearMemoHint;
    OnExit := ShowMemoHint;
  end;

  lblBooleanAnswer := TLabel.Create(FQuestionBox.Owner);
  with lblBooleanAnswer do
  begin
    Name := 'lblBooleanAnswer' + IntToStr(FQuestionNumber);
    Parent := crdBoolean;
    SetBounds(1, 95, 66, 25);
    Caption := 'Answer';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clDefault;
    Font.Height := -19;
    Font.Name := 'Segoe UI';
    Font.Style := [fsBold];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  rbtBooleanAnswerTrue := TRadioButton.Create(FQuestionBox.Owner);
  with rbtBooleanAnswerTrue do
  begin
    Name := 'rbtBooleanAnswerTrue' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdBoolean;
    SetBounds(3, 120, 20, 34);
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 20;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    TabStop := False;
    Tag := FQuestionNumber;
  end;

  lblBooleanAnswerTrue := TLabel.Create(FQuestionBox.Owner);
  with lblBooleanAnswerTrue do
  begin
    Name := 'lblBooleanAnswerTrue' + IntToStr(FQuestionNumber);
    Parent := crdBoolean;
    SetBounds(23, 125, 30, 21);
    Caption := 'True';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 21;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  rbtBooleanAnswerFalse := TRadioButton.Create(FQuestionBox.Owner);
  with rbtBooleanAnswerFalse do
  begin
    Name := 'rbtBooleanAnswerFalse' + IntToStr(FQuestionNumber);
    Caption := '';
    Parent := crdBoolean;
    SetBounds(3, 160, 20, 34);
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 20;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    TabStop := False;
    Tag := FQuestionNumber;
  end;
  lblBooleanAnswerFalse := TLabel.Create(FQuestionBox.Owner);
  with lblBooleanAnswerFalse do
  begin
    Name := 'lblBooleanAnswerFalse' + IntToStr(FQuestionNumber);
    Parent := crdBoolean;
    SetBounds(23, 165, 34, 21);
    Caption := 'False';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := 21;
    Font.Name := 'Segoe UI';
    Font.Style := [];
    ParentFont := False;
    Tag := FQuestionNumber;
  end;

  cplQuestionTypeOptions.ActiveCard := crdTextAnswer;
  FQuestions.Add(pnlQuestion);
  FNonDeletedQuestions.Add(pnlQuestion);

  if FQuestionTop + pnlQuestion.Height > FFromScroll.VertScrollBar.Range then
  begin
    FFromScroll.VertScrollBar.Range := FFromScroll.VertScrollBar.Range + Round(pnlQuestion.Height * 1.1);
  end;
  Inc(FQuestionTop, Round(pnlQuestion.Height * 1.1))

end;

procedure TEditQuizManager.AddQuestionFromButton(QuestionNumber: Integer);
begin
  AddQuestion;
end;

procedure TEditQuizManager.RemoveQuestionFromButton(QuestionNumber: Integer);
var
  QuestionID: integer;
  QuestionPanel: TPanel;
  QuestionTitle: TLabel;
  QuestionTop, QuestionBoxHeight, ScrollerHeight: integer;
  height: integer;
  i: integer;
begin
  ShowMessage('Remove question at index ' + IntToStr(QuestionNumber));
  QuestionID := QuestionNumber - 1;
  for i := QuestionNumber to FNonDeletedQuestions.Count - 1 do
  begin
    QuestionPanel := FQuestions[i];
    QuestionTitle := GetComponent('lblQuestionNumber' + IntToStr(i + 1)) as TLabel;
    QuestionTitle.Caption := 'Question ' + IntToStr(i);
    QuestionPanel.Top := QuestionPanel.Top - Round(QuestionPanel.Height * 1.1);
  end;
  Dec(FQuestionTop, Round(325 * 1.1));
  Dec(FScrollerRange, Round(325 * 1.1));

  FFromScroll.VertScrollBar.Range := FScrollerRange;
  height := FQuestionBox.Height;
  Dec(height, Round(325 * 1.1));

  FQuestionBox.Height := height;
  QuestionTitle := GetComponent('lblQuestionNumber' + IntToStr(QuestionNumber)) as TLabel;
  QuestionTitle.Caption := 'Deleted';
  QuestionPanel := FQuestions[QuestionID];
  FNonDeletedQuestions.Remove(QuestionPanel);
end;

procedure TEditQuizManager.AddQuestionClick(Sender: TObject);
begin
  if (CheckForFields(Sender) = 1) and (CheckAllFields = 1) then
    AddQuestionFromButton(TImage(Sender).Tag)
  else
    ShowMessage('Please enter all question fields.')
end;

procedure TEditQuizManager.RemoveQuestionClick(Sender: TObject);
begin
  if FNonDeletedQuestions.Count = 1 then
    ShowMessage('Cannot delete the only question.')
  else
    RemoveQuestionFromButton(TImage(Sender).Tag)
end;

procedure TEditQuizManager.ChangeQuestionType(Sender: TObject);
var
  CardPanel: TCardPanel;
  Index: Integer;
  QuestionPanel: TPanel;
begin
  Index := TComboBox(Sender).Items.IndexOf(TComboBox(Sender).Text);
  if Index <> -1 then
  begin
    CardPanel := GetComponent('cplQuestionTypeOptions' + IntToStr(TComboBox(Sender).Tag)) as TCardPanel;
    CardPanel.ActiveCard := CardPanel.Cards[Index]
  end
  else
    ShowMessage('Please select a valid question type.')
end;

procedure TEditQuizManager.ShowMemoHint(Sender: TObject);
begin
  if Trim(TMemo(Sender).Text) = '' then
  begin
    TMemo(Sender).Lines.Clear;
    TMemo(Sender).Font.Color := clWindowFrame;
    if TMemo(Sender).Hint = 'Enter the question.' then
      TMemo(Sender).Lines[0] := 'Question Text'
    else if TMemo(Sender).Hint = 'Enter the answer for the question.' then
      TMemo(Sender).Lines[0] := 'Answer Text'
  end;
end;

procedure TEditQuizManager.ClearMemoHint(Sender: TObject);
begin
  with TMemo(Sender) do
  begin
    if Font.Color = clWindowFrame then
    begin
      Lines.Clear;
      Font.Color := clWindowText
    end;

  end;
end;

function TEditQuizManager.CheckForFields(Sender: TObject): Integer;
var
  Option: TComboBox;
begin
  for Option in FQuestionOptions do
  begin
    if Option.Items.IndexOf(Option.Text) = -1 then
      Result := -1
    else
      Result := 1
  end;
end;

function TEditQuizManager.GetComponent(Name: string): TComponent;
var
  i: Integer;
begin
  for i := 0 to FQuestionBox.Owner.ComponentCount - 1 do
  begin
    if FQuestionBox.Owner.Components[i].Name = Name then
    begin
      Result := FQuestionBox.Owner.Components[i];
      break;
    end;
  end;
end;

function TEditQuizManager.TryAddQuiz: Integer;
var
  Memos: TList<TMemo>;
  Edits: TList<TEdit>;
  RadioButtons: TList<TRadioButton>;
  CardPanel: TCardPanel;
  ActiveCard: TCard;
  I: Integer;
  QuestionID: integer;
  QuizTitleEdit, QuizCategoryEdit: TEdit;
  QuizDescriptionMemo: TMemo;
  QuizTitle, QuizCategory, QuizDescription: string;
  Question: TQuestion;
  Quiz: TList<TQuestion>;
  QuizID: Integer;
begin
  // TryAddQuiz
  // Purpose: Validate all quiz-level metadata and question inputs, build
  // a TList<TQuestion> and call dmDatabase.AddQuiz to persist the
  // custom quiz. Returns the created QuizID on success or -1 on failure.
  // Behavior notes:
  // - Shows user messages for missing fields or parse errors.
  // - Ownership: the created TList<TQuestion> (Quiz) is freed by this
  //   routine after AddQuiz is called; dmDatabase.AddQuiz copies data
  //   into the DB and returns an integer id.
  Memos := TList<TMemo>.Create;
  Edits := TList<TEdit>.Create;
  RadioButtons := TList<TRadioButton>.Create;
  try
    Result := -1;
    QuizTitleEdit := GetComponent('edtCustomQuizTitle') as TEdit;
    QuizCategoryEdit := GetComponent('edtCustomQuizCategory') as TEdit;
    QuizDescriptionMemo := GetComponent('memCustomQuizDescription') as TMemo;

    Quiz := TList<TQuestion>.Create;

    if (CheckTextEmpty(QuizTitleEdit) = True) or (CheckTextEmpty(QuizCategoryEdit) = True) or (CheckTextEmpty(QuizDescriptionMemo) = True) then
    begin
      ShowMessage('Please enter quiz options.');
    end
    else
    begin
      var Continu : Boolean;

      QuizTitle := QuizTitleEdit.Text;
      QuizCategory := QuizCategoryEdit.Text;
      QuizDescription := QuizDescriptionMemo.Text;

      Continu := True;

      for I := 1 to FNonDeletedQuestions.Count do
      begin
        QuestionID := FQuestions.IndexOf(FNonDeletedQuestions[I - 1]);
        CardPanel := FQuestionBox.Owner.FindComponent('cplQuestionTypeOptions' + IntToStr(QuestionID + 1)) as TCardPanel;
        ActiveCard := CardPanel.ActiveCard;
        GetQuestionControls(ActiveCard, Memos, Edits, RadioButtons);

    //          ShowMessage(Format('Found %d memos, %d edits, %d radiobuttons',
    //            [Memos.Count, Edits.Count, RadioButtons.Count]));

        if CheckAllFields <> 1 then
        begin
          ShowMessage('Please enter all question options');
          Continu := False;
          break;
        end
        else
        begin
          Question := CreateQuestion(QuestionID, Memos, Edits, RadioButtons);
          Quiz.Add(Question);
        end;
        Memos.Clear;
        Edits.Clear;
        RadioButtons.Clear;
      end;
      if Continu then
      begin
        QuizID := dmDatabase.AddQuiz(QuizTitle, QuizDescription, QuizCategory, 'User', 'User', Quiz);

        ShowMessage('Custom quiz created at idex ' + IntToStr(QuizID));
        Result := QuizID;
      end;


    end;
  finally
    Memos.Free;
    Edits.Free;
    RadioButtons.Free;
    Quiz.Free;
  end;
end;

procedure TEditQuizManager.GetQuestionControls(Card: TCard; var Memos: TList<TMemo>; var Edits: TList<TEdit>; var RadioButtons: TList<TRadioButton>);

  procedure RecurseControls(Parent: TWinControl);
  var
    i: Integer;
    C: TControl;
  begin
    for i := 0 to Parent.ControlCount - 1 do
    begin
      C := Parent.Controls[i];

      // Check type
      if C is TMemo then
        Memos.Add(TMemo(C))
      else if C is TEdit then
        Edits.Add(TEdit(C))
      else if C is TRadioButton then
        RadioButtons.Add(TRadioButton(C));

      // Recurse if the control can have children
      if C is TWinControl then
        RecurseControls(TWinControl(C));
    end;
  end;

begin
  RecurseControls(Card);
end;

function TEditQuizManager.CheckFields(var Memos: TList<TMemo>; var Edits: TList<TEdit>; var RadioButtons: TList<TRadioButton>): integer;
var
  Memo: TMemo;
  Edit: TEdit;
  RadioButton: TRadioButton;
  MemoText: string;
  EditCount, RadioButtonCount: integer;
  RadioEdit: TEdit;
  RadioName: string;
begin
  // CheckFields
  // Purpose: Validate controls for a single question card.
  // Rules implemented:
  // - If the card contains two TMemo controls, treat it as a text question
  //   and ensure both memo values are non-empty and not placeholder text.
  // - Otherwise treat it as either multiple-choice or boolean and ensure
  //   at least one radio button is selected and (for multiple choice)
  //   that the corresponding Edit control contains text.
  // Returns: 1 if validation passes, 0 otherwise.
  // Notes: This function relies on control naming conventions (e.g.
  // edtMultipleChoiceAnswerX) to locate linked edits for radio buttons.
  // Changing control naming will break validation.
  //MemoCheck:
  Result := 1;
  for Memo in Memos do
  begin
    MemoText := Trim(Memo.Text);
    if (MemoText = '') or (MemoText = 'Question Text') or (MemoText = 'Answer Text') then
    begin
      Result := 0;
      Break
    end
    else
    begin
      Result := 1;
    end;
  end;

  if (Memos.Count = 2) then
  begin
    Result := Result
  end
  else
  begin
      //RadioButtonCheck:
    RadioButtonCount := 0;
    for RadioButton in RadioButtons do
    begin
      RadioName := RadioButton.Name;
      if Copy(RadioName, 4, 7) = 'Multipl' then
      begin
        RadioEdit := GetComponent('edtMultipleChoiceAnswer' + RadioName[24] + IntToStr(FQuestionNumber)) as TEdit;
        if (RadioButton.Checked = True) and (RadioEdit.Text <> '') then
        begin
          Inc(RadioButtonCount);
        end;
      end
      else if Copy(RadioName, 4, 7) = 'Boolean' then
      begin
        if (RadioButton.Checked = True) then
        begin
          Inc(RadioButtonCount);
        end;
      end;
    end;
    if RadioButtonCount >= 1 then
    begin
      Result := 1;
    end
    else
    begin
      Result := 0;
    end;
  end;

end;

function TEditQuizManager.CheckAllFields: Integer;
var
  Memos: TList<TMemo>;
  Edits: TList<TEdit>;
  RadioButtons: TList<TRadioButton>;
  CardPanel: TCardPanel;
  ActiveCard: TCard;
  I: Integer;
begin
  // CheckAllFields
  // Purpose: Iterate over all non-deleted question cards and validate
  // their input controls by calling CheckFields. Returns 1 only if all
  // questions pass validation; otherwise returns 0.
  // Notes: Temporary lists are created to collect controls for each
  // question and are freed before returning.
  Memos := TList<TMemo>.Create;
  Edits := TList<TEdit>.Create;
  RadioButtons := TList<TRadioButton>.Create;
  try
    for I := 1 to FNonDeletedQuestions.Count do
    begin
      CardPanel := FQuestionBox.Owner.FindComponent('cplQuestionTypeOptions' + IntToStr(FQuestions.IndexOf(FNonDeletedQuestions[I - 1]) + 1)) as TCardPanel;
      ActiveCard := CardPanel.ActiveCard;
      GetQuestionControls(ActiveCard, Memos, Edits, RadioButtons);

//          ShowMessage(Format('Found %d memos, %d edits, %d radiobuttons',
//            [Memos.Count, Edits.Count, RadioButtons.Count]));

      if CheckFields(Memos, Edits, RadioButtons) <> 1 then
      begin
        Result := 0;
      end
      else
      begin
        Result := 1;
      end;

      Memos.Clear;
      Edits.Clear;
      RadioButtons.Clear;
    end;
  finally
    Memos.Free;
    Edits.Free;
    RadioButtons.Free;
  end;
end;

function TEditQuizManager.CreateQuestion(QuestionID: integer; var Memos: TList<TMemo>; var Edits: TList<TEdit>; var RadioButtons: TList<TRadioButton>): TQuestion;
const
  CTypes: array[0..2] of string = ('text', 'multiple', 'boolean');
begin
  // CreateQuestion
  // Purpose: Build a TQuestion instance from the UI controls collected
  // for a question card. The function maps control values to the
  // TQuestion fields using control naming and ordering conventions.
  // Important:
  // - Caller receives ownership of the returned TQuestion and its
  //   Options list.
  // - For multiple choice the selected radio button determines
  //   Question.Answer; remaining edits are added to Question.Options.
  // - For boolean questions one option (the opposite) is automatically
  //   added to Options.
  Question := TQuestion.Create;
  Question.QuestionType := CTypes[FQuestionOptions[0 + (QuestionID * 2)].Items.IndexOf(FQuestionOptions[0 + (QuestionID * 2)].Text)];
  Question.Difficulty := FQuestionOptions[1 + (QuestionID * 2)].Text;
  Question.Question := Memos[0].Text;
    { Text Answer }
  if Memos.Count = 2 then
  begin
    Question.Answer := Memos[1].Text;
  end
    { Multiple Choice }
  else if RadioButtons.Count = 4 then
  begin
    var RadioButton: TRadioButton;
    var ActiveRadioID: string;
    var ActiveEdt, Edit: TEdit;
    for RadioButton in RadioButtons do
    begin
      if RadioButton.Checked = True then
      begin
        ActiveRadioID := RadioButton.Name[24];
        ActiveEdt := GetComponent('edtMultipleChoiceAnswer' + ActiveRadioID + IntToStr(QuestionID + 1)) as TEdit;

        Question.Answer := ActiveEdt.Text;
      end;
    end;
    for Edit in Edits do
    begin
      if (Edit.Text <> '') and (Edit.Text <> Question.Answer) then
      begin
        Question.Options.Add('"' + Edit.Text + '"');
      end;
    end;
  end
    { True/False }
  else if RadioButtons.Count = 2 then
  begin
    var RadioButton: TRadioButton;
    var Answer: string;
    for RadioButton in RadioButtons do
    begin
      if RadioButton.Checked = True then
      begin
        Answer := Copy(RadioButton.Name, 17, 4);
        if Answer = 'True' then
        begin
          Question.Answer := 'True';
          Question.Options.Add('"False"');
        end
        else
        begin
          Question.Answer := 'False';
          Question.Options.Add('"True"');
        end;
      end;
    end;
  end;
  Result := Question;
end;

function TEditQuizManager.CheckTextEmpty(Edit: TEdit): Boolean;
begin
  Result := False;
  if Trim(Edit.Text) = '' then
    Result := True;
end;

function TEditQuizManager.CheckTextEmpty(Memo: TMemo): Boolean;
begin
  Result := False;
  if Trim(Memo.Text) = '' then
    Result := True;
end;

end.
