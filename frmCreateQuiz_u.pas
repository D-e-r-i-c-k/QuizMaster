// frmCreateQuiz_u.pas
// Purpose: UI form for creating new quizzes. Provides controls for entering
// quiz metadata and questions, and forwards user input to the application's
// quiz creation logic.

unit frmCreateQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.WinXPanels, Vcl.Menus,
  Vcl.Samples.Spin, System.Generics.Collections, GLOBALS_u, clsAiQuizCaller_u,
  clsQuestion_u, dbMain_u, clsQuizBoxManager_u, clsApiQuizCaller_u,
  clsCustomQuizQuestionManager_u, Vcl.Imaging.pngimage;

type
  TfrmCreateQuiz = class(TForm)
    sbxMainScroll: TScrollBox;
    pnlHeader: TPanel;
    lblCreateNewQuizTitle: TLabel;
    lblCreateNewQuizSubTitle: TLabel;
    pnlOnlineCreate: TPanel;
    shpOnlineCreateBG: TShape;
    cpnAPI: TCardPanel;
    crdApiSearch: TCard;
    pnlApiSearch: TPanel;
    lblApiSearchTitle: TLabel;
    imgApiSearch1: TImage;
    lblApiSearchSubTitle: TLabel;
    lblApiCategory: TLabel;
    pnlApiCategories: TPanel;
    shpMyQuizzesSearch: TShape;
    pnlACRemoveBorder: TPanel;
    cbxApiCategories: TComboBox;
    pnlCreateQuiz: TPanel;
    shpButtonCreateQuiz: TShape;
    lblCreateQuiz: TLabel;
    pnlAmntOfApiQuestions: TPanel;
    shpAOACRemoveBorderBG: TShape;
    pnlAOACRemoveBorder: TPanel;
    speAmntOfApiQuestions: TSpinEdit;
    crdAiQuizCreator: TCard;
    pnlAiCreate: TPanel;
    lblAiCreateTitle: TLabel;
    imgAiCreate1: TImage;
    lblAiCreateSubTitle: TLabel;
    lblAiCategory: TLabel;
    pnlAiCategories: TPanel;
    shpAIQuizzesSearch: TShape;
    pnlAiCRemoveBorder: TPanel;
    edtAiCategories: TEdit;
    pnlCreateAiQuiz: TPanel;
    shpButtonCreateAiQuiz: TShape;
    lblCreateAiQuiz: TLabel;
    pnlAmntOfAiQuestions: TPanel;
    pnlAOAiCRemoveBorderBG: TShape;
    pnlAOAiCRemoveBorder: TPanel;
    speAmntOfAiQuestions: TSpinEdit;
    pnlCreateTypeSelector: TPanel;
    sbtAPI: TSpeedButton;
    sbtAI: TSpeedButton;
    pnlAiDifficulty: TPanel;
    shpAiDifficultyBG: TShape;
    pnlAiDifficultyRemoveBorder: TPanel;
    cbxAiDifficultySelector: TComboBox;
    pnlCustomQuizCreator: TPanel;
    shpCustomQuizHeaderBG: TShape;
    pnlCustomQuizHeader: TPanel;
    imgCustomQuizHeader1: TImage;
    lblCustomQuizHeaderSubtitle: TLabel;
    lblCustomQuizHeaderTitle: TLabel;
    lblCustomQuizTitle: TLabel;
    pnlCustomQuizTitle: TPanel;
    shpCustomQuizTitleBG: TShape;
    pnlCustomQuizTitleRemoveBorder: TPanel;
    edtCustomQuizTitle: TEdit;
    lblCustomQuizCategory: TLabel;
    pnlCustomQuizCategory: TPanel;
    shpCustomQuizCategoryBG: TShape;
    pnlCustomQuizCategoryRemoveBorder: TPanel;
    edtCustomQuizCategory: TEdit;
    lblCustomQuizDescription: TLabel;
    pnlCustomQuizDescription: TPanel;
    shpCustomQuizDescriptionBG: TShape;
    pnlCustomQuizDescriptionRemoveBorder: TPanel;
    memCustomQuizDescription: TMemo;
    pnlQuestion: TPanel;
    shpQuestionBG: TShape;
    lblQuestionNumber: TLabel;
    lblQuestionType: TLabel;
    lblQuestionDifficulty: TLabel;
    lblTextAnswerQuestion: TLabel;
    pnlQuestionTypeSelector: TPanel;
    shpQuestionTypeSelectorBG: TShape;
    pnlQuestionTypeSelectorRemoveBorder: TPanel;
    pnlQuestionDifficultySelector: TPanel;
    shpQuestionDifficultyBG: TShape;
    pnlQuestionDificultySelectorRemoveBorder: TPanel;
    pnlTextAnswerQuestionInput: TPanel;
    shpTextAnswerQuestionBG: TShape;
    pnlTextAnswerQuestionInputRemoveBorder: TPanel;
    memTextAnswerQuestionInput: TMemo;
    lblCustomQuestions: TLabel;
    lblTextAnswerAnswer: TLabel;
    pnlTextAnswerAnswerInput: TPanel;
    shpTextAnswerAnswerInputBG: TShape;
    pnlTextAnswerAnswerInputRemoveBorder: TPanel;
    memTextAnswerAnswer: TMemo;
    cmbQuestionType: TComboBox;
    cmbQuestionDifficulty: TComboBox;
    cplQuestionTypeOptions: TCardPanel;
    crdTextAnswer: TCard;
    crdMultipleChoice: TCard;
    pnlQuestionButtons: TPanel;
    shpNewQuestionBG: TShape;
    imgRemoveQuestionBG: TShape;
    imgNewQuestion: TImage;
    imgRemoveQuestion: TImage;
    pnlMultipleChoiceQuestionInput: TPanel;
    shpMultipleChoiceQuestionInputBG: TShape;
    pnlMultipleChoiceQuestionInputRemoveBorder: TPanel;
    memMultipleChoiceQuestionInput: TMemo;
    lblMultipleChoiceQuestion: TLabel;
    lblMultipleChoiceAnswer: TLabel;
    rbtMultipleChoiceAnswer1: TRadioButton;
    pnlMultipleChoiceAnswer1: TPanel;
    shpMultipleChoiceAnswer1BG: TShape;
    pnlMultipleChoiceAnswer1RemoveBorder: TPanel;
    edtMultipleChoiceAnswer1: TEdit;
    pnlMultipleChoiceAnswer2: TPanel;
    shpMultipleChoiceAnswer2BG: TShape;
    pnlMultipleChoiceAnswer2RemoveBorder: TPanel;
    edtMultipleChoiceAnswer2: TEdit;
    rbtMultipleChoiceAnswer2: TRadioButton;
    pnlMultipleChoiceAnswer3: TPanel;
    shpMultipleChoiceAnswer3BG: TShape;
    pnlMultipleChoiceAnswer3RemoveBorder: TPanel;
    Edit3: TEdit;
    pnlMultipleChoiceAnswer4: TPanel;
    shpMultipleChoiceAnswer4BG: TShape;
    pnlMultipleChoiceAnswer4RemoveBorder: TPanel;
    edtMultipleChoiceAnswer4: TEdit;
    rbtMultipleChoiceAnswer3: TRadioButton;
    rbtMultipleChoiceAnswer4: TRadioButton;
    crdBoolean: TCard;
    lblBooleanAnswerTrue: TLabel;
    lblBooleanAnswerFalse: TLabel;
    pnlButtonCreateCustomQuiz: TPanel;
    shpButtonCreateCustomQuiz: TShape;
    lblCreateCustomQuiz: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtAPIClick(Sender: TObject);
    procedure sbtAIClick(Sender: TObject);
    procedure pnlCreateAiQuizClick(Sender: TObject);
    procedure pnlCreateQuizClick(Sender: TObject);
    procedure shpButtonCreateQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpButtonCreateAiQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure memCustomQuizDescriptionEnter(Sender: TObject);
    procedure memCustomQuizDescriptionExit(Sender: TObject);
    procedure btnCreateQuestionClick(Sender: TObject);
    procedure shpButtonCreateCustomQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function CallApiQuiz(Category: string; AmntQuestions: integer): integer;
    function CallAiQuiz(UserPrompt: string; AmntQuestions: integer; Difficulty: string): integer;
    procedure CustomQuizButtonClick(Sender: TObject);
    function AddCustomQuiz: integer;
  public
    { Public declarations }
  end;

