unit aiCaller_u;

interface

uses
  IdHTTP, IdSSLOpenSSL, System.SysUtils, System.JSON, System.Generics.Collections,
  System.NetEncoding, Vcl.Dialogs, System.Classes,

  question_u, database_u;

type
  TAIQuiz = class
    private
    {Private Variables}
      HTTP: TIdHTTP;
      SSL: TIdSSLIOHandlerSocketOpenSSL;
      DB: TdmDatabase;
      function DecodeHTML(Str: string): string;
    public
    {Constructor, Procedures, and Properties}
      constructor Create;
      function Call(UserPrompt: string): TJSONObject;
      function JSONToQuiz(JSON: TJSONObject): TList<TQuestion>;
  end;

implementation

constructor TAIQuiz.Create;
  begin
  end;

function TAIQuiz.Call(UserPrompt: string): TJSONObject;
  const
    SystemPrompt = 'You are an academic quiz generator. Your task is to create a formal, professional test in JSON format. '
  + 'The JSON should follow the general schema of the examples given below, but with a more in-depth, formal and academic style. '
  + 'Output only valid JSON. '
  + 'Each question must have the following structure: '
  + '{ '
  + '"category": "Subject Area", '
  + '"type": "multiple" | "boolean" | "userans", '
  + '"difficulty": "easy" | "medium" | "hard", '
  + '"question": "The full question text, written in a formal academic style.", '
  + '"correct_answer": "The correct answer", '
  + '"incorrect_answers": ["Wrong answer 1", "Wrong answer 2", "Wrong answer 3"] '
  + '} '
  + 'Rules for question types: '
  + '"multiple" = multiple choice. '
  + '"boolean" = True/False. '
  + '"userans" = open-ended written response. For these, "incorrect_answers" must be an empty list. '
  + 'All questions must read like real academic test questions. '
  + 'Distractors must be plausible but clearly wrong. '
  + 'Difficulty must reflect real exam standards. '
  + 'The quiz must mix multiple, boolean, and userans types. '
  + 'If long answers are expected, make the correct answer field "up for AI to mark". '
  + 'Make the test of the formal exam standard. '
  + 'Here is an example structure: '
  + '{ '
  + '"response_code": 0, '
  + '"results": [ '
  + '{ '
  + '"category": "Physics", '
  + '"type": "multiple", '
  + '"difficulty": "medium", '
  + '"question": "Which of the following best describes Newton’s Second Law of Motion?", '
  + '"correct_answer": "The acceleration of an object is directly proportional to the net force acting upon it and inversely proportional to its mass.", '
  + '"incorrect_answers": [ '
  + '"Every action has an equal and opposite reaction.", '
  + '"An object in motion will remain in motion unless acted upon by an external force.", '
  + '"Energy can neither be created nor destroyed, only transformed." '
  + '] '
  + '}, '
  + '{ '
  + '"category": "History", '
  + '"type": "boolean", '
  + '"difficulty": "easy", '
  + '"question": "The Treaty of Versailles officially ended World War I.", '
  + '"correct_answer": "True", '
  + '"incorrect_answers": ["False"] '
  + '}, '
  + '{ '
  + '"category": "Mathematics", '
  + '"type": "userans", '
  + '"difficulty": "hard", '
  + '"question": "Differentiate the function f(x) = 3x^3 - 5x^2 + 2x - 7.", '
  + '"correct_answer": "f''(x) = 9x^2 - 10x + 2", '
  + '"incorrect_answers": [] '
  + '} '
  + '] '
  + '}';
  var
    JSONstring: string;
    Response: string;
    HTTP: TIdHTTP;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    PostData: TStringStream;
  begin
    Result := nil;
    HTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      HTTP.IOHandler := SSL;
      HTTP.HandleRedirects := True;
      HTTP.Request.ContentType := 'application/json';
      HTTP.Request.CustomHeaders.Clear;
      HTTP.Request.CustomHeaders.AddValue('Authorization',
        'Bearer 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');

      JSONstring :=
        '{'
        + '  "model": "x-ai/grok-4-fast:free",'
        + '  "messages": ['
        + '  {'
        + '    "role": "system",'
        + '    "content": "' + SystemPrompt + '"'
        + '  {'
        + '    "role": "user",'
        + '    "content": "' + UserPrompt + '"'
        + '  }],'
        + '  "temperature": 0.7'
        + '}';

      PostData := TStringStream.Create(JSONstring, TEncoding.UTF8);

      try
        Response := HTTP.Post('https://openrouter.ai/api/v1/chat/completions', PostData).Trim;
        ShowMessage(Response);
        Writeln(Response);
        Result := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      finally
        PostData.Free;
      end;

    finally
      HTTP.Free;
      SSL.Free;
    end;
  end;

function TAIQuiz.JSONToQuiz(JSON: TJSONObject): TList<TQuestion>;
  var
    QuestionObj: TJSONObject;
    ResultsArray, Incorrect_Answers: TJSONArray;
    Options: TList<string>;
    Option: TJSONString;
    i, n: Integer;
    Questions: TList<TQuestion>;
    Q: TQuestion;
  begin
    try
      if Assigned(JSON) then
        begin
          ResultsArray := JSON.GetValue<TJSONArray>('results');
          if Assigned(ResultsArray) then
            begin
              Questions := TList<TQuestion>.Create;
              for i := 0 to ResultsArray.Count - 1 do
                begin
                  QuestionObj := ResultsArray.Items[i] as TJSONObject;
                  Options := TList<string>.Create;
                  Q := TQuestion.Create(QuestionObj);

                  Q.QuestionType := DecodeHTML(QuestionObj.GetValue<string>('type'));
                  Q.Difficulty := DecodeHTML(QuestionObj.GetValue<string>('difficulty'));
                  Q.Category := DecodeHTML(QuestionObj.GetValue<string>('category'));
                  Q.Question := DecodeHTML(QuestionObj.GetValue<string>('question'));
                  Q.Answer := DecodeHTML(QuestionObj.GetValue<string>('correct_answer'));
                  Incorrect_Answers := QuestionObj.GetValue<TJSONArray>('incorrect_answers');
                  for n := 0 to Incorrect_Answers.Count - 1 do
                    begin
                      Option := Incorrect_Answers[n] as TJSONString;
                      Options.Add(DecodeHTML(Option.ToString));
                    end;
                  Q.Options := Options;

                  Questions.Add(Q);
                end;
                Result := Questions;
            end;
        end;
    finally
      JSON.Free;
    end;
  end;

function TAIQuiz.DecodeHTML(Str: string): string;
  begin
    Result := TNetEncoding.HTML.Decode(Str)
  end;
end.
