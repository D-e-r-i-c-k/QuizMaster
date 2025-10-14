// clsQuizAnswerManager_u.pas
// Purpose: Contains logic to manage quiz answers lifecycle within the
// application (saving, retrieving, and processing answers). NO CODE
// BEHAVIOR CHANGED — comments only.

unit clsQuizAnswerManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.WinXPanels,
  System.Generics.Collections, System.JSON, Vcl.ComCtrls,

  clsQuestion_u, dbMain_u, clsAnswer_u, clsAiQuizCaller_u, frmResults_u;

type
  TAnswerManager = class
    private
      FQuiz: TList<TQuestion>;
      FTitle: string;
      FQuestions: TList<TCard>;
      FQuizPanel: TCardPanel;
      FCurrentID: integer;
      FProgressBar: TProgressBar;
      FAnswers: TList<TAnswer>;
      FRadioButtons: TList<TList<TRadioButton>>;
      FMultipleChoiceOptions: TList<TList<TLabel>>;
      FQuizID: integer;
    public
      constructor Create(QuizID: integer; QuizPanel: TCardPanel; ProgressBar: TProgressBar);

      function GetQuizDetails(QuizID: integer): Boolean;
      function LoadQuiz(Quiz: TList<TQuestion>; QuizPanel: TCardPanel): Boolean;
      function GetAnswers: TList<TAnswer>;
      function GetComponent(Name: string): TComponent;
      function GetScore(Answers: TList<TAnswer>): real;

      procedure ShowFirstQuestion(QuizPanel: TCardPanel);
      procedure ShowNextQuestion(QuizPanel: TCardPanel);
      procedure ShowPrevQuestion(QuizPanel: TCardPanel);
      procedure ShowAnswers(Answers: TList<TAnswer>);

  end;
var
  AiCaller: TAiQuizCaller;
  ResultsForm: TfrmResults;

implementation

constructor TAnswerManager.Create(QuizID: integer; QuizPanel: TCardPanel; ProgressBar: TProgressBar);
var
  AmountQuestions: integer;

begin
  FQuestions := TList<TCard>.Create;
  FProgressBar := ProgressBar;
  FProgressBar.Position := 0;
  FQuizPanel := QuizPanel;
  FQuizID := QuizID;

  AiCaller := TAiQuizCaller.Create;
  FAnswers := TList<TAnswer>.Create;
  FRadioButtons := TList<TList<TRadioButton>>.Create;
  FMultipleChoiceOptions := TList<TList<TLabel>>.Create;

  if GetQuizDetails(QuizID) then
  begin
    if LoadQuiz(FQuiz, QuizPanel) then
    begin
      FCurrentID := 0;
      ShowFirstQuestion(QuizPanel);
    end
    else
    begin
      ShowMessage('Failed to load the quiz.');
      Exit
    end;

  end
  else
  begin
    ShowMessage('Error loading Quiz');
    Exit
  end;

end;

function TAnswerManager.GetQuizDetails(QuizID: Integer): Boolean;
begin
  try
    FTitle := dmDatabase.GetQuizDetails(QuizID)[0];
    FQuiz := dmDatabase.GetQuiz(QuizID);
    Result := True;
  except
    Result := False;
  end;
end;

function TAnswerManager.LoadQuiz(Quiz: TList<TQuestion>; QuizPanel: TCardPanel): Boolean;
var
  Question: TQuestion;
  QuestionNumber: Integer;

  crdQuestion: TCard;
  lblQuestionNumber, lblFalse, lblTrue, blQuestionDifficulty: TLabel;
  memQuestionText: TMemo;
  pnlAnswer, pnlTextAnswer, pnlTextAnswerRemoveBorder, pnlQuestionDifficulty: TPanel;
  cplAnswerType: TCardPanel;
  crdTextAnswer, crdBoolean, crdMultipleChoice: TCard;
  shpTextAnswerBG, shpBooleanAnswerBG, shpQuestionDifficultyBG, shpMultipleChoiceAnswerBG: TShape;
  memTextAnswer: TMemo;
  rbtBooleanTrue, rbtBooleanFalse: TRadioButton;
  lblMultipleChoiceAnswer1, lblMultipleChoiceAnswer2, lblMultipleChoiceAnswer3, lblMultipleChoiceAnswer4: TLabel;
  rbtMultipleChoice1, rbtMultipleChoice2, rbtMultipleChoice3, rbtMultipleChoice4: TRadioButton;
  RadioButtons: TList<TRadioButton>;
  MultipleChoiceOptions: TList<TLabel>;
