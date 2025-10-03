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
      function JSONToQuiz(JSON: TJSONObject): TList<TQuestion>;
      function Call(UserPrompt: string; Model: string): TJSONObject;
    public
    {Constructor, Procedures, and Properties}
      constructor Create;
      function GetQuiz(UserPrompt: string): TList<TQuestion>;
  end;

implementation

constructor TAIQuiz.Create;
  begin
  end;

function TAIQuiz.Call(UserPrompt: string; Model: string): TJSONObject;
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
  Root, Msg, MsgObj, RawJSON: TJSONObject;
  MsgArray, Choices: TJSONArray;
  PostData: TStringStream;
  Response, ContentStr: string;
  HTTPEx: Exception;
  APIKey: string;
begin
  Result := nil;
  APIKey := GetEnvironmentVariable('OPEN_ROUTER_KEY');

  if APIKey = '' then
    begin
      raise Exception.Create('OPEN_ROUTER_KEY environment variable is not set.');
    end;

  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Root := nil;
  MsgArray := nil;
  PostData := nil;
  RawJSON := nil;

  try
    // Configure HTTP/SSL
    SSL.SSLOptions.Method := sslvTLSv1_2;
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.CustomHeaders.Clear;
    HTTP.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + APIKey);

    // Build request body
    Root := TJSONObject.Create;
    MsgArray := TJSONArray.Create;
    try
      Root.AddPair('model', Model);

      Msg := TJSONObject.Create;
      Msg.AddPair('role', 'system');
      Msg.AddPair('content', SystemPrompt);
      MsgArray.Add(Msg);

      Msg := TJSONObject.Create;
      Msg.AddPair('role', 'user');
      Msg.AddPair('content', UserPrompt);
      MsgArray.Add(Msg);

      Root.AddPair('messages', MsgArray);
      Root.AddPair('temperature', TJSONNumber.Create(0.7));

      PostData := TStringStream.Create(Root.ToJSON, TEncoding.UTF8);

      // Post and parse wrapper response
      try
        Response := HTTP.Post('https://openrouter.ai/api/v1/chat/completions', PostData).Trim;
      except
        on E: Exception do
          begin
            HTTPEx := E; // capture to raise later after cleaning up
            raise;
          end;
      end;

      RawJSON := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      if Assigned(RawJSON) then
        begin
          Choices := RawJSON.GetValue<TJSONArray>('choices');
          if Assigned(Choices) and (Choices.Count > 0) then
            begin
              // message object may be nested under 'message'
              MsgObj := nil;
              try
                MsgObj := Choices.Items[0].GetValue<TJSONObject>('message');
              except
                MsgObj := nil;
              end;

              if Assigned(MsgObj) then
                begin
                  // content may include surrounding text or fenced code - extract JSON body
                  ContentStr := MsgObj.GetValue<string>('content').Trim;

                  // If assistant wrapped JSON in ``` ... ``` or extra text, try to extract the {...} substring
                  if (ContentStr.StartsWith('```')) then
                    begin
                      // remove leading/trailing code fence if present
                      ContentStr := ContentStr.Replace('```', '').Trim;
                    end;

                  // If Parse fails, try to extract first {...} block
                  Result := TJSONObject.ParseJSONValue(ContentStr) as TJSONObject;
                    if not Assigned(Result) then
                    begin
                      var StartIdx := Pos('{', ContentStr);
                      var EndIdx := LastDelimiter('}', ContentStr);
                      if (StartIdx > 0) and (EndIdx >= StartIdx) then
                        begin
                          ContentStr := Copy(ContentStr, StartIdx, EndIdx - StartIdx + 1);
                          Result := TJSONObject.ParseJSONValue(ContentStr) as TJSONObject;
                        end;
                    end;
                  // If still nil, Result remains nil and caller should handle it
                end;
            end;
        end;
    finally
      PostData.Free;
      Root.Free;
      MsgArray := nil;
    end;
  finally
    RawJSON.Free;
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

function TAIQuiz.GetQuiz(UserPrompt: string): TList<TQuestion>;
  var
    QuizJSON: TJSONObject;
    Quiz: TList<TQuestion>;
  begin
    try
      ShowMessage('Trying to get quiz with Grok 4 fast...');
      QuizJSON := Call(UserPrompt, 'x-ai/grok-4-fast:free');
      ShowMessage(QuizJSON.ToString);
    except
      try
        ShowMessage('Grok failed, trying Deepseek...');
        QuizJSON := Call(UserPrompt, 'deepseek/deepseek-chat-v3.1:free');
        ShowMessage(QuizJSON.ToString);
      except
        ShowMessage('AI generation failed, please try again later.');
        ShowMessage(QuizJSON.ToString);
        exit;
      end;
    end;

    try
      ShowMessage('Quiz Created... Parsing Quiz...');
      ShowMessage(QuizJSON.ToString);
      Quiz := JSONToQuiz(QuizJSON);
      Result := Quiz;
    except
      ShowMessage('Error Parsing Quiz');
      Result := nil;
    end;
  end;
end.
