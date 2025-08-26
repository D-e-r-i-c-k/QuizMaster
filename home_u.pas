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
    shpMyQuizzesCreateCustomQuiz: TShape;
    shpMyQuizzesCreateAIQuiz: TShape;
    cdpQuizzSelection: TCardPanel;
    crdMyQuizzes: TCard;
    crdOnlineQuizzes: TCard;
    pnlOnlineQuizzes: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    sbMainSrcoll: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure lblButtonStartDailyClick(Sender: TObject);
    procedure shpButtonStartDailyMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure sbtnMyQuizzesClick(Sender: TObject);
    procedure sbtnOnlineQuizzesClick(Sender: TObject);
  private
  {private variables}
  public
  {public variables}
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

end.


