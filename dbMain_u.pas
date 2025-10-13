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
    function UpdateDetails(QuizID: Integer; QuizTitle: string; QuizCategory: string; QuizDescription: string): integer;
    function DeleteQuiz(QuizID: Integer): Integer;
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
  // Use the options provided by the Question. If nil use an empty list.
  PossibleAnswerList := Question.Options;
  if Assigned(PossibleAnswerList) = False then
    PossibleAnswerList := TList<string>.Create;

  // List to CSV string:
  possibleAns := '';
  Randomize;
  // If options list is empty (eg. user-answer type) just add the correct answer
  if PossibleAnswerList.Count = 0 then
    PossibleAnswerList.Add('"' + Question.Answer + '"')
  else
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
  ListAsString := Trim(DBList);

  // Empty input -> return empty list
  if ListAsString = '' then
    Exit;

  // Normalize common encoding produced elsewhere: |opt1|opt2|
  ListAsString := ListAsString.Replace('|, |', '|');
  if (ListAsString.StartsWith('|')) and (ListAsString.EndsWith('|')) and (ListAsString.Length >= 2) then
  begin
    // remove surrounding pipes
    Delete(ListAsString, 1, 1);
    Delete(ListAsString, ListAsString.Length, 1);
    for Option in ListAsString.Split(['|']) do
      if Trim(Option) <> '' then
        Result.Add(Trim(Option));
    Exit;
  end;

  // Fallback: support comma-separated lists (opt1, opt2)
  for Option in ListAsString.Split([',']) do
    if Trim(Option) <> '' then
      Result.Add(Trim(Option));
end;

function TdmDatabase.CompleteQuiz(QuizID: Integer; Score: Real; TimeTaken: TTime; Answers: TList<TAnswer>): Integer;
var
  Answer: TAnswer;
  CompletionID: Integer;
begin
  CompletionID := AddQuizCompletion(QuizID, Score, TimeTaken);
  for Answer in Answers do
  begin
    var QID := GetQuestionID(QuizID, Answer.Question);
    // If we didn't find a matching question, store 0 for QuestionID to avoid invalid range errors
    if QID < 0 then
      QID := 0;
    AddAnswer(CompletionID, QID, Answer.UserAnswer, 0, Answer.IsCorrect, Answer.ExpectedAnswer);
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
  Result := -1;
  try
    tblAnswers.Insert;
    // Defensive assignments: only set fields when available and types are reasonable
    try
      tblAnswers.FieldByName('QuizCompletionID').AsInteger := QuizCompletionID;
    except end;
    try
      tblAnswers.FieldByName('QuestionID').AsInteger := QuestionID;
    except end;
    try
      tblAnswers.FieldByName('UserAns').AsString := UserAnswer;
    except end;
    try
      tblAnswers.FieldByName('TimeTaken').AsDateTime := TimeTaken;
    except end;
    try
      tblAnswers.FieldByName('Correct').AsBoolean := Correct;
    except end;
    try
      tblAnswers.FieldByName('ExpectedAns').AsString := ExpectedAns;
    except end;

    try
      tblAnswers.Post;
      tblAnswers.Last;
      Result := tblAnswers.FieldByName('AnswerID').AsInteger;
    except
      on E: Exception do
      begin
        // Show detailed info but do not re-raise to avoid crashing UI flow
        try
          ShowMessage('AddAnswer.Post failed: ' + E.Message + sLineBreak +
            Format('QuizCompletionID=%d, QuestionID=%d, UserAns=%s, ExpectedAns=%s', [QuizCompletionID, QuestionID, UserAnswer, ExpectedAns]));
        except end;
        try
          tblAnswers.Cancel;
        except end;
        Result := -1;
      end;
    end;
  except
    raise;
  end;
end;

function TdmDatabase.GetQuizAnswers(QuizCompletionID: Integer): TList<TAnswer>;
var
  Answer: TAnswer;
  QuestionID: Integer;
  quizID: Integer;
  esc: string;
  foundQuestion: Boolean;