begin
  QuestionNumber := 0;

  for Question in Quiz do
  begin
    Inc(QuestionNumber);
    RadioButtons := TList<TRadioButton>.Create;
    MultipleChoiceOptions := TList<TLabel>.Create;

    // === CARD ===
    crdQuestion := TCard.Create(QuizPanel.Owner);
    with crdQuestion do
    begin
      Name := 'crdQuestion' + IntToStr(QuestionNumber);
      Parent := QuizPanel;
      SetBounds(0, 0, 769, 325);
      Caption := '';
      CardIndex := 0;
      TabOrder := 0;
    end;

    // === QUESTION NUMBER LABEL ===
    lblQuestionNumber := TLabel.Create(QuizPanel.Owner);
    with lblQuestionNumber do
    begin
      Name := 'lblQuestionNumber' + IntToStr(QuestionNumber);
      Parent := crdQuestion;
      SetBounds(12, 8, 108, 28);
      Caption := 'Question ' + IntToStr(QuestionNumber) + ':';
      Font.Name := 'Segoe UI';
      Font.Style := [fsBold];
      Font.Height := 28;
      ParentFont := False;
    end;

    // === QUESTION TEXT ===
    memQuestionText := TMemo.Create(QuizPanel.Owner);
    with memQuestionText do
    begin
      Name := 'lblQuestionText' + IntToStr(QuestionNumber);
      Parent := crdQuestion;
      Left := 12;
      Top := 88;
      Width := 720;
      Height := 100;   // initial height
      Font.Name := 'Segoe UI';
      Font.Height := 26;
      ReadOnly := True;
      BorderStyle := bsNone;
      WordWrap := True;
      Text := Question.Question;
      TabStop := False;
      if Lines.Count > 2 then
      begin
        Font.Height := Font.Height - ((Lines.Count - 2) * 6)
      end;
    end;

    // === QUESTION DIFFICULTY ===
    pnlQuestionDifficulty := TPanel.Create(QuizPanel.Owner);
    with pnlQuestionDifficulty do
    begin
      Name := 'pnlQuestionDifficulty' + IntToStr(QuestionNumber);
      Parent := crdQuestion;
      SetBounds(32, 40, 70, 25);
      BevelOuter := bvNone;
    end;

    shpQuestionDifficultyBG := TShape.Create(QuizPanel.Owner);
    with shpQuestionDifficultyBG do
    begin
      Name := 'shpQuestionDifficultyBG' + IntToStr(QuestionNumber);
      Parent := pnlQuestionDifficulty;
      SetBounds(0, 0, 70, 25);
      Brush.Color := clAppWorkSpace;
      Pen.Color := clMedGray;
      Shape := stRoundRect;
    end;

    blQuestionDifficulty := TLabel.Create(QuizPanel.Owner);
    with blQuestionDifficulty do
    begin
      Name := 'blQuestionDifficulty' + IntToStr(QuestionNumber);
      Parent := pnlQuestionDifficulty;
      Alignment := taCenter;
      Font.Height := 18;
      Font.Style := [fsBold];
      AutoSize := False;
      SetBounds(0, 4, 70, 17);
      Caption := UpperCase(Question.Difficulty);
    end;

    // === ANSWER PANEL ===
    pnlAnswer := TPanel.Create(QuizPanel.Owner);
    with pnlAnswer do
    begin
      Name := 'pnlAnswer' + IntToStr(QuestionNumber);
      Parent := crdQuestion;
      SetBounds(10, 145, 750, 160);
      BevelOuter := bvNone;
      TabOrder := 0;
    end;

    // === CARD PANEL FOR ANSWER TYPES ===
    cplAnswerType := TCardPanel.Create(QuizPanel.Owner);
    with cplAnswerType do
    begin
      Name := 'cplAnswerType' + IntToStr(QuestionNumber);
      Parent := pnlAnswer;
      SetBounds(0, 0, 750, 160);
      BevelOuter := bvNone;
      Caption := '';
      TabOrder := 0;
    end;

    // === TEXT ANSWER CARD ===
    crdTextAnswer := TCard.Create(QuizPanel.Owner);
    with crdTextAnswer do
    begin
      Name := 'crdTextAnswer' + IntToStr(QuestionNumber);
      Parent := cplAnswerType;
      SetBounds(0, 0, 750, 160);
      Caption := 'Text';
      CardIndex := 0;
      TabOrder := 0;
    end;

    // === PANEL INSIDE TEXT ANSWER ===
    pnlTextAnswer := TPanel.Create(QuizPanel.Owner);
    with pnlTextAnswer do
    begin
      Name := 'pnlTextAnswer' + IntToStr(QuestionNumber);
      Parent := crdTextAnswer;
      SetBounds(-1, 0, 750, 160);
      BevelOuter := bvNone;
      TabOrder := 0;
    end;

    // === BACKGROUND SHAPE FOR TEXT ANSWER ===
    shpTextAnswerBG := TShape.Create(QuizPanel.Owner);
    with shpTextAnswerBG do
    begin
      Name := 'shpTextAnswerBG' + IntToStr(QuestionNumber);
      Parent := pnlTextAnswer;
      SetBounds(1, 0, 748, 160);
      Shape := stRoundRect;
    end;

    // === BORDER REMOVAL PANEL ===
    pnlTextAnswerRemoveBorder := TPanel.Create(QuizPanel.Owner);
    with pnlTextAnswerRemoveBorder do
    begin
      Name := 'pnlTextAnswerRemoveBorder' + IntToStr(QuestionNumber);
      Parent := pnlTextAnswer;
      SetBounds(7, 7, 736, 146);
      BevelOuter := bvNone;
      TabOrder := 0;
    end;

    // === MEMO FOR TEXT ANSWER ===
    memTextAnswer := TMemo.Create(QuizPanel.Owner);
    with memTextAnswer do
    begin
      Name := 'memTextAnswer' + IntToStr(QuestionNumber);
      Parent := pnlTextAnswerRemoveBorder;
      SetBounds(-1, -1, 738, 150);
      BevelInner := bvNone;
      BevelOuter := bvNone;
      Font.Name := 'Segoe UI';
      Font.Color := clWindowFrame;
      Font.Height := 18;
      Lines.Clear;
      Lines.Add('Answer Text');
      ParentFont := False;
      TabOrder := 0;
    end;

    // === BOOLEAN CARD ===
    crdBoolean := TCard.Create(QuizPanel.Owner);
    with crdBoolean do
    begin
      Name := 'crdBoolean' + IntToStr(QuestionNumber);
      Parent := cplAnswerType;
      SetBounds(0, 0, 750, 160);
      Caption := '';
      CardIndex := 1;
      TabOrder := 1;
    end;

    // === BOOLEAN SHAPE ===
    shpBooleanAnswerBG := TShape.Create(QuizPanel.Owner);
    with shpBooleanAnswerBG do
    begin
      Name := 'shpBooleanAnswerBG' + IntToStr(QuestionNumber);
      Parent := crdBoolean;
      SetBounds(2, 0, 748, 160);
      Shape := stRoundRect;
    end;

    // === TRUE / FALSE LABELS ===
    lblFalse := TLabel.Create(QuizPanel.Owner);
    with lblFalse do
    begin
      Name := 'lblFalse' + IntToStr(QuestionNumber);
      Parent := crdBoolean;
      SetBounds(37, 24, 41, 25);
      Caption := 'False';
      Font.Name := 'Segoe UI';
      Font.Height := 26;
    end;

    lblTrue := TLabel.Create(QuizPanel.Owner);
    with lblTrue do
    begin
      Name := 'lblTrue' + IntToStr(QuestionNumber);
      Parent := crdBoolean;
      SetBounds(37, 92, 36, 25);
      Caption := 'True';
      Font.Name := 'Segoe UI';
      Font.Height := 26;
    end;

    // === BOOLEAN RADIO BUTTONS ===
    rbtBooleanTrue := TRadioButton.Create(QuizPanel.Owner);
    with rbtBooleanTrue do
    begin
      Name := 'rbtBooleanTrue' + IntToStr(QuestionNumber);
      Parent := crdBoolean;
      SetBounds(11, 90, 20, 34);
      Tag := 1;
      Font.Height := 20;
      Caption := '';
    end;
    RadioButtons.Add(rbtBooleanTrue);

    rbtBooleanFalse := TRadioButton.Create(QuizPanel.Owner);
    with rbtBooleanFalse do
    begin
      Name := 'rbtBooleanFalse' + IntToStr(QuestionNumber);
      Parent := crdBoolean;
      SetBounds(11, 22, 20, 34);
      Tag := 2;
      Font.Height := 20;
      Caption := '';
    end;
    RadioButtons.Add(rbtBooleanFalse);

    // === MULTIPLE CHOICE CARD ===
    crdMultipleChoice := TCard.Create(QuizPanel.Owner);
    with crdMultipleChoice do
    begin
      Name := 'crdMultipleChoice' + IntToStr(QuestionNumber);
      Parent := cplAnswerType;
      SetBounds(0, 0, 750, 160);
      Caption := '';
      CardIndex := 2;
      TabOrder := 2;
    end;

    // === MULTIPLE CHOICE SHAPE ===
    shpMultipleChoiceAnswerBG := TShape.Create(QuizPanel.Owner);
    with shpMultipleChoiceAnswerBG do
    begin
      Name := 'shpMultipleChoiceAnswerBG' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(2, 0, 748, 160);
      Shape := stRoundRect;
    end;

    // === MULTIPLE CHOICE LABELS ===
    lblMultipleChoiceAnswer1 := TLabel.Create(QuizPanel.Owner);
    with lblMultipleChoiceAnswer1 do
    begin
      Name := 'lblMultipleChoiceAnswer1_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(45, 28, 56, 25);
      Caption := 'Venice';
      Font.Name := 'Segoe UI';
      Font.Height := 26;
      Visible := False;
    end;
    MultipleChoiceOptions.Add(lblMultipleChoiceAnswer1);

    lblMultipleChoiceAnswer2 := TLabel.Create(QuizPanel.Owner);
    with lblMultipleChoiceAnswer2 do
    begin
      Name := 'lblMultipleChoiceAnswer2_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(45, 84, 47, 25);
      Caption := 'Rome';
      Font.Name := 'Segoe UI';
      Font.Height := 26;
      Visible := False;
    end;
    MultipleChoiceOptions.Add(lblMultipleChoiceAnswer2);

    lblMultipleChoiceAnswer3 := TLabel.Create(QuizPanel.Owner);
    with lblMultipleChoiceAnswer3 do
    begin
      Name := 'lblMultipleChoiceAnswer3_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(428, 28, 40, 25);
      Caption := 'Paris';
      Font.Name := 'Segoe UI';
      Font.Height := 26;
      Visible := False;
    end;
    MultipleChoiceOptions.Add(lblMultipleChoiceAnswer4);

    lblMultipleChoiceAnswer4 := TLabel.Create(QuizPanel.Owner);
    with lblMultipleChoiceAnswer4 do
    begin
      Name := 'lblMultipleChoiceAnswer4_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(428, 84, 92, 25);
      Caption := 'Cape Town';
      Font.Name := 'Segoe UI';
      Font.Height := 26;
      Visible := False;
    end;
    MultipleChoiceOptions.Add(lblMultipleChoiceAnswer3);

    // === MULTIPLE CHOICE RADIO BUTTONS ===
    rbtMultipleChoice1 := TRadioButton.Create(QuizPanel.Owner);
    with rbtMultipleChoice1 do
    begin
      Name := 'rbtMultipleChoice1_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(11, 22, 28, 42);
      Tag := 1;
      Font.Height := 20;
      Caption := '';
      Visible := False;
    end;
    RadioButtons.Add(rbtMultipleChoice1);

    rbtMultipleChoice2 := TRadioButton.Create(QuizPanel.Owner);
    with rbtMultipleChoice2 do
    begin
      Name := 'rbtMultipleChoice2_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(11, 78, 28, 42);
      Tag := 2;
      Font.Height := 20;
      Caption := '';
      Visible := False;
    end;
    RadioButtons.Add(rbtMultipleChoice2);

    rbtMultipleChoice3 := TRadioButton.Create(QuizPanel.Owner);
    with rbtMultipleChoice3 do
    begin
      Name := 'rbtMultipleChoice3_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(394, 78, 28, 42);
      Tag := 3;
      Font.Height := 20;
      Caption := '';
      Visible := False;
    end;
    RadioButtons.Add(rbtMultipleChoice3);

    rbtMultipleChoice4 := TRadioButton.Create(QuizPanel.Owner);
    with rbtMultipleChoice4 do
    begin
      Name := 'rbtMultipleChoice4_' + IntToStr(QuestionNumber);
      Parent := crdMultipleChoice;
      SetBounds(394, 22, 28, 42);
      Tag := 4;
      Font.Height := 20;
      Caption := '';
      Visible := False;
    end;
    RadioButtons.Add(rbtMultipleChoice4);

    FQuestions.Add(crdQuestion);

    if Question.QuestionType = 'text' then
    begin
      cplAnswerType.ActiveCard := crdTextAnswer;
    end
    else if Question.QuestionType = 'boolean' then
    begin
      cplAnswerType.ActiveCard := crdBoolean;
    end
    else if Question.QuestionType = 'multiple' then
    begin
      var Labels: TArray<TLabel>;
      var RBs: TArray<TRadioButton>;
      var i: integer;

      Labels := TArray<TLabel>.Create(lblMultipleChoiceAnswer1, lblMultipleChoiceAnswer2, lblMultipleChoiceAnswer3, lblMultipleChoiceAnswer4);
      RBs := TArray<TRadioButton>.Create(rbtMultipleChoice1, rbtMultipleChoice2, rbtMultipleChoice3, rbtMultipleChoice4);

      cplAnswerType.ActiveCard := crdMultipleChoice;
      for i := 0 to Question.Options.Count - 1 do
      begin
        RBs[i].Visible := True;
        Labels[i].Visible := True;
        Labels[i].Caption := Question.Options[i];
      end;
    end;

    FRadioButtons.Add(RadioButtons);
    FMultipleChoiceOptions.Add(MultipleChoiceOptions);
  end;
  Result := True;
