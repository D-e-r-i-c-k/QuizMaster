unit home_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.WinXPanels, System.Generics.Collections;

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
    procedure FormDestroy(Sender: TObject);
    procedure StartQuizClick(Sender: TObject);
    procedure shpBtnStrtQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditQuizClick(Sender: TObject);
    procedure DeleteQuizClick(Sender: TObject);
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
    intQuizID: integer;
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
  // MyQuizzes list:
  lstMyQuizzes := TObjectList<TPanel>.Create(False);
  intQuizID := 0;
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
  shpBox, shpBtnStrtQuiz: TShape;
  pnlBox, pnlBtnStrtQuiz: TPanel;
  imgQuizBox1, imgQuizBox2, imgQuizType, imgBtnEditQuiz, imgBtnDelQuiz: TImage;
  lblTitle, lblSubTitle, lblDateAdded, lblAmtQuestions, lblBtnStrtQuiz: TLabel;
  strQuizType: string;
begin
// Asign QuizID:
  Inc(intQuizID, 1);

// Update Saved Quizzes Count:
  Inc(intQuizAmt, 1);
  lblStat1Num.Caption := IntToStr(intQuizAmt);

// Panel Creation:
  pnlBox := TPanel.Create(Self);
  pnlBox.Parent := pnlMyQuizzesScroll;
  pnlBox.Width := 200;
  pnlBox.Height := 225;

  pnlBox.BevelEdges := [];
  pnlBox.BevelOuter := bvNone;
  pnlBox.Tag := intQuizID;

// Panel Position:
  pnlBox.Left := intMyQuizzesLeft;
  pnlBox.Top := intMyQuizzesTop;

// Box Shape:
  shpBox := TShape.Create(Self);
  shpBox.Parent := pnlBox;
  shpBox.Shape := stRoundRect;
  shpBox.Width := 200;
  shpBox.Height := 225;

// Box Position:
  shpBox.Left := 0;
  shpBox.Top := 0;

  sbMyQuizzes.VertScrollBar.Position := pnlBox.Top + 9;

// Update Position for next box:
  Inc(intMyQuizzesLeft, pnlBox.Width + 5);
  if intMyQuizzesLeft + pnlBox.Width > sbMyQuizzes.Width then
    begin
      pnlMyQuizzesScroll.Height := pnlMyQuizzesScroll.Height + pnlBox.Height + 36;
      sbMyQuizzes.VertScrollBar.Range := pnlMyQuizzesScroll.Height;
      intMyQuizzesLeft := 0;
      Inc(intMyQuizzesTop, pnlBox.Height + 5);
    end;

// Add Box to List of Boxes:
  lstMyQuizzes.Add(pnlBox);

// Panel Text:
  // Title:
  lblTitle := TLabel.Create(Self);
  lblTitle.Parent := pnlBox;
  lblTitle.Left := 15;
  lblTitle.Top := 20;
  lblTitle.Caption := 'Quiz Title ' + IntToStr(intQuizID);
  lblTitle.Font.Size := 14;
  lblTitle.Font.Style := [fsBold];

  // Subtitle:
  lblSubTitle := TLabel.Create(Self);
  lblSubTitle.Parent := pnlBox;
  lblSubTitle.Left := 15;
  lblSubTitle.Top := 47;
  lblSubTitle.Caption := 'Quiz Caption';
  lblSubTitle.Font.Color := $666666;
  lblSubTitle.Font.Size := 10;

  // Amount of Questions:
  // Image:
  imgQuizBox1 := TImage.Create(Self);
  imgQuizBox1.Parent := pnlBox;
  imgQuizBox1.Left := 15;
  imgQuizBox1.Top := 104;
  imgQuizBox1.Height := 17;
  imgQuizBox1.Width := 17;
  imgQuizBox1.Picture.LoadFromFile('icons/imgQuizBox1.png');
  imgQuizBox1.Center := True;
  imgQuizBox1.Stretch := True;

  // Text:
  lblAmtQuestions := TLabel.Create(Self);
  lblAmtQuestions.Parent := pnlBox;
  lblAmtQuestions.Left := 38;
  lblAmtQuestions.Top := 106;
  lblAmtQuestions.Caption := 'x Questions';
  lblAmtQuestions.Font.Color := $666666;
  lblAmtQuestions.Font.Size := 8;

  // Date Added:
  // Image:
  imgQuizBox2 := TImage.Create(Self);
  imgQuizBox2.Parent := pnlBox;
  imgQuizBox2.Left := 103;
  imgQuizBox2.Top := 104;
  imgQuizBox2.Height := 17;
  imgQuizBox2.Width := 17;
  imgQuizBox2.Picture.LoadFromFile('icons/imgQuizBox2.png');
  imgQuizBox2.Center := True;
  imgQuizBox2.Stretch := True;

  // Text:
  lblDateAdded := TLabel.Create(Self);
  lblDateAdded.Parent := pnlBox;
  lblDateAdded.Left := 126;
  lblDateAdded.Top := 106;
  lblDateAdded.Caption := FormatDateTime('yyyy-mm-dd', Date());
  lblDateAdded.Font.Color := $666666;
  lblDateAdded.Font.Size := 8;

  // Quiz Type - Get from DB:
  if intQuizID mod 2 = 0 then
    begin
      strQuizType := 'User'
    end
  else
    begin
      strQuizType := 'AI'
    end;

  // Image Quiz Type:
  imgQuizType := TImage.Create(Self);
  imgQuizType.Parent := pnlBox;
  imgQuizType.Left := 160;
  imgQuizType.Top := 16;
  imgQuizType.Height := 25;
  imgQuizType.Width := 25;
  imgQuizType.Center := True;
  imgQuizType.Stretch := True;
  imgQuizType.Picture.LoadFromFile('icons/img' + strQuizType + '.png');

