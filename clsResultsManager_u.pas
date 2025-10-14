// clsResultsManager_u.pas
// Purpose: Provides helper methods for calculating and retrieving quiz
// results and statistics. This unit was only annotated with comments; no
// executable changes were made.

unit clsResultsManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.WinXPanels,
  System.Generics.Collections, System.JSON, Vcl.ComCtrls,

  dbMain_u, clsAnswer_u;

type
  TResutlsManager = class
    private
      FQuizCompletionID: Integer;
      FQuizID: Integer;
      FQuiz: TList<TAnswer>;
      FScroller: TScrollBox;

      FTop: Integer;
      FScrollerPos: Integer;
      FScrollerRange: Integer;

      FCurrentQuestion: Integer;
    public
      constructor Create(Scroller: TScrollBox; QuizCompletionID: integer);

      procedure LoadQuiz(QuizCompletionID: Integer);
      procedure LoadAnswer(Answer: TAnswer);
  end;

implementation

constructor TResutlsManager.Create(Scroller: TScrollBox; QuizCompletionID: Integer);
var
  Answer: TAnswer;
begin
  FTop := 3;
  FScrollerPos := 0;

  FCurrentQuestion := 0;

  FQuizCompletionID := QuizCompletionID;
  FQuizID := dmDatabase.GetQuizID(FQuizCompletionID);
  if dmDatabase.GetQuizDetails(FQuizID)[5] = 'Daily' then
  begin
    dmDatabase.IncStreak
  end;

  FScroller := Scroller;
  LoadQuiz(FQuizCompletionID);
  for Answer in FQuiz do
  begin
    LoadAnswer(Answer);
  end;
end;

procedure TResutlsManager.LoadQuiz(QuizCompletionID: Integer);
begin
  FQuiz := dmDatabase.GetQuizAnswers(QuizCompletionID);
end;

procedure TResutlsManager.LoadAnswer(Answer: TAnswer);
var
  pnlQuestion: TPanel;
  shpQuestionBG: TShape;
  lblQuestionNumber: TLabel;
  lblUserAnswerHeader: TLabel;
  lbExpectedAnswerHeader: TLabel;
  memQuestion: TMemo;
  memUserAnswer: TMemo;
  memExpectedAnswer: TMemo;
begin
  Inc(FCurrentQuestion);

  { Question Panel }
  pnlQuestion := TPanel.Create(FScroller);
  with pnlQuestion do
  begin
    Name := 'pnlQuestion' + IntToStr(FCurrentQuestion);
    Parent := FScroller;
    SetBounds(21, FTop, 764, 281);
    BevelOuter := bvNone;
    ShowCaption := False;
  end;

  { Question BG }
  shpQuestionBG := TShape.Create(pnlQuestion);
  with shpQuestionBG do
  begin
    Name := 'shpQuestionBG' + IntToStr(FCurrentQuestion);
    Parent := pnlQuestion;
    SetBounds(0, 0, 764, 281);
    Shape := stRoundRect;
  end;

  { Question Number }
  lblQuestionNumber := TLabel.Create(pnlQuestion);
  with lblQuestionNumber do
  begin
    Name := 'lblQuestionNumber';
    Parent := pnlQuestion;
    Left := 12;
    Top := 7;
    Width := 108;
    Height := 28;
    Caption := 'Question ' + IntToStr(FCurrentQuestion) + ':';
    Font.Height := 28;
    Font.Style := [fsBold];
    ParentFont := False;
  end;

  { User Answer Header }
  lblUserAnswerHeader := TLabel.Create(pnlQuestion);
  with lblUserAnswerHeader do
  begin
    Name := 'lblUserAnswerHeader' + IntToStr(FCurrentQuestion);
    Parent := pnlQuestion;
    SetBounds(20, 95, 46, 25);
    Caption := 'User:';
    Font.Height := 26;
    Font.Style := [fsBold];
    ParentFont := False;
  end;

  { Expected Answer Header }
  lbExpectedAnswerHeader := TLabel.Create(pnlQuestion);
  with lbExpectedAnswerHeader do
  begin
    Name := 'lbExpectedAnswerHeader' + IntToStr(FCurrentQuestion);
    Parent := pnlQuestion;
    SetBounds(20, 180, 81, 25);
    Caption := 'Expected:';
    Font.Height := 26;
    Font.Style := [fsBold];
    ParentFont := False;
  end;

  { Question Text }
  memQuestion := TMemo.Create(pnlQuestion);
  with memQuestion do
  begin
    Name := 'memQuestion' + IntToStr(FCurrentQuestion);
    Parent := pnlQuestion;
    SetBounds(20, 36, 725, 53);
    TabStop := False;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderStyle := bsNone;
    Font.Height := 24;
    ReadOnly := True;
    Text := Answer.Question;
  end;

  { User Answer Text }
  memUserAnswer := TMemo.Create(pnlQuestion);
  with memUserAnswer do
  begin
    Name := 'memUserAnswer' + IntToStr(FCurrentQuestion);
    Parent := pnlQuestion;
    SetBounds(20, 126, 725, 53);
    TabStop := False;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderStyle := bsNone;
    Font.Height := 24;
    ReadOnly := True;
    Text := Answer.UserAnswer;
  end;

  { Expected Answer Text }
  memExpectedAnswer := TMemo.Create(pnlQuestion);
  with memExpectedAnswer do
  begin
    Name := 'memExpectedAnswer' + IntToStr(FCurrentQuestion);
    Parent := pnlQuestion;
    SetBounds(20, 211, 725, 53);
    TabStop := False;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderStyle := bsNone;
    Font.Height := 24;
    ReadOnly := True;
    Text := Answer.ExpectedAnswer;
  end;

  if Answer.IsCorrect = True then
  begin
    shpQuestionBG.Brush.Color := clMoneyGreen;
    memQuestion.Color := clMoneyGreen;
    memUserAnswer.Color := clMoneyGreen;
    memExpectedAnswer.Color := clMoneyGreen;
  end
  else
  begin
    shpQuestionBG.Brush.Color := RGB(240, 128, 128);
    memQuestion.Color := RGB(240, 128, 128);
    memUserAnswer.Color := RGB(240, 128, 128);
    memExpectedAnswer.Color := RGB(240, 128, 128);
  end;
  if (FTop + pnlQuestion.Height) > FScroller.VertScrollBar.Range  then
  begin
    FScroller.VertScrollBar.Range := FScroller.VertScrollBar.Range + Round(pnlQuestion.Height * 1.1)
  end;
  Inc(FTop, Round(pnlQuestion.Height * 1.1))
end;

end.
