unit dbMain_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Vcl.Dialogs, System.Variants,
  System.Generics.Collections, clsQuestion_u, clsAnswer_u;

type
  TdmDatabase = class(TDataModule)
    conDB: TADOConnection;
    tblQuizzes: TADOTable;
    dsQuizzes: TDataSource;
    tblQuestions: TADOTable;
    dsQuestions: TDataSource;
    tblQCS: TADOTable;
    dsQCS: TDataSource;
    tblAnswers: TADOTable;
    dsAnswers: TDataSource;
    tblDailyQuizzes: TADOTable;
    dsDailyQuizzes: TDataSource;
    tblStreak: TADOTable;
    dsStreak: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function DBListToStringList(DBList: string): TList<string>;
  public
    { Public declarations }
    function AddQuiz(Title, Description, Subject, Source, QType: string; Questions: TList<TQuestion>): integer;
    function AddQuestion(QuizID: integer; Question: TQuestion): integer;
    function AddDailyQuiz(Title, Description: string; Questions: TList<TQuestion>): integer;
    function GetAllNonDailyIDs: TList<integer>;
    function GetQuizDetails(QuizID: integer): TList<string>;
    function GetQuiz(QuizID: integer): TList<TQuestion>;
    function CompleteQuiz(QuizID: integer; Score: Real; TimeTaken: Ttime; Answers: TList<TAnswer>): Integer;
    function AddQuizCompletion(QuizID: integer; Score: Real; TimeTaken: Ttime): Integer;
    function AddAnswer(QuizCompletionID: integer; QuestionID: integer; UserAnswer: string; TimeTaken: TTime; Correct: Boolean; ExpectedAns: string): Integer;
    function GetQuizAnswers(QuizCompletionID: Integer): TList<TAnswer>;
    function GetQuestionID(QuizID: Integer; Question: string): Integer;
    function UpdateDetails(QuizID: Integer; QuizTitle: string; QuizCategory: string; QuizDescription: string): integer;
    function DeleteQuiz(QuizID: Integer): Integer;
    function GetLatestDailyQuizID: Integer;
    function CountSavedQuizzes: Integer;
    function CountCompletedQuizzes: Integer;
    function GetAvScore: Real;
    function DailyQuizCompleted: Boolean;
    function GetDailyQuizQuizID: Integer;
    function GetAnswerCount: Integer;
    function GetStreak: Integer;
    function UpdateStreak: Integer;
    function GetQuizID(QuizCompletionID: integer): Integer;
    function IncStreak: Integer;
  end;

var
  dmDatabase: TdmDatabase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmDatabase.AddQuiz(Title: string; Description: string; Subject: string; Source: string; QType: string; Questions: TList<TQuestion>): Integer;
var
  q: TQuestion;
  quizID: integer;
begin
  dmDatabase.tblQuizzes.Insert;
  dmDatabase.tblQuizzes['Title'] := Title;
  dmDatabase.tblQuizzes['Description'] := Description;
  dmDatabase.tblQuizzes['Subject'] := Subject;
  dmDatabase.tblQuizzes['DateCreated'] := Now;
  dmDatabase.tblQuizzes['Source'] := Source;
  dmDatabase.tblQuizzes['QType'] := QType;
  dmDatabase.tblQuizzes.Post;
  dmDatabase.tblQuizzes.Last;

  quizID := dmDatabase.tblQuizzes['QuizID'];

  for q in Questions do
  begin
    AddQuestion(quizID, q);
  end;

  Result := quizID;
end;

procedure TdmDatabase.DataModuleCreate(Sender: TObject);
begin
  dmDatabase.conDB.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=database.mdb;Mode=ReadWrite;Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False;';
  dmDatabase.conDB.Connected := True;
  tblQuizzes.Open;
  tblQuestions.Open;
  tblQCS.Open;
  tblAnswers.Open;
  tblDailyQuizzes.Open;
  tblStreak.Open;
end;

function TdmDatabase.AddQuestion(QuizID: Integer; Question: TQuestion): integer;
var
  possibleAns: string;
  PossibleAnswerList: TList<string>;
  s: string;