// Box Buttons:
  // Start Quiz
  // Panel
  pnlBtnStrtQuiz := TPanel.Create(Self);
  pnlBtnStrtQuiz.Parent := pnlBox;
  pnlBtnStrtQuiz.Left := 16;
  pnlBtnStrtQuiz.Top := 161;
  pnlBtnStrtQuiz.Width := 105;
  pnlBtnStrtQuiz.Height := 24;
  pnlBtnStrtQuiz.BevelEdges := [];
  pnlBtnStrtQuiz.BevelOuter := bvNone;
  pnlBtnStrtQuiz.Tag := intQuizID;

  // Shape
  shpBtnStrtQuiz := TShape.Create(Self);
  shpBtnStrtQuiz.Parent := pnlBtnStrtQuiz;
  shpBtnStrtQuiz.Width := 105;
  shpBtnStrtQuiz.Height := 24;
  shpBtnStrtQuiz.Shape := stRoundRect;
  shpBtnStrtQuiz.Brush.Color := clBackground;
  shpBtnStrtQuiz.Brush.Style := bsSolid;
  shpBtnStrtQuiz.Tag := intQuizID;

  // Label
  lblBtnStrtQuiz := TLabel.Create(Self);
  lblBtnStrtQuiz.Parent := pnlBtnStrtQuiz;
  lblBtnStrtQuiz.Alignment := taCenter;
  lblBtnStrtQuiz.Caption := 'Start Quiz';
  lblBtnStrtQuiz.Font.Color := clHighlightText;
  lblBtnStrtQuiz.Font.Size := 12;
  lblBtnStrtQuiz.Font.Style := [TFontStyle.fsBold];
  lblBtnStrtQuiz.Left := 15;
  lblBtnStrtQuiz.Top := 2;
  lblBtnStrtQuiz.Tag := intQuizID;

  // OnClick
  lblBtnStrtQuiz.OnClick := StartQuizClick;
  pnlBtnStrtQuiz.OnClick := StartQuizClick;
  shpBtnStrtQuiz.OnMouseDown := shpBtnStrtQuizMouseDown;

  //Edit Quiz
  imgBtnEditQuiz := TImage.Create(Self);
  imgBtnEditQuiz.Parent := pnlBox;
  imgBtnEditQuiz.Width := 21;
  imgBtnEditQuiz.Height := 21;
  imgBtnEditQuiz.Top := 161;
  imgBtnEditQuiz.Left := 140;
  imgBtnEditQuiz.Center := True;
  imgBtnEditQuiz.Stretch := True;
  imgBtnEditQuiz.Picture.LoadFromFile('icons/imgEdit.png');
  imgBtnEditQuiz.Tag := intQuizID;

  // On Click
  imgBtnEditQuiz.OnClick := EditQuizClick;



  //Delete Quiz
  imgBtnDelQuiz := TImage.Create(Self);
  imgBtnDelQuiz.Parent := pnlBox;
  imgBtnDelQuiz.Width := 21;
  imgBtnDelQuiz.Height := 21;
  imgBtnDelQuiz.Top := 161;
  imgBtnDelQuiz.Left := 167;
  imgBtnDelQuiz.Center := True;
  imgBtnDelQuiz.Stretch := True;
  imgBtnDelQuiz.Picture.LoadFromFile('icons/imgDelete.png');
  imgBtnDelQuiz.Tag := intQuizID;

  // On Click
  imgBtnDelQuiz.OnClick := DeleteQuizClick;

end;

procedure TfrmHome.shpBtnStrtQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartQuizClick(Sender); // Calls your TNotifyEvent handler
end;

procedure TfrmHome.EditQuizClick(Sender: TObject);
var
  intQuizID: Integer;
begin
  try
    intQuizID := TImage(Sender).Tag;
    ShowMessage('Edit Quiz with ID: ' + IntToStr(intQuizID))
  finally

  end;
end;

procedure TfrmHome.DeleteQuizClick(Sender: TObject);
var
  intQuizID: Integer;
begin
  try
    intQuizID := TImage(Sender).Tag;
    ShowMessage('Delete Quiz with ID: ' + IntToStr(intQuizID))
  finally

  end;
end;

procedure TfrmHome.StartQuizClick(Sender: TObject);
var
  intQuizID: Integer;
begin
  if Sender is TPanel then
    intQuizID := TPanel(Sender).Tag
  else if Sender is TLabel then
    intQuizID := TLabel(Sender).Tag
  else if Sender is TShape then
    intQuizID := TShape(Sender).Tag
  else
    Exit;

  ShowMessage('Load Quiz with ID: ' + IntToStr(intQuizID));
  // Load quiz from DB here
end;

end.


