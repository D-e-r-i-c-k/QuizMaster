unit home_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.WinXPanels;

type
  TfrmHome = class(TForm)
    lblTitle: TLabel;
    pnlHeader: TPanel;
    lblSubTitle: TLabel;
    shpStat1: TShape;
    pnlStat1: TPanel;
    lblStat1Num: TLabel;
    lblStat1Text: TLabel;
    imgStat1: TImage;
    pnlStat2: TPanel;
    shpStat2: TShape;
    lblStat2Num: TLabel;
    lblStat2Text: TLabel;
    imgStat2: TImage;
    pnlStat3: TPanel;
    shpStat3: TShape;
    lblStat3Num: TLabel;
    lblStat3Text: TLabel;
    imgStat3: TImage;
    pnlStat4: TPanel;
    shpStat4: TShape;
    lblStat4Num: TLabel;
    lblStat4Text: TLabel;
    imgStat4: TImage;
    pnlDailyQuiz: TPanel;
    shpDailyQuiz: TShape;
    shpButtonStartDaily: TShape;
    pnlStartDaily: TPanel;
    lblButtonStartDaily: TLabel;
    pnlDailyQuizInfo: TPanel;
    lblDailyButtonSubtext: TLabel;
    imgDaily1: TImage;
    imgDaily2: TImage;
    lblDailyTitle: TLabel;
    lblDailyAmntQuestions: TLabel;
    lblDailyDate: TLabel;
    lblDailyMotivation: TLabel;
    lblDailyTopic: TLabel;
    lblDailyStreak: TLabel;
    imgDaily3: TImage;
    pnlQuizSelector: TPanel;
    sbtnMyQuizzes: TSpeedButton;
    sbtnOnlineQuizzes: TSpeedButton;
    pnlMyQuizzes: TPanel;
    shpMyQuizzesMain: TShape;
    cdpQuizzSelection: TCardPanel;
    crdMyQuizzes: TCard;
    crdOnlineQuizzes: TCard;
    pnlOnlineQuizzes: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    sbMainSrcoll: TScrollBox;
    pnlMyQuizzesHeader: TPanel;
    imgMyQuizzes1: TImage;
    lblMyQuizzesTitle: TLabel;
    lblMyQuizzesSubTitle: TLabel;
    pnlCreateQuiz: TPanel;
    shpButtonCreateQuiz: TShape;
    lblCreateQuiz: TLabel;
    shpMyQuizzesSearch: TShape;
    imgMyQuizzesSearch: TImage;
    edtMyQuizzesSearch: TEdit;
    sbMyQuizzes: TScrollBox;
    pnlMyQuizzesScroll: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure lblButtonStartDailyClick(Sender: TObject);
    procedure shpButtonStartDailyMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure sbtnMyQuizzesClick(Sender: TObject);
    procedure sbtnOnlineQuizzesClick(Sender: TObject);
    procedure pnlCreateQuizClick(Sender: TObject);
    procedure shpButtonCreateQuizMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AddCardToMyQuizzes;
  private
  {private variables}
  public
  {public variables}
  // Positions for Quiz Boxes:
    intMyQuizzesLeft, intMyQuizzesTop, intMyQuizzesCardCount: integer;

  // Stat Boxes Counts:
    intQuizAmt: integer;
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.dfm}



procedure TfrmHome.FormCreate(Sender: TObject);
begin
// Image Loading:
  // Stats
  imgStat1.Picture.LoadFromFile('icons/imgStat1.png');
  imgStat2.Picture.LoadFromFile('icons/imgStat2.png');
  imgStat3.Picture.LoadFromFile('icons/imgStat3.png');
  imgStat4.Picture.LoadFromFile('icons/imgStat4.png');
  // Daily Quiz
  imgDaily1.Picture.LoadFromFile('icons/imgDaily1.png');
  imgDaily2.Picture.LoadFromFile('icons/imgDaily2.png');
  imgDaily3.Picture.LoadFromFile('icons/imgDaily3.png');
  // My Quizzes
  imgMyQuizzes1.Picture.LoadFromFile('icons/imgMyQuizzes1.png');
  imgMyQuizzesSearch.Picture.LoadFromFile('icons/imgSearch.png');

// Variable Initializing:
  // Stats:
  intQuizAmt := 0;
  // My Quizzes
  intMyQuizzesLeft := 0;
  intMyQuizzesTop := 0;
  intMyQuizzesCardCount := 0;
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
//Dynamic Text Loading:
  // Daily Quiz
  lblDailyDate.Caption := 'Daily Quiz - ' + FormatDateTime('yyyy-mm-dd', Date());
  lblDailyTopic.Caption := 'Topic: Literature';
  lblDailyStreak.Caption := 'Current Streak: 0';
  lblDailyAmntQuestions.Caption := '3 Questions';
end;

procedure TfrmHome.lblButtonStartDailyClick(Sender: TObject);
begin
  ShowMessage('Clicked')
end;

procedure TfrmHome.pnlCreateQuizClick(Sender: TObject);
begin
  AddCardToMyQuizzes
end;

procedure TfrmHome.sbtnMyQuizzesClick(Sender: TObject);
begin
  cdpQuizzSelection.ActiveCard := crdMyQuizzes;
end;

procedure TfrmHome.sbtnOnlineQuizzesClick(Sender: TObject);
begin
  cdpQuizzSelection.ActiveCard := crdOnlineQuizzes;
end;

procedure TfrmHome.shpButtonStartDailyMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lblButtonStartDaily.OnClick(lblButtonStartDaily);
end;

procedure TfrmHome.shpButtonCreateQuizMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlCreateQuiz.OnClick(lblCreateQuiz);
end;

procedure TfrmHome.AddCardToMyQuizzes;
var
  shpBox: TShape;
  intPnlPrevHight: integer;
begin
// Update Saved Quizzes Count:
  Inc(intQuizAmt, 1);
  lblStat1Num.Caption := IntToStr(intQuizAmt);

// Box Shape:
  shpBox := TShape.Create(Self);
  shpBox.Parent := pnlMyQuizzesScroll;
  shpBox.Shape := stRoundRect;
  shpBox.Width := 250;
  shpBox.Height := 281;

// Box Position:
  shpBox.Left := intMyQuizzesLeft;
  shpBox.Top := intMyQuizzesTop;
  sbMyQuizzes.VertScrollBar.Position := shpBox.Top + 9;

// Update Position for next box:
  Inc(intMyQuizzesLeft, shpBox.Width + 9);
  if intMyQuizzesLeft + shpBox.Width > sbMyQuizzes.Width then
  begin
    pnlMyQuizzesScroll.Height := pnlMyQuizzesScroll.Height + shpBox.Height + 36;
    sbMyQuizzes.VertScrollBar.Range := pnlMyQuizzesScroll.Height;
    intMyQuizzesLeft := 0;
    Inc(intMyQuizzesTop, shpBox.Height + 9);
  end;

end;

end.


