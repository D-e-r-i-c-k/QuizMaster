unit frmCreateQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXPanels, Vcl.Menus, Vcl.Samples.Spin, System.Generics.Collections,

  GLOBALS_u, quiz_caller_u, question_u, database_u, quizbox_u, aiCaller_u;

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
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtAPIClick(Sender: TObject);
    procedure sbtAIClick(Sender: TObject);
    procedure pnlCreateAiQuizClick(Sender: TObject);
    procedure pnlCreateQuizClick(Sender: TObject);
    procedure shpButtonCreateQuizMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpButtonCreateAiQuizMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    function CallApiQuiz(Category: string; AmntQuestions: integer): integer;
    function CallAiQuiz(UserPrompt: string; AmntQuestions: integer; Difficulty: string): integer;
  public
    { Public declarations }
  end;

var
  frmCreateQuiz: TfrmCreateQuiz;
  ApiQuizCaller: TQuizCaller;
  AiQuizCaller: TAIQuiz;
  Question: TQuestion;

implementation

{$R *.dfm}

procedure TfrmCreateQuiz.FormCreate(Sender: TObject);
  begin
    Cache := GLOBALS_u.Cache;
    ApiQuizCaller := TQuizCaller.Create;
    AiQuizCaller := TAIQuiz.Create;

    imgApiSearch1.Picture.LoadFromFile('icons/imgAPISearch.png');
    imgAiCreate1.Picture.LoadFromFile('icons/imgAICreate.png');

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
    cbxAiDifficultySelector.Items.AddStrings(['Very easy', 'Easy', 'Medium', 'Hard', 'Very hard'])
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

procedure TfrmCreateQuiz.shpButtonCreateAiQuizMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    pnlCreateAiQuiz.OnClick(lblCreateAiQuiz);
  end;

procedure TfrmCreateQuiz.shpButtonCreateQuizMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    pnlCreateQuiz.OnClick(lblCreateQuiz);
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
      Result := dmDatabase.AddQuiz(
        'API Quiz: ' + Category,
        'Testing the API Calling',
        'Testing',
        'User',
        'Test Quiz',
        Quiz
      )
    end;
  end;

function TfrmCreateQuiz.CallAiQuiz(UserPrompt: string; AmntQuestions: Integer; Difficulty: string): Integer;
var
    FullPrompt: string;
    Quiz: TList<TQuestion>;
  begin
    FullPrompt := 'Create a quiz on: '
                  + UserPrompt
                  + ', with '
                  + IntToStr(AmntQuestions)
                  + ' questions.'
                  + 'Make the quiz difficulty '
                  + Difficulty
                  + '.';
    try
      Quiz := AiQuizCaller.GetQuiz(FullPrompt);
      Result := dmDatabase.AddQuiz(
        'AI Quiz: ' + UserPrompt,
        'Testing the AI quiz creation',
        'Testing',
        'AI',
        'Test Quiz',
        Quiz
      )
    except
      ShowMessage('Failed to call AI Quiz. Please try again later.');
      Result := -1;
      exit;

    end;
  end;
end.
