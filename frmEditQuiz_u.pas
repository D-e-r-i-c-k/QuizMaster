// frmEditQuiz_u.pas
// Purpose: UI for editing an existing quiz. Allows updating quiz details
// and questions; delegates persistence to the database manager.

unit frmEditQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, clsEditQuizManager_u, dbMain_u;

type
  TfrmEditQuiz = class(TForm)
    pnlHeader: TPanel;
    lblQuizEditHeader: TLabel;
    lblQuizEditSubTitle: TLabel;
    pnlCustomQuizHeader: TPanel;
    shpCustomQuizHeaderBG: TShape;
    lblCustomQuizTitle: TLabel;
    lblCustomQuizCategory: TLabel;
    lblCustomQuizDescription: TLabel;
    pnlCustomQuizTitle: TPanel;
    shpCustomQuizTitleBG: TShape;
    pnlCustomQuizTitleRemoveBorder: TPanel;
    edtCustomQuizTitle: TEdit;
    pnlCustomQuizCategory: TPanel;
    shpCustomQuizCategoryBG: TShape;
    pnlCustomQuizCategoryRemoveBorder: TPanel;
    edtCustomQuizCategory: TEdit;
    pnlCustomQuizDescription: TPanel;
    shpCustomQuizDescriptionBG: TShape;
    pnlCustomQuizDescriptionRemoveBorder: TPanel;
    memCustomQuizDescription: TMemo;
    pnlButtonCreateCustomQuiz: TPanel;
    shpButtonCreateCustomQuiz: TShape;
    lblCreateCustomQuiz: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlButtonCreateCustomQuizClick(Sender: TObject);
    procedure lblCreateCustomQuizClick(Sender: TObject);
    procedure shpButtonCreateCustomQuizMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FQuizID: Integer;
    FOnQuizUpdated: TNotifyEvent;
  public
    { Public declarations }
    procedure LoadEditQuiz(QuizTitle: string; QuizCategory: string; QuizDescription: string; QuizID: Integer);
    procedure EditQuiz;
    property OnQuizUpdated: TNotifyEvent read FOnQuizUpdated write FOnQuizUpdated;
  end;

var
  frmEditQuiz: TfrmEditQuiz;
  EditManager: TEditQuizManager;

implementation

{$R *.dfm}

procedure TfrmEditQuiz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FOnQuizUpdated(Self);
  FreeAndNil(Self);
end;

procedure TfrmEditQuiz.lblCreateCustomQuizClick(Sender: TObject);
begin
  EditQuiz;
end;

procedure TfrmEditQuiz.LoadEditQuiz(QuizTitle: string; QuizCategory: string; QuizDescription: string; QuizID: Integer);
begin
  edtCustomQuizTitle.Text := QuizTitle;
  edtCustomQuizCategory.Text := QuizCategory;
  memCustomQuizDescription.Text := QuizDescription;

  FQuizID := QuizID;
end;

procedure TfrmEditQuiz.pnlButtonCreateCustomQuizClick(Sender: TObject);
begin
  EditQuiz;
end;

procedure TfrmEditQuiz.shpButtonCreateCustomQuizMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EditQuiz;
end;

procedure TfrmEditQuiz.EditQuiz;
var
  NewTitle, NewCat, NewDescpription: string;
begin
  if edtCustomQuizTitle.Text <> '' then
  begin
    NewTitle := Trim(edtCustomQuizTitle.Text);
  end;
  if edtCustomQuizCategory.Text <> '' then
  begin
    NewCat := Trim(edtCustomQuizCategory.Text)
  end;
  if memCustomQuizDescription.Text <> '' then
  begin
    NewDescpription := Trim(memCustomQuizDescription.Text);
  end;

  if (edtCustomQuizTitle.Text <> '') and (edtCustomQuizCategory.Text <> '') and (memCustomQuizDescription.Text <> '') then
  begin
    if dmDatabase.UpdateDetails(FQuizID, NewTitle, NewCat, NewDescpription) = 1 then
    begin
      ShowMessage('Updated quiz at ID: ' + IntToStr(FQuizID));
    end
    else
    begin
      ShowMessage('Error editting quiz.')
    end;
    Self.Close;
  end
  else
  begin
    ShowMessage('Please fill all fields.');
  end;
end;

end.
