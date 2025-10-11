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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FQuizCompletionID: integer;
  public
    { Public declarations }
    property QuizCompletionID: integer read FQuizCompletionID write FQuizCompletionID;
  end;

var
  frmResults: TfrmResults;
  Results: TResutlsManager;

implementation

{$R *.dfm}

procedure TfrmResults.FormShow(Sender: TObject);
begin
  Results := TResutlsManager.Create(sbxMain, QuizCompletionID);
end;

end.