begin
  // PosibleAnswerList Creation
  PossibleAnswerList := TList<string>.Create;
  PossibleAnswerList := Question.Options;

  // List to CSV string:
  possibleAns := '';
  Randomize;
  PossibleAnswerList.Insert(Random(PossibleAnswerList.Count), '"' + Question.Answer + '"');

  for s in PossibleAnswerList do
  begin
    if possibleAns = '' then
    begin
      possibleAns := s.Replace('"', '|');
    end
    else
    begin
      possibleAns := possibleAns + ', ' + s.Replace('"', '|');
    end;
  end;

  // Add to db:
  dmDatabase.tblQuestions.Insert;
  dmDatabase.tblQuestions['QuizID'] := QuizID;
  dmDatabase.tblQuestions['Question'] := Question.Question;
  dmDatabase.tblQuestions['Difficulty'] := Question.Difficulty;
  dmDatabase.tblQuestions['CorrectAnswer'] := Question.Answer;
  dmDatabase.tblQuestions['PossibleAnswers'] := possibleAns;
  dmDatabase.tblQuestions['Type'] := Question.QuestionType;
  dmDatabase.tblQuestions.Post;
  dmDatabase.tblQuestions.Last;

  Result := dmDatabase.tblQuestions['QuestionID']
end;

function TdmDatabase.AddDailyQuiz(Title: string; Description: string; Questions: TList<TQuestion>): integer;
var
  QuizID: integer;
  q: TQuestion;
begin
  // Quiz Addition
  QuizID := AddQuiz(Title, Description, '', 'API', 'Daily', Questions);

  // DailyQuizzes Addition
  dmDatabase.tblDailyQuizzes.Insert;
  dmDatabase.tblDailyQuizzes['QuizID'] := QuizID;
  dmDatabase.tblDailyQuizzes['Title'] := Title;
  dmDatabase.tblDailyQuizzes['DateAssigned'] := Now;
  dmDatabase.tblDailyQuizzes.Post;
  dmDatabase.tblDailyQuizzes.Last;

  Result := dmDatabase.tblDailyQuizzes['ChallengeID'];
end;

function TdmDatabase.GetAllNonDailyIDs: TList<integer>;
var
  QuizIDs: TList<Integer>;
begin
  QuizIDs := TList<Integer>.Create;
  tblQuizzes.First;
  while not tblQuizzes.Eof do
  begin
    if tblQuizzes['QType'] <> 'Daily' then
    begin
      QuizIDs.Add(tblQuizzes['QuizID']);
    end;

    tblQuizzes.Next;
  end;
  Result := QuizIDs;
end;

function TdmDatabase.GetQuizDetails(QuizID: Integer): TList<string>;
{
Takes the quizID and returns the details of the quiz in a list of string with
like [Title, Description, Subject, DateCreated(as string), Source, QuizType]
}
const
  Fields: array[0..5] of string = ('Title', 'Description', 'Subject', 'DateCreated', 'Source', 'QType');
var
  Details: TList<string>;
  FieldName: string;
begin
  Details := TList<string>.Create;

  if tblQuizzes.Locate('QuizID', QuizID, []) then
  begin
    for FieldName in Fields do
      Details.Add(tblQuizzes.FieldByName(FieldName).AsString);
  end;

  Result := Details;
end;

function TdmDatabase.GetQuiz(QuizID: Integer): TList<TQuestion>;
var
  Q: TQuestion;
begin
  Result := TList<TQuestion>.Create;
  if tblQuizzes.Locate('QuizID', QuizID, []) then
  begin
    try
      tblQuestions.Filter := 'QuizID = ' + IntToStr(QuizID);
      tblQuestions.Filtered := True;

      tblQuestions.First;
      while not tblQuestions.Eof do
      begin
        with tblQuestions do
        begin
          Q := TQuestion.Create;
          Q.QuestionType := FieldByName('Type').AsString;
          Q.Difficulty := FieldByName('Difficulty').AsString;
          Q.Question := FieldByName('Question').AsString;
          Q.Answer := FieldByName('CorrectAnswer').AsString;
          Q.Options := DBListToStringList(FieldByName('PossibleAnswers').AsString);
          Result.Add(Q);
          Next;
        end;
      end;
    finally
      tblQuestions.Filtered := False;
    end;
  end;
end;

function TdmDatabase.DBListToStringList(DBList: string): TList<string>;
var
  ListAsString: string;
  Option: string;
begin
  Result := TList<string>.Create;

  ListAsString := DBList.Trim;
  ListAsString := ListAsString.Replace('|, |', '|');
  Delete(ListAsString, 1, 1); // remove first char
  Delete(ListAsString, ListAsString.Length, 1); // remove last char
  for Option in ListAsString.Split(['|']) do
  begin
    Result.Add(Option);
  end;
end;

function TdmDatabase.CompleteQuiz(QuizID: Integer; Score: Real; TimeTaken: TTime; Answers: TList<TAnswer>): Integer;
var
  Answer: TAnswer;
  CompletionID: Integer;
