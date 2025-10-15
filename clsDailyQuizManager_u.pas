// clsDailyQuizManager_u.pas
// Purpose: Manages daily quiz scheduling, assignment and related
// operations.

unit clsDailyQuizManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.WinXPanels,
  System.Generics.Collections, System.DateUtils, dbMain_u, clsApiQuizCaller_u, clsQuestion_u,
  frmAnswerQuiz_u;

type
  TDailyQuizManager = class
    private
      FDateNow: TDate;
      FLastCompleted: TDate;
      FQuizBox: TPanel;
      FQuizDetails: TList<string>;
      FQuiz: TList<TQuestion>;
    public
      constructor Create(DailyQuizBox: TPanel);
      function GetComponent(Name: string): TComponent;
      function CheckForDailyQuiz: Boolean;
      procedure StartDailyQuiz(Sender: TObject);
  end;


var
  ApiCaller: TApiQuizCaller;

{
Names for the components of the DailyQuizBox:
  lblDailyAmntQuestions : Label of the amount of questions
  lblDailyStreak : Label that shows the amount of days in a row the daily quiz was done
  lblDailyTopic : Label that shows the topic of the quiz

  lblButtonStartDaily : Label to start the daily quiz when clicked
  shpButtonStartDaily : Shape to start the daily quiz when clicked
}

implementation

constructor TDailyQuizManager.Create(DailyQuizBox: TPanel);
var
  Questions, Streak, Topic, StartLbl: TLabel;
  StartShp: TShape;
begin
  ApiCaller := TApiQuizCaller.Create;
  FQuizBox := DailyQuizBox;
  dmDatabase.UpdateStreak;
  Questions := GetComponent('lblDailyAmntQuestions') as TLabel;
  Streak := GetComponent('lblDailyStreak') as TLabel;
  Topic := GetComponent('lblDailyTopic') as TLabel;
  StartLbl := GetComponent('lblButtonStartDaily') as TLabel;
  StartShp := GetComponent('shpButtonStartDaily') as TShape;
  if CheckForDailyQuiz then
  begin
    Questions.Caption := IntToStr(FQuiz.Count) + ' questions';
    Streak.Caption := IntToStr(dmDatabase.GetStreak) + ' days';
    Topic.Caption := FQuizDetails[1];

    StartLbl.OnClick := StartDailyQuiz;
  end;
end;

function TDailyQuizManager.GetComponent(Name: string): TComponent;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FQuizBox.Owner.ComponentCount - 1 do
  begin
    if FQuizBOX.Owner.Components[i].Name = Name then
    begin
      Result := FQuizbOX.Owner.Components[i];
      break;
    end;
  end;
end;

function TDailyQuizManager.CheckForDailyQuiz: Boolean;
var
  QuizID: integer;
  QuizDate: TDate;
begin
  Result := False;
  try
    QuizID := dmDatabase.GetLatestDailyQuizID;
    if QuizID <> -1 then
    begin
      FQuizDetails := dmDatabase.GetQuizDetails(QuizID);
      QuizDate := StrToDateTime(dmDatabase.GetQuizDetails(QuizID)[3]);
      if DateOf(QuizDate) = Date then
      begin
        FQuiz := dmDatabase.GetQuiz(QuizID);
        Result := True;
      end;
    end
    else
    begin
      ShowMessage('No quiz with ID: ' + IntToStr(QuizID));
    end;
  except
    ShowMessage('Error finding quiz.')
  end;
end;

procedure TDailyQuizManager.StartDailyQuiz(Sender: TObject);
var
  QuizAnswerForm: TfrmAnswerQuiz;
begin
  if dmDatabase.DailyQuizCompleted then
  begin
    ShowMessage('Quiz for today already completed, come back tomorrow to build your streak!')
  end
  else
  begin
    QuizAnswerForm := TfrmAnswerQuiz.Create(Application);
    QuizAnswerForm.QuizID := dmDatabase.GetDailyQuizQuizID;
    QuizAnswerForm.Show;
  end;

end;

end.
