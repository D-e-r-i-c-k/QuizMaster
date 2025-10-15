// clsQuizBoxManager_u.pas
// Purpose: Manages collections of quizzes (quiz boxes) used for grouping
// and selection in the UI.

unit clsQuizBoxManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Buttons, Vcl.WinXPanels,
  System.Generics.Collections, dbMain_u, frmAnswerQuiz_u, frmEditQuiz_u, clsQuestion_u;

type
  TQuizBoxManager = class
  private
    {Private Variables}
//  Box Position:
    FMyQuizzesLeft, FMyQuizzesTop: integer;
//  Parent Panel for all quiz boxes:
    FQuizParent: TPanel;
//  Scroll For QuizBox:
    FQuizScroller: TScrollBox;
//  Quiz ID:
    FQuizID: integer;
// Quiz List:
    FQuizList: TObjectList<TPanel>;
  public
    {Constructor, Procedures and Properties}
    constructor Create(pnlQuizContainer: TPanel; sbScrollBox: TScrollBox);
    procedure AddQuiz(QuizID: integer);
    procedure StartQuizClick(Sender: TObject);
    procedure EditQuizClick(Sender: TObject);
    procedure DeleteQuizClick(Sender: TObject);
    property Quizzes: TObjectList<TPanel> read FQuizList write FQuizList;
    procedure ReloadAllQuizzes;
    procedure QuizUpdated(Sender: TObject);

    procedure LoadAllQuizzes;
  end;

var
  QuizAnswerForm: TfrmAnswerQuiz;
  EditQuizForm: TfrmEditQuiz;
implementation

constructor TQuizBoxManager.Create(pnlQuizContainer: TPanel; sbScrollBox: TScrollBox);
begin
  FQuizParent := pnlQuizContainer;
  FQuizScroller := sbScrollBox;
  FQuizList := TObjectList<TPanel>.Create(False);
  FQuizID := -1;
end;

procedure TQuizBoxManager.AddQuiz(QuizID: integer);
var
  pnlBox, pnlBtnStrtQuiz: TPanel;
  shpBox, shpBtnStrtQuiz: TShape;
  lblTitle, lblSubTitle, lblAmtQuestions, lblDateAdded, lblBtnStrtQuiz: TLabel;
  imgQuizBox1, imgQuizBox2, imgQuizType, imgBtnEditQuiz, imgBtnDelQuiz: TImage;
  strQuizType: string;
  Properties: TList<string>;
  Quiz: TList<TQuestion>;