var
  frmCreateQuiz: TfrmCreateQuiz;
  ApiQuizCaller: TApiQuizCaller;
  AiQuizCaller: TAiQuizCaller;
  Question: TQuestion;
  QuestionManager: TCustomQuestionsManager;

implementation

{$R *.dfm}

procedure TfrmCreateQuiz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Self);
  FreeAndNil(QuestionManager);
end;

procedure TfrmCreateQuiz.FormCreate(Sender: TObject);
begin
  Cache := GLOBALS_u.Cache;
  ApiQuizCaller := TApiQuizCaller.Create;
  AiQuizCaller := TAiQuizCaller.Create;

  imgApiSearch1.Picture.LoadFromFile('icons/imgAPISearch.png');
  imgAiCreate1.Picture.LoadFromFile('icons/imgAICreate.png');
  imgCustomQuizHeader1.Picture.LoadFromFile('icons/imgUser.png');

  sbtAPI.Click;
end;

procedure TfrmCreateQuiz.FormShow(Sender: TObject);
var
  Categories: TList<string>;
  Category: string;
begin
  Categories := Cache.GetAllCategoryNames;
  for Category in Categories do
  begin
    cbxApiCategories.Items.Add(Category);
  end;
  cbxAiDifficultySelector.Items.AddStrings(['Very easy', 'Easy', 'Medium', 'Hard', 'Very hard']);

  QuestionManager := TCustomQuestionsManager.Create(pnlCustomQuizCreator, sbxMainScroll);
  QuestionManager.AddQuestion;

  pnlButtonCreateCustomQuiz.OnClick := CustomQuizButtonClick;
  lblCreateCustomQuiz.OnClick := CustomQuizButtonClick;