begin
  Result := TList<TAnswer>.Create;

  tblAnswers.Filter := 'QuizCompletionID = ' + IntToStr(QuizCompletionID);
  tblAnswers.Filtered := True;
  if tblAnswers.IsEmpty then
  begin
    tblAnswers.Filtered := False;
    Exit;
  end;

  tblAnswers.First;

  while not tblAnswers.Eof do
  begin
    Answer := TAnswer.Create;
    Answer.UserAnswer := tblAnswers.FieldByName('UserAns').AsString;
    Answer.IsCorrect := tblAnswers.FieldByName('Correct').AsBoolean;
    Answer.ExpectedAnswer := tblAnswers.FieldByName('ExpectedAns').AsString;

    QuestionID := tblAnswers.FieldByName('QuestionID').AsInteger;

    foundQuestion := False;

    // Try direct lookup when QuestionID present
    if (QuestionID > 0) and tblQuestions.Locate('QuestionID', QuestionID, []) then
    begin
      Answer.QuestionType := tblQuestions.FieldByName('Type').AsString;
      Answer.Difficulty := tblQuestions.FieldByName('Difficulty').AsString;
      Answer.Question := tblQuestions.FieldByName('Question').AsString;
      foundQuestion := True;
    end
    else
    begin
      // Attempt to resolve missing questions by using the completion -> quiz link
      try
        if tblQCS.Locate('CompletionID', QuizCompletionID, []) then
        begin
          quizID := tblQCS.FieldByName('QuizID').AsInteger;
          // First try exact match on CorrectAnswer (guarded)
          try
            if (Trim(Answer.ExpectedAnswer) <> '') and tblQuestions.Locate('QuizID;CorrectAnswer', VarArrayOf([quizID, Answer.ExpectedAnswer]), []) then
            begin
              Answer.QuestionType := tblQuestions.FieldByName('Type').AsString;
              Answer.Difficulty := tblQuestions.FieldByName('Difficulty').AsString;
              Answer.Question := tblQuestions.FieldByName('Question').AsString;
              foundQuestion := True;
            end;
          except
            on E: Exception do
              ShowMessage('GetQuizAnswers locate by CorrectAnswer failed: ' + E.Message);
          end;

          // Fallback: search for expected answer inside Question or PossibleAnswers using LIKE
          if not foundQuestion then
          begin
              try
                // Manual scan to avoid ADO Filter/LIKE type errors
                var search := Trim(Answer.ExpectedAnswer);
                if search <> '' then
                begin
                  // iterate through questions for the same quiz
                  tblQuestions.First;
                  while not tblQuestions.Eof do
                  begin
                    if tblQuestions.FieldByName('QuizID').AsInteger = quizID then
                    begin
                      var qtext := tblQuestions.FieldByName('Question').AsString;
                      var possible := tblQuestions.FieldByName('PossibleAnswers').AsString;
                      var correct := tblQuestions.FieldByName('CorrectAnswer').AsString;
                      if (Pos(LowerCase(search), LowerCase(qtext)) > 0) or
                         (Pos(LowerCase(search), LowerCase(possible)) > 0) or
                         (Pos(LowerCase(search), LowerCase(correct)) > 0) then
                      begin
                        Answer.QuestionType := tblQuestions.FieldByName('Type').AsString;
                        Answer.Difficulty := tblQuestions.FieldByName('Difficulty').AsString;
                        Answer.Question := qtext;
                        foundQuestion := True;
                        Break;
                      end;
                    end;
                    tblQuestions.Next;
                  end;
                end;
              except
                on E: Exception do
                  ShowMessage('GetQuizAnswers manual scan failed: ' + E.Message);
              end;
          end;
        end;
      except
        on E: Exception do
          ShowMessage('GetQuizAnswers completion lookup failed: ' + E.Message);
      end;
    end;

    if not foundQuestion then
    begin
      // Missing question record; provide placeholder so UI can still show answer
      Answer.QuestionType := '';
      Answer.Difficulty := '';
      Answer.Question := '(Original question unavailable)';
    end;

    Result.Add(Answer);
    tblAnswers.Next;
  end;

  tblAnswers.Filtered := False;
end;

function TdmDatabase.GetQuestionID(QuizID: Integer; Question: string): Integer;
begin
  Result := -1; // default if not found

  // Use Locate to avoid formatting/quoting issues with the filter string
  if tblQuestions.Locate('QuizID;Question', VarArrayOf([QuizID, Question]), []) then
  begin
    Result := tblQuestions.FieldByName('QuestionID').AsInteger;
  end
  else
  begin
    // Debug: optionally show missing question to help identify formatting differences
    // Comment this out in production if too noisy
    // ShowMessage('GetQuestionID: failed to locate question for QuizID=' + IntToStr(QuizID) + sLineBreak + 'Question: ' + Question);
    Result := -1;
  end;
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
  Result := 1; // Success by default
  try
//    // Delete related answers first
//    tblAnswers.Filter := 'QuestionID IN (SELECT QuestionID FROM tblQuestions WHERE QuizID=' + IntToStr(QuizID) + ')';
//    tblAnswers.Filtered := True;
//    tblAnswers.First;
//    while not tblAnswers.Eof do
//    begin
//      tblAnswers.Delete;
//    end;
//    tblAnswers.Filtered := False;

    // Delete related questions
    tblQuestions.Filter := 'QuizID=' + IntToStr(QuizID);
    tblQuestions.Filtered := True;
    tblQuestions.First;
    while not tblQuestions.Eof do
    begin
      tblQuestions.Delete;
    end;
    tblQuestions.Filtered := False;

    // Delete from daily quizzes if exists
    tblDailyQuizzes.Filter := 'QuizID=' + IntToStr(QuizID);
    tblDailyQuizzes.Filtered := True;
    if not tblDailyQuizzes.IsEmpty then
    begin
      tblDailyQuizzes.First;
      while not tblDailyQuizzes.Eof do
        tblDailyQuizzes.Delete;
    end;
    tblDailyQuizzes.Filtered := False;

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

end.
