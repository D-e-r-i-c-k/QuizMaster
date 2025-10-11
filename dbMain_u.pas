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
  CompletionID := AddQuizCompletion(QuizID, Score, TimeTaken);
  for Answer in Answers do
  begin
    AddAnswer(CompletionID, GetQuestionID(QuizID, Answer.Question), Answer.UserAnswer, 0, Answer.IsCorrect, Answer.ExpectedAnswer)
  end;
  Result := CompletionID;
end;

function TdmDatabase.AddQuizCompletion(QuizID: Integer; Score: Real; TimeTaken: TTime): Integer;
begin
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
  tblAnswers.Insert;
  tblAnswers['QuizCompletionID'] := QuizCompletionID;
  tblAnswers['QuestionID'] := QuestionID;
  tblAnswers['UserAns'] := UserAnswer;
  tblAnswers['TimeTaken'] := TimeTaken;
  tblAnswers['Correct'] := Correct;
  tblAnswers['ExpectedAns'] := ExpectedAns;
  tblAnswers.Post;
  tblAnswers.Last;

  Result := tblAnswers.FieldByName('AnswerID').AsInteger;
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
  Result := -1; // default if not found
  tblQuestions.Filter := Format('QuizID=%d AND Question=''%s''', [QuizID, Question]);
  tblQuestions.Filtered := True;

  try
    if not tblQuestions.IsEmpty then
      Result := tblQuestions.FieldByName('QuestionID').AsInteger;
  finally
    tblQuestions.Filtered := False;
  end;
end;
end.