end;

procedure TfrmCreateQuiz.memCustomQuizDescriptionEnter(Sender: TObject);
begin
  if memCustomQuizDescription.Lines[0] = 'Describe what the quiz is about' then
  begin
    memCustomQuizDescription.Lines.Clear;
    memCustomQuizDescription.Font.Color := clWindowText;
  end;
end;

procedure TfrmCreateQuiz.memCustomQuizDescriptionExit(Sender: TObject);
begin
  if memCustomQuizDescription.Lines[0].Trim = '' then
  begin
    memCustomQuizDescription.Lines.Clear;
    memCustomQuizDescription.Lines[0] := 'Describe what the quiz is about';
    memCustomQuizDescription.Font.Color := clWindowFrame;
  end;
end;

procedure TfrmCreateQuiz.pnlCreateAiQuizClick(Sender: TObject);
var
  CatID: integer;
  QuizID: integer;
begin
  if edtAiCategories.Text = '' then
  begin
    ShowMessage('Please enter a Category(ies)');
    edtAiCategories.SetFocus;
  end
  else
  begin
    CatID := cbxAiDifficultySelector.Items.IndexOf(cbxAiDifficultySelector.Text);
    if CatID = -1 then
    begin
      ShowMessage('No such difficulty as: ' + cbxAiDifficultySelector.Text);
      cbxAiDifficultySelector.Text := 'Difficulty';
      cbxAiDifficultySelector.SelectAll;
    end
    else
    begin
      try
        Screen.Cursor := crHourGlass;
        Self.Enabled := False;
        QuizID := CallAiQuiz(edtAiCategories.Text, speAmntOfAiQuestions.Value, cbxAiDifficultySelector.Text);
        if QuizID = -1 then
          raise Exception.Create('Error creating AI Quiz');
        GLOBALS_u.QuizManager.AddQuiz(QuizID);
        Screen.Cursor := crDefault;
        Self.Enabled := True;
        Self.Close;
        ShowMessage('Quiz Created!');
      except
        Screen.Cursor := crDefault;
        Self.Enabled := True;
        Self.Close;
        ShowMessage('Error Creating AI Quiz.')
      end;
    end;

  end;