begin
  //Quiz Properties:
  Properties := dmDatabase.GetQuizDetails(QuizID);
  Quiz := dmDatabase.GetQuiz(QuizID);
  //Panel Of Box:
  pnlBox := TPanel.Create(FQuizParent.Owner);
  pnlBox.Parent := FQuizParent;
  pnlBox.Width := 200;
  pnlBox.Height := 225;

  pnlBox.BevelEdges := [];
  pnlBox.BevelOuter := bvNone;
  pnlBox.Tag := QuizID;

  pnlBox.Left := FMyQuizzesLeft;
  pnlBox.Top := FMyQuizzesTop;

  //Shape Of Box:
  shpBox := TShape.Create(FQuizParent.Owner);
  shpBox.Parent := pnlBox;
  shpBox.Shape := stRoundRect;
  shpBox.Width := 200;
  shpBox.Height := 225;

  //Scroll To Added Box:
  FQuizScroller.VertScrollBar.Position := pnlBox.Top + 9;

  // Update Position for next box:
  Inc(FMyQuizzesLeft, pnlBox.Width + 5);
  if FMyQuizzesLeft + pnlBox.Width > FQuizParent.Width then
  begin
    FQuizParent.Height := FQuizParent.Height + pnlBox.Height + 36;
    FQuizScroller.VertScrollBar.Range := FQuizParent.Height;
    FMyQuizzesLeft := 0;
    Inc(FMyQuizzesTop, pnlBox.Height + 5);
  end;

  // Add Quiz To List of Quizzes;
  FQuizList.Add(pnlBox);

  // Panel Text:
    // Title:
  lblTitle := TLabel.Create(FQuizParent.Owner);
  lblTitle.Parent := pnlBox;
  lblTitle.Left := 15;
  lblTitle.Top := 20;
  lblTitle.Caption := Properties[0];
  lblTitle.Font.Size := 14;
  lblTitle.Font.Style := [fsBold];

    // Subtitle:
  lblSubTitle := TLabel.Create(FQuizParent.Owner);
  lblSubTitle.Parent := pnlBox;
  lblSubTitle.Left := 15;
  lblSubTitle.Top := 47;
  lblSubTitle.Caption := Properties[1];
  lblSubTitle.Font.Color := $666666;
  lblSubTitle.Font.Size := 8;

  // Amount of Questions:
    // Image:
  imgQuizBox1 := TImage.Create(FQuizParent.Owner);
  imgQuizBox1.Parent := pnlBox;
  imgQuizBox1.Left := 15;
  imgQuizBox1.Top := 104;
  imgQuizBox1.Height := 17;
  imgQuizBox1.Width := 17;
  imgQuizBox1.Picture.LoadFromFile('icons/imgQuizBox1.png');
  imgQuizBox1.Center := True;
  imgQuizBox1.Stretch := True;

    // Text:
  lblAmtQuestions := TLabel.Create(FQuizParent.Owner);
  lblAmtQuestions.Parent := pnlBox;
  lblAmtQuestions.Left := 38;
  lblAmtQuestions.Top := 106;
  lblAmtQuestions.Caption := IntToStr(Quiz.Count) + ' Questions';
  lblAmtQuestions.Font.Color := $666666;
  lblAmtQuestions.Font.Size := 6;

  // Date Added:
    // Image:
  imgQuizBox2 := TImage.Create(FQuizParent.Owner);
  imgQuizBox2.Parent := pnlBox;
  imgQuizBox2.Left := 103;
  imgQuizBox2.Top := 104;
  imgQuizBox2.Height := 17;
  imgQuizBox2.Width := 17;
  imgQuizBox2.Picture.LoadFromFile('icons/imgQuizBox2.png');
  imgQuizBox2.Center := True;
  imgQuizBox2.Stretch := True;

    // Text:
  lblDateAdded := TLabel.Create(FQuizParent.Owner);
  lblDateAdded.Parent := pnlBox;
  lblDateAdded.Left := 126;
  lblDateAdded.Top := 106;
  lblDateAdded.Caption := FormatDateTime('yyyy-mm-dd', StrToDateTime(Properties[3]));
  lblDateAdded.Font.Color := $666666;
  lblDateAdded.Font.Size := 6;

  // Quiz Type - Get from DB:
  strQuizType := Properties[5];

  // Image Quiz Type:
  try
    imgQuizType := TImage.Create(FQuizParent.Owner);
    imgQuizType.Parent := pnlBox;
    imgQuizType.Left := 160;
    imgQuizType.Top := 16;
    imgQuizType.Height := 25;
    imgQuizType.Width := 25;
    imgQuizType.Center := True;
    imgQuizType.Stretch := True;
    imgQuizType.Picture.LoadFromFile('icons/img' + strQuizType + '.png');
  except
    imgQuizType.Destroy;

  end;

  // Box Buttons:
  // Start Quiz
    // Panel
  pnlBtnStrtQuiz := TPanel.Create(FQuizParent.Owner);
  pnlBtnStrtQuiz.Parent := pnlBox;
  pnlBtnStrtQuiz.Left := 16;
  pnlBtnStrtQuiz.Top := 161;
  pnlBtnStrtQuiz.Width := 105;
  pnlBtnStrtQuiz.Height := 24;
  pnlBtnStrtQuiz.BevelEdges := [];
  pnlBtnStrtQuiz.BevelOuter := bvNone;
  pnlBtnStrtQuiz.Tag := QuizID;
  pnlBtnStrtQuiz.Cursor := crHandPoint;

    // Shape
  shpBtnStrtQuiz := TShape.Create(FQuizParent.Owner);
  shpBtnStrtQuiz.Parent := pnlBtnStrtQuiz;
  shpBtnStrtQuiz.Width := 105;
  shpBtnStrtQuiz.Height := 24;
  shpBtnStrtQuiz.Shape := stRoundRect;
  shpBtnStrtQuiz.Brush.Color := clBackground;
  shpBtnStrtQuiz.Brush.Style := bsSolid;
  shpBtnStrtQuiz.Tag := QuizID;

    // Label
  lblBtnStrtQuiz := TLabel.Create(FQuizParent.Owner);
  lblBtnStrtQuiz.Parent := pnlBtnStrtQuiz;
  lblBtnStrtQuiz.Alignment := taCenter;

  lblBtnStrtQuiz.Caption := 'Start Quiz';
  lblBtnStrtQuiz.Font.Color := clHighlightText;
  lblBtnStrtQuiz.Align := alClient;
  lblBtnStrtQuiz.Font.Size := 10;
  lblBtnStrtQuiz.Font.Style := [TFontStyle.fsBold];
  lblBtnStrtQuiz.Tag := QuizID;

    // OnClick
  lblBtnStrtQuiz.OnClick := StartQuizClick;
  pnlBtnStrtQuiz.OnClick := StartQuizClick;

  //Edit Quiz
    // Button
  imgBtnEditQuiz := TImage.Create(FQuizParent.Owner);
  imgBtnEditQuiz.Parent := pnlBox;
  imgBtnEditQuiz.Width := 21;
  imgBtnEditQuiz.Height := 21;
  imgBtnEditQuiz.Top := 161;
  imgBtnEditQuiz.Left := 140;
  imgBtnEditQuiz.Center := True;
  imgBtnEditQuiz.Stretch := True;
  imgBtnEditQuiz.Picture.LoadFromFile('icons/imgEdit.png');
  imgBtnEditQuiz.Tag := QuizID;
  imgBtnEditQuiz.Cursor := crHandPoint;

    // On Click
  imgBtnEditQuiz.OnClick := EditQuizClick;



  //Delete Quiz
    // Button
  imgBtnDelQuiz := TImage.Create(FQuizParent.Owner);
  imgBtnDelQuiz.Parent := pnlBox;
  imgBtnDelQuiz.Width := 21;
  imgBtnDelQuiz.Height := 21;
  imgBtnDelQuiz.Top := 161;
  imgBtnDelQuiz.Left := 167;
  imgBtnDelQuiz.Center := True;
  imgBtnDelQuiz.Stretch := True;
  imgBtnDelQuiz.Picture.LoadFromFile('icons/imgDelete.png');
  imgBtnDelQuiz.Tag := QuizID;
  imgBtnDelQuiz.Cursor := crHandPoint;

    // On Click
  imgBtnDelQuiz.OnClick := DeleteQuizClick;

