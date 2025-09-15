unit database_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, System.Generics.Collections,

  question_u;

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
  public
    { Public declarations }
    function AddQuiz(Title, Description, Subject, Source, QType: string; Questions: TList<TQuestion>): integer;
    function AddQuestion(QuizID: integer; Question: TQuestion): integer;
    function AddDailyQuiz(Title, Description: string; Questions: TList<TQuestion>): integer;
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
end.
