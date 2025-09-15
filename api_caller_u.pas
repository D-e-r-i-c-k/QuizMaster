unit api_caller_u;

interface

uses
  IdHTTP, IdSSLOpenSSL, System.SysUtils, System.JSON, System.Generics.Collections,
  System.NetEncoding, Vcl.Dialogs,

  question_u;

type
  TAPI_Caller = class
    private
    {Private Variables}
      HTTP: TIdHTTP;
      SSL: TIdSSLIOHandlerSocketOpenSSL;
      function DecodeHTML(Str: string): string;
    public
    {Constructor, Procedures, and Properties}
      constructor Create;
      function Call(URL: string): TJSONObject;
      function QuizToJSON(JSONstring: string): TList<TQuestion>;
      function GetCategory(CatID: integer): string;
      function GetRandomCategory: integer;
  end;

implementation

constructor TAPI_Caller.Create;
  begin
  end;

function TAPI_Caller.Call(URL: string): TJSONObject;
  var
    JSONstring: string;
  begin
    JSONstring := '';
    HTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      HTTP.IOHandler := SSL;
      HTTP.HandleRedirects := True;

      JSONstring := HTTP.Get(URL);
    finally
      HTTP.Destroy;
      SSL.Destroy;

      Result := TJSONObject.ParseJSONValue(JSONstring) as TJSONObject
    end;
  end;

function TAPI_Caller.QuizToJSON(JSONstring: string): TList<TQuestion>;
  var
    JSONObject, QuestionObj: TJSONObject;
    ResultsArray, Incorrect_Answers: TJSONArray;
    Options: TList<string>;
    Option: TJSONString;
    i, n: Integer;
    Questions: TList<TQuestion>;
    Q: TQuestion;
  begin
    JSONObject := TJSONObject.ParseJSONValue(JSONstring) as TJSONObject;
    try
      if Assigned(JSONObject) then
        begin
          ResultsArray := JSONObject.GetValue<TJSONArray>('results');
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
      JSONObject.Free;
    end;
  end;

function TAPI_Caller.DecodeHTML(Str: string): string;
  begin
    Result := TNetEncoding.HTML.Decode(Str)
  end;

function TAPI_Caller.GetCategory(CatID: Integer): string;
  var
    Categories: TJSONArray;
    n: integer;
    Category: TJSONObject;
  begin
    Categories := Call('https://opentdb.com/api_category.php').GetValue<TJSONArray>('trivia_categories');
    for n := 0 to Categories.Count - 1 do
      begin
        Category := Categories.Items[n] as TJSONObject;
        if Category.GetValue<integer>('id') = CatID then
          begin
            Result := Category.GetValue<string>('name')
          end;
      end;
  end;

function TAPI_Caller.GetRandomCategory: Integer;
  var
    Categories: TJSONArray;
    n: integer;
    Category: TJSONObject;
    CatIDList: TList<integer>;
  begin
    CatIDList := TList<integer>.Create;
    Categories := Call('https://opentdb.com/api_category.php').GetValue<TJSONArray>('trivia_categories');
    for n := 0 to Categories.Count - 1 do
      begin
        Category := Categories.Items[n] as TJSONObject;
        CatIDList.Add(Category.GetValue<integer>('id'))
      end;
    Randomize;
    Result := CatIDList.Items[Random(CatIDList.Count)];
  end;

end.