end;

procedure TQuizBoxManager.StartQuizClick(Sender: TObject);
var
  intQuizID: Integer;
begin
  if Sender is TPanel then
    intQuizID := TPanel(Sender).Tag
  else if Sender is TLabel then
    intQuizID := TLabel(Sender).Tag
  else
    Exit;

  QuizAnswerForm := TfrmAnswerQuiz.Create(Application);
  QuizAnswerForm.QuizID := intQuizID;
  QuizAnswerForm.Show;
end;

procedure TQuizBoxManager.EditQuizClick(Sender: TObject);
var
  intQuizID: integer;
  QuizDetails: TList<String>;
begin
  intQuizID := TImage(Sender).Tag;
  ShowMessage('Edit Quiz with ID: ' + IntToStr(intQuizID));
  QuizDetails := dmDatabase.GetQuizDetails(intQuizID);
  EditQuizForm := TfrmEditQuiz.Create(Application);
  EditQuizForm.OnQuizUpdated := QuizUpdated;
  EditQuizForm.LoadEditQuiz(QuizDetails[0], QuizDetails[2], QuizDetails[1], intQuizID);
  EditQuizForm.Show;
end;

procedure TQuizBoxManager.DeleteQuizClick(Sender: TObject);
var
  intQuizID: integer;
begin
  intQuizID := TImage(Sender).Tag;
  ShowMessage('Delete Quiz with ID: ' + IntToStr(intQuizID));
  if MessageDlg('Are you sure you want to delete this quiz and all its questions?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmDatabase.DeleteQuiz(intQuizID);
    ReloadAllQuizzes;
  end;
end;

procedure TQuizBoxManager.LoadAllQuizzes;
var
  QuizzesToLoad: TList<integer>;
  QuizID: integer;
begin
  QuizzesToLoad := dmDatabase.GetAllNonDailyIDs;
  for QuizID in QuizzesToLoad do
  begin
    AddQuiz(QuizID);
  end;
  FQuizScroller.VertScrollBar.Position := 0;
end;

procedure TQuizBoxManager.ReloadAllQuizzes;
var
  i: Integer;
begin
  // Remove all existing quiz panels from the parent panel
  for i := FQuizList.Count - 1 downto 0 do
  begin
    FQuizList[i].Free;
  end;

  // Clear the list itself
  FQuizList.Clear;

  // Reset positioning
  FMyQuizzesLeft := 0;
  FMyQuizzesTop := 0;

  // Optionally reset parent panel height to avoid scroll offset
  FQuizParent.Height := FQuizScroller.ClientHeight;
  FQuizScroller.VertScrollBar.Position := 0;

  // Load all quizzes again
  LoadAllQuizzes;
end;

procedure TQuizBoxManager.QuizUpdated(Sender: TObject);
begin
  ReloadAllQuizzes;
end;


end.
