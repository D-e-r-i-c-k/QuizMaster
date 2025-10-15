// clsAnswer_u.pas
// Purpose: Defines the TAnswer class that represents a user's answer to a
// question within the QuizMaster application. Includes fields for the
// user's answer, whether it was correct, and related metadata.

unit clsAnswer_u;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections, System.NetEncoding;

type
  TAnswer = class
  private
    {Private Variables}
    FQuestionType: string;
    FDifficulty: string;
    FQuestion: string;
    FUserAnswer: string;
    FExpectedAnswer: string;
    FIsCorrect: Boolean;
  public
    {Constructor, Procedures, Properties}
    constructor Create;
    property QuestionType: string read FQuestionType write FQuestionType;
    property Difficulty: string read FDifficulty write FDifficulty;
    property Question: string read FQuestion write FQuestion;
    property UserAnswer: string read FUserAnswer write FUserAnswer;
    property ExpectedAnswer: string read FExpectedAnswer write FExpectedAnswer;
    property IsCorrect: Boolean read FIsCorrect write FIsCorrect;
  end;

implementation

constructor TAnswer.Create;
begin
  QuestionType := '';
  Difficulty := '';
  Question := '';
  UserAnswer := 'No Answer';
  ExpectedAnswer := '';
  IsCorrect := False;
end;

end.