begin
  try
    CompletionID := AddQuizCompletion(QuizID, Score, TimeTaken);
    for Answer in Answers do
    begin
      AddAnswer(CompletionID, GetQuestionID(QuizID, Answer.Question), Answer.UserAnswer, 0, Answer.IsCorrect, Answer.ExpectedAnswer)
    end;
    Result := CompletionID;
  except
    ShowMessage('Error adding Quiz Completion.');
    Result := -1;
  end;
end;

function TdmDatabase.AddQuizCompletion(QuizID: Integer; Score: Real; TimeTaken: TTime): Integer;
begin
  tblQCS.Filtered := False;
  tblQCS.Insert;
  tblQCS['QuizID'] := QuizID;
  tblQCS['DateCompleted'] := Now;
  tblQCS['Score'] := Score;
  tblQCS['TimeTaken'] := TimeTaken;
  tblQCS.Post;
  tblQCS.Last;

  Result := tblQCS.FieldByName('CompletionID').AsInteger;
end;

function TdmDatabase.AddAnswer(QuizCompletionID: Integer; QuestionID: Integer; UserAnswer: string; TimeTaken: TTime; Correct: Boolean; ExpectedAns: string): Integer;
begin
  Result := -1;
  try
    tblAnswers.Filtered := False;
    tblAnswers.Insert;
    tblAnswers.FieldByName('QuizCompletionID').AsInteger := QuizCompletionID;
    tblAnswers.FieldByName('QuestionID').AsInteger := QuestionID;
    tblAnswers.FieldByName('UserAns').AsString := UserAnswer;
    tblAnswers.FieldByName('TimeTaken').AsDateTime := TimeTaken;
    tblAnswers.FieldByName('Correct').AsBoolean := Correct;
    tblAnswers.FieldByName('ExpectedAns').AsString := ExpectedAns;

    tblAnswers.Post;
    tblAnswers.Last;
    Result := tblAnswers.FieldByName('AnswerID').AsInteger;
  except
    ShowMessage('Error adding Answer.');
    Result := -1;
  end;
end;

function TdmDatabase.GetQuizAnswers(QuizCompletionID: Integer): TList<TAnswer>;
var
  Answer: TAnswer;
  QuestionID: Integer;
begin
  Result := TList<TAnswer>.Create;

  tblAnswers.Filter := 'QuizCompletionID = ' + IntToStr(QuizCompletionID);
  tblAnswers.Filtered := True;
  tblAnswers.First;

  while not tblAnswers.Eof do
  begin
    Answer := TAnswer.Create;
    Answer.UserAnswer := tblAnswers.FieldByName('UserAns').AsString;
    Answer.IsCorrect := tblAnswers.FieldByName('Correct').AsBoolean;
    Answer.ExpectedAnswer := tblAnswers.FieldByName('ExpectedAns').AsString;

    QuestionID := tblAnswers.FieldByName('QuestionID').AsInteger;

    if tblQuestions.Locate('QuestionID', QuestionID, []) then
    begin
      Answer.QuestionType := tblQuestions.FieldByName('Type').AsString;
      Answer.Difficulty := tblQuestions.FieldByName('Difficulty').AsString;
      Answer.Question := tblQuestions.FieldByName('Question').AsString;
    end;

    Result.Add(Answer);
    tblAnswers.Next;
  end;

  tblAnswers.Filtered := False;
end;

function TdmDatabase.GetQuestionID(QuizID: Integer; Question: string): Integer;
begin
  Result := -1;
  try
    tblQuestions.Filter := 'QuizID = ' + IntToStr(QuizID);
    tblQuestions.Filtered := True;
    if tblQuestions.IsEmpty then
    begin
      ShowMessage('Filtering Error when getting question ID.');
    end
    else
    begin
      tblQuestions.First;
      while not tblQuestions.EOF do
      begin
        if tblQuestions.FieldByName('Question').AsString = Question then
        begin
          Result := tblQuestions.FieldByName('QuestionID').AsInteger;
        end;
        tblQuestions.Next;
      end;
      if Result = -1 then
      begin
        ShowMessage('Couldn''t get ID for question: ' + Question)
      end;
    end;
  except
    ShowMessage('Error filtering the quiz when getting quizID.');
    Result := -1;
  end;

  tblQuestions.Filtered := False;
end;

function TdmDatabase.UpdateDetails(QuizID: Integer; QuizTitle: string; QuizCategory: string; QuizDescription: string): Integer;
begin
  Result := 1;

  try
    tblQuizzes.Filter := 'QuizID = ' + IntToStr(QuizID);
    tblQuizzes.Filtered := True;
    tblQuizzes.Edit;
    tblQuizzes['Title'] := QuizTitle;
    tblQuizzes['Subject'] := QuizCategory;
    tblQuizzes['Description'] := QuizDescription;
    tblQuizzes.Post;
  except
    Result := -1;
  end;

  tblQuizzes.Filtered := False;
