unit dbMain_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Vcl.Dialogs,
  System.Generics.Collections, clsQuestion_u;

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

end.

