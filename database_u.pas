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
  private
    { Private declarations }
  public
    { Public declarations }
    function AddQuiz(Title, Description, Subject, Source: string; Questions: TList<TQuestion>): integer;
    function AddQuestion(QuizID: integer; Question, Difficulty, CorrectAnswer, QuestionType: string; PossibleAnswers: TList<string>): integer;
  end;

var
  dmDatabase: TdmDatabase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmDatabase.AddQuiz(Title: string; Description: string; Subject: string; Source: string; Questions: TList<TQuestion>): Integer;
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
    dmDatabase.tblQuizzes.Post;
    dmDatabase.tblQuizzes.Last;

    quizID := dmDatabase.tblQuizzes['QuizID'];

    for q in Questions do
      begin
        AddQuestion(quizID, q.Question, q.Difficulty, q.Answer, q.QuestionType, q.Options);
      end;


    Result := quizID;
  end;

function TdmDatabase.AddQuestion(QuizID: Integer; Question: string; Difficulty: string; CorrectAnswer: string; QuestionType: string; PossibleAnswers: TList<string>): integer;
  var
    possibleAns: string;
    s: string;
  begin
  // List to CSV string:
    possibleAns := '';
    Randomize;
    PossibleAnswers.Insert(Random(PossibleAnswers.Count), CorrectAnswer);

    for s in PossibleAnswers do
      begin
        if possibleAns = '' then
          begin
            possibleAns := s;
          end
        else
          begin
            possibleAns := possibleAns + ', ' + s;
          end;
      end;

  // Add to db:
    dmDatabase.tblQuestions.Insert;
    dmDatabase.tblQuestions['QuizID'] := QuizID;
    dmDatabase.tblQuestions['Question'] := Question;
    dmDatabase.tblQuestions['Difficulty'] := Difficulty;
    dmDatabase.tblQuestions['CorrectAnswer'] := CorrectAnswer;
    dmDatabase.tblQuestions['PossibleAnswers'] := possibleAns;
    dmDatabase.tblQuestions['Type'] := QuestionType;
    dmDatabase.tblQuestions.Post;

  end;




end.
