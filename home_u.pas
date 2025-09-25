unit home_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.WinXPanels, System.Generics.Collections, System.JSON, Data.DB, Data.Win.ADODB,

  quizbox_u, quiz_caller_u, question_u, database_u, frmCreateQuiz_u, dbTemp_u, GLOBALS_u, aiCaller_u;

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
    pnlMyQuizzes: TPanel;
    shpMyQuizzesMain: TShape;
    pnlMainForm: TPanel;
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
    sbxMyQuizzes: TScrollBox;
    pnlMyQuizzesScroll: TPanel;
    Panel1: TPanel;
    Shape3: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    Label4: TLabel;
    Panel2: TPanel;
    Shape4: TShape;
    Label5: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lblButtonStartDailyClick(Sender: TObject);
    procedure shpButtonStartDailyMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure pnlCreateQuizClick(Sender: TObject);
    procedure shpButtonCreateQuizMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  {private variables}
  public
  {public variables}
  // Positions for Quiz Boxes:
    intMyQuizzesLeft, intMyQuizzesTop, intMyQuizzesCardCount: integer;

  // Stat Boxes Counts:
    intQuizAmt: integer;

  // MyQuizzes:
    lstMyQuizzes: TObjectList<TPanel>;
  end;

var
  frmHome: TfrmHome;
  Question: TQuestion;
  CreateQuizForm: TfrmCreateQuiz;
  AI: TAIQuiz;

implementation

{$R *.dfm}


procedure TfrmHome.Button1Click(Sender: TObject);
begin
  AI.Call('');
end;

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
    // MyQuizzes list:
    lstMyQuizzes := TObjectList<TPanel>.Create(False);

    GLOBALS_u.QuizManager := TQuizBoxManager.Create(pnlMyQuizzesScroll, sbxMyQuizzes);
    CreateQuizForm := TfrmCreateQuiz.Create(nil);
    GLOBALS_u.Cache := TdmCache.Create;

    GLOBALS_u.Cache.CacheAllCategories;
  end;

procedure TfrmHome.FormDestroy(Sender: TObject);
  begin
    lstMyQuizzes.Free;
  end;

procedure TfrmHome.FormShow(Sender: TObject);
  begin
  //Dynamic Text Loading:
    // Daily Quiz
    lblDailyDate.Caption := 'Daily Quiz - ' + FormatDateTime('yyyy-mm-dd', Date());
    lblDailyTopic.Caption := 'Topic: Literature';
    lblDailyStreak.Caption := 'Current Streak: 0';
    lblDailyAmntQuestions.Caption := '3 Questions';

  //Load all saved Quizzes from DB
    GLOBALS_u.QuizManager.LoadAllQuizzes;
  end;

procedure TfrmHome.lblButtonStartDailyClick(Sender: TObject);
  begin
    ShowMessage('Clicked')
  end;

procedure TfrmHome.pnlCreateQuizClick(Sender: TObject);
  begin
    CreateQuizForm.Show;
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

end.


