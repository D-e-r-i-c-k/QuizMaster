unit question_u;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections, System.NetEncoding;

type
  TQuestion = class
    private
    {Private Variables}
      FQuizType: string;
      FDifficulty: string;
      FCategory: string;
      FQuestion: string;
      FAnswer: string;
      FOptions: TList<string>;
//      function JSONToQuiz(QuizJSON: TJSONObject): string;
    public
    {Constructor, Procedures, Properties}
      constructor Create(QuizJSON: TJSONObject);
      property QuizType: string read FQuizType write FQuizType;
      property Difficulty: string read FDifficulty write FDifficulty;
      property Question: string read FQuestion write FQuestion;
      property Category: string read FCategory write FCategory;
      property Answer: string read FAnswer write FAnswer;
      property Options: TList<string> read FOptions write FOptions;
      function JSONToQuiz(QuizJSON: TJSONObject): string;
  end;

implementation

constructor TQuestion.Create(QuizJSON: TJSONObject);
  begin

  end;

function TQuestion.JSONToQuiz(QuizJSON: TJSONObject): string;
  var
    JSONObject, r: TJSONObject;
    JSONValue: TJSONValue;
    questions: TJSONArray;
    i : integer;
    return: string;
  begin
    return := '';
    questions := QuizJSON.GetValue<TJSONArray>('results');
    for i := 0 to questions.Count - 1 do
      begin
        r := questions[i] as TJSONObject;
        return := return + 'Question: ' + TNetEncoding.HTML.Decode(r.GetValue<string>('question')) + sLineBreak;
      end;

    Result := return;


  end;

end.
