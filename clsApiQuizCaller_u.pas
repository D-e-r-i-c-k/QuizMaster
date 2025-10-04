unit clsApiQuizCaller_u;

interface

uses
  IdHTTP, IdSSLOpenSSL, System.SysUtils, System.JSON, System.Generics.Collections,
  System.NetEncoding, Vcl.Dialogs,

  clsQuestion_u, dbMain_u;

type
  TApiQuizCaller = class
    private
    {Private Variables}
      HTTP: TIdHTTP;
      SSL: TIdSSLIOHandlerSocketOpenSSL;
      DB: TdmDatabase;
      function DecodeHTML(Str: string): string;
    public
    {Constructor, Procedures, and Properties}
      constructor Create;
      function Call(URL: string): TJSONObject;
      function JSONToQuiz(JSON: TJSONObject): TList<TQuestion>;
      function GetCategory(CatID: integer): string;
      function GetRandomCategory: integer;
      function GetQuiz(Category, AmmountOfQuestions: integer): TList<TQuestion>;
      function GetAndAddDailyQuiz: integer;
      function GetAllCategoriesNames: TList<string>;
      function GetAllCategoriesIDs: TList<integer>;
  end;

implementation

constructor TApiQuizCaller.Create;
  begin
  end;

function TApiQuizCaller.Call(URL: string): TJSONObject;
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

function TApiQuizCaller.JSONToQuiz(JSON: TJSONObject): TList<TQuestion>;
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

function TApiQuizCaller.DecodeHTML(Str: string): string;
  begin
    Result := TNetEncoding.HTML.Decode(Str)
  end;

function TApiQuizCaller.GetCategory(CatID: Integer): string;
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

function TApiQuizCaller.GetRandomCategory: Integer;
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

function TApiQuizCaller.GetQuiz(Category: integer; AmmountOfQuestions: integer): TList<TQuestion>;
  var
    URL: string;
    QuizCategory, QuizLen: integer;
  begin
    QuizCategory := Category;
    QuizLen := AmmountOfQuestions;
    URL := 'https://opentdb.com/api.php?amount=' + IntToStr(QuizLen) + '&category=' + IntToStr(QuizCategory);

    Result := JSONToQuiz(Call(URL));
  end;

function TApiQuizCaller.GetAndAddDailyQuiz: Integer;
  const
    Len = 10;
  var
    Title, Description: string;
    Questions: TList<TQuestion>;
    Category: integer;
    ChallengeID: integer;
  begin
    Questions := TList<TQuestion>.Create;
    Category := GetRandomCategory;

    Questions := GetQuiz(Category, Len);
    Title := 'Daily Quiz: ' + FormatDateTime('yyyy-mm-dd', Date());
    Description := 'Topic: ' + GetCategory(Category);

    ChallengeID := DB.AddDailyQuiz(Title, Description, Questions);

    Result := ChallengeID;
  end;

function TApiQuizCaller.GetAllCategoriesNames: TList<string>;
  var
    CategoryList: TList<string>;
    Categories: TJSONArray;
    n: integer;
    Category: TJSONObject;
  begin
    CategoryList := TList<string>.Create;
    Categories := Call('https://opentdb.com/api_category.php').GetValue<TJSONArray>('trivia_categories');
    for n := 0 to Categories.Count - 1 do
      begin
        Category := Categories.Items[n] as TJSONObject;
        CategoryList.Add(Category.GetValue<string>('name'))
      end;
    Result := CategoryList;
  end;

function TApiQuizCaller.GetAllCategoriesIDs: TList<integer>;
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
    Result := CatIDList;
  end;
end.
