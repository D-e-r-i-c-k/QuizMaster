unit quizbox_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.WinXPanels, System.Generics.Collections;

type
  TQuizBoxManager = class
  private
    {Private Variables}
//  Box Position:
    intMyQuizzesLeft, intMyQuizzesTop: integer;
//  Parent Panel for all quiz boxes:
    pnlQuizParent: TPanel;
//  Scroll For QuizBox:
    sbQuizScroller: TScrollBox;
//  Quiz ID:
    intQuizID: integer;
// Quiz List:
    LSTQuizList: TObjectList<TPanel>;

  public
    {Public Variables}
    constructor Create(pnlQuizContainer: TPanel; sbScrollBox: TScrollBox);
    procedure AddQuiz;
    procedure StartQuizClick(Sender: TObject);
    procedure EditQuizClick(Sender: TObject);
    procedure DeleteQuizClick(Sender: TObject);
    property lstQuizzes: TObjectList<TPanel> read LSTQuizList write LSTQuizList;
  end;

implementation

constructor TQuizBoxManager.Create(pnlQuizContainer: TPanel; sbScrollBox: TScrollBox);
  begin
    pnlQuizParent := pnlQuizContainer;
    sbQuizScroller := sbScrollBox;
    LSTQuizList := TObjectList<TPanel>.Create(False);
    intQuizID := -1;
  end;