end;

procedure TAnswerManager.ShowFirstQuestion(QuizPanel: TCardPanel);
begin
  QuizPanel.ActiveCard := FQuestions[0];
end;

procedure TAnswerManager.ShowNextQuestion(QuizPanel: TCardPanel);
begin
  Inc(FCurrentID);
  if (FQuestions.Count > FCurrentID) and (FCurrentID >= 0) then
  begin
    QuizPanel.ActiveCard := FQuestions[FCurrentID];
    FProgressBar.Position := Round(FCurrentID/FQuestions.Count*100);
  end
  else
  begin
    FCurrentID := FQuestions.Count - 1;
    if MessageDlg('Are you sure you want to submit the quiz?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      var Answers: TList<TAnswer>;
      var AnswerForm: TForm;
      var QuizCompletionID: Integer;
      var Score: Real;

      ShowMessage('Marking quiz...' + sLineBreak + 'This can take a while, please click "okay" and wait while cursor is spinning');

      AnswerForm := FQuizPanel.Owner as TForm;
      AnswerForm.Cursor := crHourGlass;
      AnswerForm.Enabled := False;
      Answers := TList<TAnswer>.Create;
      Answers := GetAnswers;
      AnswerForm.Cursor := crDefault;
      AnswerForm.Enabled := True;
      Score := GetScore(Answers);
      QuizCompletionID := dmDatabase.CompleteQuiz(FQuizID, Score, 0, Answers);
      ResultsForm := TfrmResults.Create(Application);
      ResultsForm.QuizCompletionID := QuizCompletionID;
      ResultsForm.QuizScore := Score;
      ResultsForm.Show;
      AnswerForm.Close;
    end;
  end;
end;

procedure TAnswerManager.ShowPrevQuestion(QuizPanel: TCardPanel);
begin
  Dec(FCurrentID);
  if (FQuestions.Count > FCurrentID) and (FCurrentID >= 0) then
  begin
    QuizPanel.ActiveCard := FQuestions[FCurrentID];
    FProgressBar.Position := Round(FCurrentID/FQuestions.Count*100);
  end
  else
  begin
    ShowMessage('First Question');
    FCurrentID := 0;
  end;
end;

function TAnswerManager.GetAnswers: TList<TAnswer>;
var
  Question: TQuestion;
  Answer: TAnswer;
  QuestionNumber: integer;
begin
  // GetAnswers
  // Purpose: Walk through the UI controls for each question and build a
  // TList<TAnswer> describing the user's responses. Ownership: the
  // returned list (FAnswers) is owned by this manager; callers should not
  // free it directly unless they understand ownership semantics.
  // Notes on behavior and heuristics:
  // - Text questions are compared directly to the expected answer; if
  //   not exact the code attempts to call AI marker (AiCaller.MarkQuestion)
  //   with two different models as fallbacks. If both calls fail, the
  //   answer is marked False.
  // - Boolean and multiple choice answers are determined from selected
  //   radio buttons and compared to the expected answer.
  // - Any exceptions or missing controls may result in default False.
  QuestionNumber := 0;
  Result := nil;
  FAnswers.Clear;
  for Question in FQuiz do
  begin
    Inc(QuestionNumber);
    Answer := TAnswer.Create;
    Answer.QuestionType := Question.QuestionType;
    Answer.Difficulty := Question.Difficulty;
    Answer.ExpectedAnswer := Question.Answer;
    Answer.Question := Question.Question;
    { Text Answer }
    if Question.QuestionType = 'text' then
    begin
      var MemoAnswer: TMemo;

      MemoAnswer := GetComponent('memTextAnswer' + IntToStr(QuestionNumber)) as TMemo;
      Answer.UserAnswer := Trim(MemoAnswer.Text);

      if Answer.UserAnswer = Answer.ExpectedAnswer then
        begin
          Answer.IsCorrect := True;
        end
      else if Answer.UserAnswer = '' then
      begin
        Answer.IsCorrect := False;
      end
      else
        begin
          try
            Answer.IsCorrect := AiCaller.MarkQuestion(Question.Question, Answer.UserAnswer, Answer.ExpectedAnswer, 'tngtech/deepseek-r1t2-chimera:free');
          except
            try
              Answer.IsCorrect := AiCaller.MarkQuestion(Question.Question, Answer.UserAnswer, Answer.ExpectedAnswer, 'z-ai/glm-4.5-air:free');
            except
              ShowMessage('Couldn''t get answer for ' + Question.Question);
              Answer.IsCorrect := False;
              Continue;
            end;
          end;
        end;
    end
    { Boolean }
    else if Question.QuestionType = 'boolean' then
    begin
      var Rbt: TRadioButton;
      var UserAns: string;
      for Rbt in FRadioButtons[QuestionNumber - 1] do
      begin
        if Rbt.Checked = True then
        begin
          UserAns := Copy(Rbt.Name, 11, 4);

          if UserAns = 'True' then
          begin
            Answer.UserAnswer := 'True'
          end
          else
          begin
            Answer.UserAnswer := 'False';
          end;

          if Answer.UserAnswer = Answer.ExpectedAnswer then
          begin
            Answer.IsCorrect := True;
          end
          else
          begin
            Answer.IsCorrect := False;
          end;
        end;
      end;
    end
    else if Question.QuestionType = 'multiple' then
    begin
      var Rbt: TradioButton;
      var UserAnswer: string;
      var RbtIndex: Integer;
      for Rbt in FRadioButtons[QuestionNumber - 1] do
      begin
        if Rbt.Checked = True then
        begin
          RbtIndex := FRadioButtons[QuestionNumber - 1].IndexOf(Rbt) - 2;
          Answer.UserAnswer := FMultipleChoiceOptions[QuestionNumber - 1][RbtIndex].Caption;

          if Answer.UserAnswer = Answer.ExpectedAnswer then
          begin
            Answer.IsCorrect := True;
          end
          else
          begin
            Answer.IsCorrect := False;
          end;
        end;
      end;
    end;
    FAnswers.Add(Answer);
  end;
  Result := FAnswers;
end;

function TAnswerManager.GetComponent(Name: string): TComponent;
var
  i: Integer;
begin
  for i := 0 to FQuizPanel.Owner.ComponentCount - 1 do
  begin
    if FQuizPanel.Owner.Components[i].Name = Name then
    begin
      Result := FQuizPanel.Owner.Components[i];
      break;
    end;
  end;
end;

function TAnswerManager.GetScore(Answers: TList<TAnswer>): Real;
var
  Answer: TAnswer;
  Correct: Integer;
begin
  // GetScore
  // Purpose: Compute percentage score as (correct / total) * 100.
  // Note: If Answers.Count is zero this will raise a division by zero
  // error; callers should ensure there is at least one answer.
  Correct := 0;
  for Answer in Answers do
  begin
    if Answer.IsCorrect then
    begin
      Inc(Correct);
    end;
  end;

  Result := Correct/Answers.Count*100;
end;

procedure TAnswerManager.ShowAnswers(Answers: TList<TAnswer>);
var
  Answer: TAnswer;
  AllResults: string;
begin
  AllResults := '';
  for Answer in Answers do
  begin
    AllResults := AllResults +
      'Question Type: ' + Answer.QuestionType + sLineBreak +
      'Question : ' + Answer.Question + sLineBreak +
      'Expected: ' + Answer.ExpectedAnswer + sLineBreak +
      'Entered: ' + Answer.UserAnswer + sLineBreak +
      'Correct: ' + BoolToStr(Answer.IsCorrect, True) + sLineBreak + sLineBreak;
  end;
  ShowMessage(AllResults);
end;

end.
