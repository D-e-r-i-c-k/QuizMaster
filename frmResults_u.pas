unit frmResults_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, clsResultsManager_u;

type
  TfrmResults = class(TForm)
    pnlHeader: TPanel;
    lblQuizResultsHeader: TLabel;
    lblQuizResultsSubTitle: TLabel;
    sbxMain: TScrollBox;
    pnlQuestion: TPanel;
    shpQuestionBG: TShape;
    lblQuestionNumber: TLabel;
    memQuestion: TMemo;
    lblUserAnswerHeader: TLabel;
    memUserAnswer: TMemo;
    memExpectedAnswer: TMemo;
    lbExpecteAnswerHeader: TLabel;
    lblQuizResult: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FQuizCompletionID: integer;
    FQuizScore: Real;
    FOnClose: TNotifyEvent;
  public
    { Public declarations }
    property QuizCompletionID: integer read FQuizCompletionID write FQuizCompletionID;
    property QuizScore: Real read FQuizScore write FQuizScore;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

var
  frmResults: TfrmResults;
  Results: TResutlsManager;

implementation

{$R *.dfm}

procedure TfrmResults.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OnClose(Self);
  FreeAndNil(Self);
end;

procedure TfrmResults.FormShow(Sender: TObject);
begin
  Results := TResutlsManager.Create(sbxMain, QuizCompletionID);
  lblQuizResult.Caption := FloatToStrF(FQuizScore, ffFixed, 8, 2) + '%'
end;

end.