end;

procedure TfrmCreateQuiz.pnlCreateQuizClick(Sender: TObject);
var
  CatID: integer;
  QuizID: integer;
begin
  CatID := cbxApiCategories.Items.IndexOf(cbxApiCategories.Text);
  if CatID = -1 then
  begin
    ShowMessage('No such category as: ' + cbxApiCategories.Text);
    cbxApiCategories.Text := 'Categories';
    cbxApiCategories.SelectAll;
  end
  else
  begin
    Screen.Cursor := crHourGlass;
    Self.Enabled := False;
    QuizID := CallApiQuiz(cbxApiCategories.Text, speAmntOfApiQuestions.Value);
    GLOBALS_u.QuizManager.AddQuiz(QuizID);
    Screen.Cursor := crDefault;
    Self.Enabled := True;
    Self.Close;
    ShowMessage('Quiz Created!');
  end
end;

procedure TfrmCreateQuiz.sbtAIClick(Sender: TObject);
begin
  cpnAPI.ActiveCard := crdAiQuizCreator;
end;

procedure TfrmCreateQuiz.sbtAPIClick(Sender: TObject);
begin
  cpnAPI.ActiveCard := crdApiSearch;
end;

procedure TfrmCreateQuiz.shpButtonCreateAiQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlCreateAiQuiz.OnClick(lblCreateAiQuiz);
end;

procedure TfrmCreateQuiz.shpButtonCreateQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlCreateQuiz.OnClick(Sender);
end;

procedure TfrmCreateQuiz.shpButtonCreateCustomQuizMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pnlButtonCreateCustomQuiz.OnClick(Sender);
end;

function TfrmCreateQuiz.CallApiQuiz(Category: string; AmntQuestions: Integer): integer;
var
  CatID: integer;
  Questions: integer;
  Quiz: TList<TQuestion>;
begin
  CatID := GLOBALS_u.Cache.GetCategoryID(Category);
  Questions := AmntQuestions;

  try
    Quiz := ApiQuizCaller.GetQuiz(CatID, Questions);
  finally
    Result := dmDatabase.AddQuiz('API Quiz: ' + Category, 'Testing the API Calling', 'Testing', 'API', 'User', Quiz)
  end;
end;

procedure TfrmCreateQuiz.btnCreateQuestionClick(Sender: TObject);
begin
  QuestionManager.AddQuestion;
end;

function TfrmCreateQuiz.CallAiQuiz(UserPrompt: string; AmntQuestions: Integer; Difficulty: string): Integer;
var
  FullPrompt: string;
  Quiz: TList<TQuestion>;
begin
  FullPrompt := 'Create a quiz on: ' + UserPrompt + ', with ' + IntToStr(AmntQuestions) + ' questions.' + 'Make the quiz difficulty ' + Difficulty + '.';
  try
    Quiz := AiQuizCaller.GetQuiz(FullPrompt);
    Result := dmDatabase.AddQuiz('AI Quiz: ' + UserPrompt, 'Testing the AI quiz creation', 'Testing', 'AI', 'AI', Quiz)
  except
    ShowMessage('Failed to call AI Quiz. Please try again later.');
    Result := -1;
    exit;
  end;
end;

procedure TfrmCreateQuiz.CustomQuizButtonClick(Sender: TObject);
begin
  AddCustomQuiz
end;


function TfrmCreateQuiz.AddCustomQuiz: Integer;
var
  QuizID: Integer;
begin
  Screen.Cursor := crHourGlass;
  Self.Enabled := False;

  try
    QuizID := QuestionManager.TryAddQuiz;

    if QuizID = -1 then
    begin
      Screen.Cursor := crDefault;
      Self.Enabled := True;
      Exit
    end;

    GLOBALS_u.QuizManager.AddQuiz(QuizID);
    ShowMessage('Quiz Created!');
    Result := QuizID;
    Close;
  finally
    Screen.Cursor := crDefault;
    Self.Enabled := True;
  end;
end;

end.