end;

function TdmDatabase.DeleteQuiz(QuizID: Integer): Integer;
begin
  Result := 1;
  try
    tblQuestions.Filter := 'QuizID=' + IntToStr(QuizID);
    tblQuestions.Filtered := True;
    tblQuestions.First;
    while not tblQuestions.Eof do
    begin
      tblQuestions.Delete;
    end;
    tblQuestions.Filtered := False;

    // Finally delete the quiz
    if tblQuizzes.Locate('QuizID', QuizID, []) then
      tblQuizzes.Delete;

  except
    on E: Exception do
    begin
      ShowMessage('Error deleting quiz: ' + E.Message);
      Result := -1; // Failure
    end;
  end;
end;

function TdmDatabase.GetLatestDailyQuizID: Integer;
begin
  try
    tblDailyQuizzes.Filtered := False;
    tblDailyQuizzes.Last;
    Result := tblDailyQuizzes.FieldByName('QuizID').AsInteger;
  except
    Result := -1;
  end;
end;

function TdmDatabase.CountSavedQuizzes: Integer;
begin
  Result := GetAllNonDailyIDs.Count;
end;

function TdmDatabase.CountCompletedQuizzes: Integer;
begin
  tblQCS.Filtered := False;
  Result := tblQCS.RecordCount;
end;

function TdmDatabase.GetAvScore: Real;
var
  Sum: Real;
begin
  Sum := 0;
  tblQCS.Filtered := False;
  tblQCS.First;

  while not tblQCS.Eof do
  begin
    Sum := Sum + tblQCS.FieldByName('Score').AsFloat;
    tblQCS.Next;
  end;

  Result := Sum/tblQCS.RecordCount;
end;

function TdmDatabase.DailyQuizCompleted: Boolean;
begin
  tblDailyQuizzes.Filtered := False;
  tblDailyQuizzes.Last;

  Result := tblDailyQuizzes.FieldByName('Completed').AsBoolean;
end;

function TdmDatabase.GetDailyQuizQuizID: Integer;
begin
  tblDailyQuizzes.Filtered := False;
  tblDailyQuizzes.Last;

  Result := tblDailyQuizzes.FieldByName('QuizID').AsInteger;
end;

function TdmDatabase.GetAnswerCount: Integer;
begin
  tblAnswers.Filtered := False;
  Result := tblAnswers.RecordCount;
end;

function TdmDatabase.GetStreak: Integer;
begin
  Result := tblStreak.FieldByName('Count').AsInteger;
end;

function TdmDatabase.UpdateStreak: Integer;
var
  PrevComplete: Boolean;
  PrevID: Integer;
  NewStreak: Integer;
begin
  PrevComplete := False;
  tblDailyQuizzes.Filtered := False;
  tblDailyQuizzes.Last;
  PrevID := tblDailyQuizzes.FieldByName('ChallengeID').AsInteger - 1;
  if PrevID = 0 then
  begin
    tblStreak.First;
    tblStreak.Edit;
    tblStreak['Count'] := 0;
    tblStreak.Post;
    Result := 0;
  end
  else
  begin
    tblDailyQuizzes.Filter := 'ChallengeID = ' + IntToStr(PrevID);
    tblDailyQuizzes.Filtered := True;
    if tblDailyQuizzes.IsEmpty then
    begin
      ShowMessage('No challenge with ID ' + IntToStr(PrevID));
    end
    else
    begin
      PrevComplete := tblDailyQuizzes.FieldByName('Completed').AsBoolean;
      if PrevComplete then
      begin
        tblStreak.First;
        Result := tblStreak.FieldByName('Count').AsInteger;
      end;
    end;
    tblDailyQuizzes.Filtered := False;
  end;
end;

function TdmDatabase.GetQuizID(QuizCompletionID: Integer): Integer;
begin
  tblQCS.Filter := 'CompletionID = ' + IntToStr(QuizCompletionID);
  tblQCS.Filtered := True;
  Result := tblQCS.FieldByName('QuizID').AsInteger;
  tblQCS.Filtered := False;
end;

function TdmDatabase.IncStreak: Integer;
begin
  tblStreak.Edit;
  tblStreak['Count'] := tblStreak.FieldByName('Count').AsInteger + 1;
  tblStreak.Post;
  Result := tblStreak.FieldByName('Count').AsInteger;

  tblDailyQuizzes.Filtered := False;
  tblDailyQuizzes.Last;
  tblDailyQuizzes.Edit;
  tblDailyQuizzes['Completed'] := True;
  tblDailyQuizzes.Post;
end;
end.
