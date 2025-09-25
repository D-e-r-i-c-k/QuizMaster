unit frmCreateQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXPanels, Vcl.Menus, Vcl.Samples.Spin, System.Generics.Collections,

  GLOBALS_u, quiz_caller_u, question_u, database_u, quizbox_u;

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
    cbxAiCategories: TComboBox;
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
    lblApiQuestionCount: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function CallApiQuiz(Category: string; AmntQuestions: integer): integer;
    procedure lblCreateQuizClick(Sender: TObject);
    procedure sbtAPIClick(Sender: TObject);
    procedure sbtAIClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreateQuiz: TfrmCreateQuiz;
  QuizCaller: TQuizCaller;
  Question: TQuestion;

implementation

{$R *.dfm}

procedure TfrmCreateQuiz.FormCreate(Sender: TObject);
  begin
    Cache := GLOBALS_u.Cache;
    QuizCaller := TQuizCaller.Create;

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
  end;

procedure TfrmCreateQuiz.lblCreateQuizClick(Sender: TObject);
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
      end;
      
  end;

procedure TfrmCreateQuiz.sbtAIClick(Sender: TObject);
  begin
    cpnAPI.ActiveCard := crdAiQuizCreator;
  end;

procedure TfrmCreateQuiz.sbtAPIClick(Sender: TObject);
  begin
    cpnAPI.ActiveCard := crdApiSearch;
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
      Quiz := QuizCaller.GetQuiz(CatID, Questions);
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
end.