procedure TQuizBoxManager.AddQuiz;
  var
    pnlBox, pnlBtnStrtQuiz: TPanel;
    shpBox, shpBtnStrtQuiz: TShape;
    lblTitle, lblSubTitle, lblAmtQuestions, lblDateAdded, lblBtnStrtQuiz: TLabel;
    imgQuizBox1, imgQuizBox2, imgQuizType, imgBtnEditQuiz, imgBtnDelQuiz: TImage;
    strQuizType: string;
  begin
    Inc(intQuizID);
  //Panel Of Box:
    pnlBox := TPanel.Create(pnlQuizParent.Owner);
    pnlBox.Parent := pnlQuizParent;
    pnlBox.Width := 200;
    pnlBox.Height := 225;

    pnlBox.BevelEdges := [];
    pnlBox.BevelOuter := bvNone;
    pnlBox.Tag := intQuizID;

    pnlBox.Left := intMyQuizzesLeft;
    pnlBox.Top := intMyQuizzesTop;

  //Shape Of Box:
    shpBox := TShape.Create(pnlQuizParent.Owner);
    shpBox.Parent := pnlBox;
    shpBox.Shape := stRoundRect;
    shpBox.Width := 200;
    shpBox.Height := 225;

  //Scroll To Added Box:
    sbQuizScroller.VertScrollBar.Position := pnlBox.Top + 9;

  // Update Position for next box:
    Inc(intMyQuizzesLeft, pnlBox.Width + 5);
    if intMyQuizzesLeft + pnlBox.Width > pnlQuizParent.Width then
      begin
        pnlQuizParent.Height := pnlQuizParent.Height + pnlBox.Height + 36;
        sbQuizScroller.VertScrollBar.Range := pnlQuizParent.Height;
        intMyQuizzesLeft := 0;
        Inc(intMyQuizzesTop, pnlBox.Height + 5);
      end;

  // Add Quiz To List of Quizzes;
    LSTQuizList.Add(pnlBox);

  // Panel Text:
    // Title:
    lblTitle := TLabel.Create(pnlQuizParent.Owner);
    lblTitle.Parent := pnlBox;
    lblTitle.Left := 15;
    lblTitle.Top := 20;
    lblTitle.Caption := 'Quiz Title ' + IntToStr(intQuizID);
    lblTitle.Font.Size := 14;
    lblTitle.Font.Style := [fsBold];

    // Subtitle:
    lblSubTitle := TLabel.Create(pnlQuizParent.Owner);
    lblSubTitle.Parent := pnlBox;
    lblSubTitle.Left := 15;
    lblSubTitle.Top := 47;
    lblSubTitle.Caption := 'Quiz Caption';
    lblSubTitle.Font.Color := $666666;
    lblSubTitle.Font.Size := 8;

  // Amount of Questions:
    // Image:
    imgQuizBox1 := TImage.Create(pnlQuizParent.Owner);
    imgQuizBox1.Parent := pnlBox;
    imgQuizBox1.Left := 15;
    imgQuizBox1.Top := 104;
    imgQuizBox1.Height := 17;
    imgQuizBox1.Width := 17;
    imgQuizBox1.Picture.LoadFromFile('icons/imgQuizBox1.png');
    imgQuizBox1.Center := True;
    imgQuizBox1.Stretch := True;

    // Text:
    lblAmtQuestions := TLabel.Create(pnlQuizParent.Owner);
    lblAmtQuestions.Parent := pnlBox;
    lblAmtQuestions.Left := 38;
    lblAmtQuestions.Top := 106;
    lblAmtQuestions.Caption := 'x Questions';
    lblAmtQuestions.Font.Color := $666666;
    lblAmtQuestions.Font.Size := 6;

  // Date Added:
    // Image:
    imgQuizBox2 := TImage.Create(pnlQuizParent.Owner);
    imgQuizBox2.Parent := pnlBox;
    imgQuizBox2.Left := 103;
    imgQuizBox2.Top := 104;
    imgQuizBox2.Height := 17;
    imgQuizBox2.Width := 17;
    imgQuizBox2.Picture.LoadFromFile('icons/imgQuizBox2.png');
    imgQuizBox2.Center := True;
    imgQuizBox2.Stretch := True;

    // Text:
    lblDateAdded := TLabel.Create(pnlQuizParent.Owner);
    lblDateAdded.Parent := pnlBox;
    lblDateAdded.Left := 126;
    lblDateAdded.Top := 106;
    lblDateAdded.Caption := FormatDateTime('yyyy-mm-dd', Date());
    lblDateAdded.Font.Color := $666666;
    lblDateAdded.Font.Size := 6;

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
    imgQuizType := TImage.Create(pnlQuizParent.Owner);
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
    pnlBtnStrtQuiz := TPanel.Create(pnlQuizParent.Owner);
    pnlBtnStrtQuiz.Parent := pnlBox;
    pnlBtnStrtQuiz.Left := 16;
    pnlBtnStrtQuiz.Top := 161;
    pnlBtnStrtQuiz.Width := 105;
    pnlBtnStrtQuiz.Height := 24;
    pnlBtnStrtQuiz.BevelEdges := [];
    pnlBtnStrtQuiz.BevelOuter := bvNone;
    pnlBtnStrtQuiz.Tag := intQuizID;

    // Shape
    shpBtnStrtQuiz := TShape.Create(pnlQuizParent.Owner);
    shpBtnStrtQuiz.Parent := pnlBtnStrtQuiz;
    shpBtnStrtQuiz.Width := 105;
    shpBtnStrtQuiz.Height := 24;
    shpBtnStrtQuiz.Shape := stRoundRect;
    shpBtnStrtQuiz.Brush.Color := clBackground;
    shpBtnStrtQuiz.Brush.Style := bsSolid;
    shpBtnStrtQuiz.Tag := intQuizID;

    // Label
    lblBtnStrtQuiz := TLabel.Create(pnlQuizParent.Owner);
    lblBtnStrtQuiz.Parent := pnlBtnStrtQuiz;
    lblBtnStrtQuiz.Alignment := taCenter;

    lblBtnStrtQuiz.Caption := 'Start Quiz';
    lblBtnStrtQuiz.Font.Color := clHighlightText;
    lblBtnStrtQuiz.Align := alClient;
    lblBtnStrtQuiz.Font.Size := 10;
    lblBtnStrtQuiz.Font.Style := [TFontStyle.fsBold];
    lblBtnStrtQuiz.Tag := intQuizID;

    // OnClick
    lblBtnStrtQuiz.OnClick := StartQuizClick;
    pnlBtnStrtQuiz.OnClick := StartQuizClick;

  //Edit Quiz
    // Button
    imgBtnEditQuiz := TImage.Create(pnlQuizParent.Owner);
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
    // Button
    imgBtnDelQuiz := TImage.Create(pnlQuizParent.Owner);
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

    ShowMessage('Load Quiz with ID: ' + IntToStr(intQuizID));
    // Load quiz from DB here
  end;

procedure TQuizBoxManager.EditQuizClick(Sender: TObject);
  var
    intQuizID: integer;
  begin
    intQuizID := TImage(Sender).Tag;
    ShowMessage('Edit Quiz with ID: ' + IntToStr(intQuizID));
    // Load quiz from DB here
  end;

procedure TQuizBoxManager.DeleteQuizClick(Sender: TObject);
  var
    intQuizID: integer;
  begin
    intQuizID := TImage(Sender).Tag;
    ShowMessage('Delete Quiz with ID: ' + IntToStr(intQuizID));
    // Load quiz from DB here
  end;
end.
