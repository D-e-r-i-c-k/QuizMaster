unit frmCreateQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXPanels, Vcl.Menus, Vcl.Samples.Spin, System.Generics.Collections,

  GLOBALS_u, clsAiQuizCaller_u, clsQuestion_u, dbMain_u, clsQuizBoxManager_u, clsApiQuizCaller_u;

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
    Panel1: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Question: TLabel;
    Panel2: TPanel;
    Shape2: TShape;
    Panel3: TPanel;
    Panel4: TPanel;
    Shape3: TShape;
    Panel5: TPanel;
    Panel6: TPanel;
    Shape4: TShape;
    Panel7: TPanel;
    Memo1: TMemo;
    lblCustomQuestions: TLabel;
    Answer: TLabel;
    Panel8: TPanel;
    Shape5: TShape;
    Panel9: TPanel;
    Memo2: TMemo;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    Panel10: TPanel;
    Shape6: TShape;
    Shape7: TShape;
    Image1: TImage;
    Image2: TImage;
    Panel11: TPanel;
    Shape8: TShape;
    Panel12: TPanel;
    Memo3: TMemo;
    Label1: TLabel;
    Label5: TLabel;
    RadioButton1: TRadioButton;
    Panel13: TPanel;
    Shape9: TShape;
    Panel14: TPanel;
    Edit1: TEdit;
    Panel15: TPanel;
    Shape10: TShape;
    Panel16: TPanel;
    Edit2: TEdit;
    RadioButton2: TRadioButton;
    Panel17: TPanel;
    Shape11: TShape;
    Panel18: TPanel;
    Edit3: TEdit;
    Panel19: TPanel;
    Shape12: TShape;
    Panel20: TPanel;
    Edit4: TEdit;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Card3: TCard;
    Label6: TLabel;
    Label7: TLabel;
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
    procedure memCustomQuizDescriptionEnter(Sender: TObject);
    procedure memCustomQuizDescriptionExit(Sender: TObject);
  private
    { Private declarations }
    function CallApiQuiz(Category: string; AmntQuestions: integer): integer;
    function CallAiQuiz(UserPrompt: string; AmntQuestions: integer; Difficulty: string): integer;
  public
    { Public declarations }
  end;

var
  frmCreateQuiz: TfrmCreateQuiz;
  ApiQuizCaller: TApiQuizCaller;
  AiQuizCaller: TAiQuizCaller;
  Question: TQuestion;

implementation

{$R *.dfm}

procedure TfrmCreateQuiz.FormCreate(Sender: TObject);
  begin
    Cache := GLOBALS_u.Cache;
    ApiQuizCaller := TApiQuizCaller.Create;
    AiQuizCaller := TAiQuizCaller.Create;

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
