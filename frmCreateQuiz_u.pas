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
    pnlCreateTypeSelector: TPanel;
    sbtAPI: TSpeedButton;
    sbtAI: TSpeedButton;
    shpOnlineCreateBG: TShape;
    cpnAPI: TCardPanel;
    pnlApiSearch: TPanel;
    crdApiSearch: TCard;
    lblApiSearchTitle: TLabel;
    imgApiSearch1: TImage;
    lblApiSearchSubTitle: TLabel;
    pnlApiCategories: TPanel;
    pnlCreateQuiz: TPanel;
    shpButtonCreateQuiz: TShape;
    lblCreateQuiz: TLabel;
    cbxApiCategories: TComboBox;
    shpMyQuizzesSearch: TShape;
    pnlACRemoveBorder: TPanel;
    lblApiCategory: TLabel;
    pnlAmntOfApiQuestions: TPanel;
    Shape1: TShape;
    pnlAOACRemoveBorder: TPanel;
    speAmntOfApiQuestions: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function CallApiQuiz(Category: string; AmntQuestions: integer): integer;
    procedure lblCreateQuizClick(Sender: TObject);
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

uses home_u;


procedure TfrmCreateQuiz.FormCreate(Sender: TObject);
  begin
    Cache := GLOBALS_u.Cache;
    QuizCaller := TQuizCaller.Create;
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
        QuizID := CallApiQuiz(cbxApiCategories.Text, speAmntOfApiQuestions.Value);
        GLOBALS_u.QuizManager.AddQuiz(QuizID);
        Self.Close;
        ShowMessage('Quiz Created!')
      end;
      
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
