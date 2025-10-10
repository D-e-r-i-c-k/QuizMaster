unit frmAnswerQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.WinXPanels, Vcl.ExtCtrls,

  clsQuizAnswerManager_u;

type
  TfrmAnswerQuiz = class(TForm)
    lblAnswerQuizTile: TLabel;
    pbAnswerProgress: TProgressBar;
    pnlQuestion: TPanel;
    shpQuestionBG: TShape;
    cplQuestions: TCardPanel;
    crdQuestion: TCard;
    lblQuestionNumber: TLabel;
    lblQuestionText: TLabel;
    pnlAnswer: TPanel;
    shpTextAnswerBG: TShape;
    cplAnswerType: TCardPanel;
    crdTextAnswer: TCard;
    pnlTextAnswer: TPanel;
    pnlTextAnswerRemoveBorder: TPanel;
    memTextAnswer: TMemo;
    crdBoolean: TCard;
    lblFalse: TLabel;
    lblTrue: TLabel;
    rbtBooleanTrue: TRadioButton;
    rbtBooleanFalse: TRadioButton;
    shpBooleanAnswerBG: TShape;
    crdMultipleChoice: TCard;
    rbtMultipleChoice1: TRadioButton;
    rbtMultipleChoice2: TRadioButton;
    rbtMultipleChoice3: TRadioButton;
    rbtMultipleChoice4: TRadioButton;
    lblMultipleChoiceAnswer1: TLabel;
    lblMultipleChoiceAnswer2: TLabel;
    lblMultipleChoiceAnswer3: TLabel;
    lblMultipleChoiceAnswer4: TLabel;
    pnlNextQuestion: TPanel;
    shpNextQuestionBG: TShape;
    lblNextQuestion: TLabel;
    pnlPrevQuestion: TPanel;
    shpPrevQuestionBG: TShape;
    lblPrevQuestion: TLabel;
    pnlQuestionDifficulty: TPanel;
    shpQuestionDifficultyBG: TShape;
    lblQuestionDifficulty: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lblNextQuestionClick(Sender: TObject);
    procedure shpNextQuestionBGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblPrevQuestionClick(Sender: TObject);
    procedure shpPrevQuestionBGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FQuizID: integer;
  public
    { Public declarations }
    property QuizID: integer read FQuizID write FQuizID;
  end;

var
  frmAnswerQuiz: TfrmAnswerQuiz;
  QuizLoader: TAnswerManager;

implementation

{$R *.dfm}



procedure TfrmAnswerQuiz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Self);
  FreeAndNil(QuizLoader);
end;

procedure TfrmAnswerQuiz.FormShow(Sender: TObject);
begin
  QuizLoader := TAnswerManager.Create(FQuizID, cplQuestions, pbAnswerProgress);
end;

procedure TfrmAnswerQuiz.lblNextQuestionClick(Sender: TObject);
begin
  QuizLoader.ShowNextQuestion(cplQuestions)
end;

procedure TfrmAnswerQuiz.lblPrevQuestionClick(Sender: TObject);
begin
  QuizLoader.ShowPrevQuestion(cplQuestions);
end;

procedure TfrmAnswerQuiz.shpNextQuestionBGMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lblNextQuestionClick(Sender)
end;


procedure TfrmAnswerQuiz.shpPrevQuestionBGMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lblPrevQuestionClick(Sender)
end;

end.

