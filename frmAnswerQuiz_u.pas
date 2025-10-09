unit frmAnswerQuiz_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.WinXPanels, Vcl.ExtCtrls;

type
  TfrmAnswerQuiz = class(TForm)
    lblAnswerQuizTile: TLabel;
    pbAnswerProgress: TProgressBar;
    pnlQuestion: TPanel;
    shpQuestionBG: TShape;
    cplQuestionTypeOptions: TCardPanel;
    crdTextAnswer1: TCard;
    lblTextAnswerAnswer: TLabel;
    lblTextAnswerQuestion: TLabel;
    pnlTextAnswerQuestionInput: TPanel;
    shpTextAnswerQuestionBG: TShape;
    pnlTextAnswerQuestionInputRemoveBorder: TPanel;
    memTextAnswerQuestionInput: TMemo;
    pnlTextAnswerAnswerInput: TPanel;
    shpTextAnswerAnswerInputBG: TShape;
    pnlTextAnswerAnswerInputRemoveBorder: TPanel;
    memTextAnswerAnswer: TMemo;
    crdMultipleChoice1: TCard;
    lblMultipleChoiceQuestion: TLabel;
    lblMultipleChoiceAnswer: TLabel;
    pnlMultipleChoiceQuestionInput: TPanel;
    shpMultipleChoiceQuestionInputBG: TShape;
    pnlMultipleChoiceQuestionInputRemoveBorder: TPanel;
    memMultipleChoiceQuestionInput: TMemo;
    rbtMultipleChoiceAnswer1: TRadioButton;
    pnlMultipleChoiceAnswer1: TPanel;
    shpMultipleChoiceAnswer1BG: TShape;
    pnlMultipleChoiceAnswer1RemoveBorder: TPanel;
    edtMultipleChoiceAnswer1: TEdit;
    rbtMultipleChoiceAnswer2: TRadioButton;
    pnlMultipleChoiceAnswer2: TPanel;
    shpMultipleChoiceAnswer2BG: TShape;
    pnlMultipleChoiceAnswer2RemoveBorder: TPanel;
    edtMultipleChoiceAnswer2: TEdit;
    rbtMultipleChoiceAnswer3: TRadioButton;
    rbtMultipleChoiceAnswer4: TRadioButton;
    pnlMultipleChoiceAnswer4: TPanel;
    shpMultipleChoiceAnswer4BG: TShape;
    pnlMultipleChoiceAnswer4RemoveBorder: TPanel;
    edtMultipleChoiceAnswer4: TEdit;
    pnlMultipleChoiceAnswer3: TPanel;
    shpMultipleChoiceAnswer3BG: TShape;
    pnlMultipleChoiceAnswer3RemoveBorder: TPanel;
    edt: TEdit;
    crdBoolean1: TCard;
    lblBooleanQuestion: TLabel;
    lblBooleanAnswer: TLabel;
    lblBooleanAnswerTrue: TLabel;
    lblBooleanAnswerFalse: TLabel;
    pnlBooleanQuestionInput: TPanel;
    shpBooleanQuesionInputBG: TShape;
    pnlBooleanQuesionInputRemoveBorder: TPanel;
    memBooleanQuestionInput: TMemo;
    rbtBooleanAnswerTrue: TRadioButton;
    rbtBooleanFalse1: TRadioButton;
    cplQuestions: TCardPanel;
    crdQuestion1: TCard;
    lblQuestionNumber: TLabel;
    lblQuestionText: TLabel;
    pnlAnswer: TPanel;
    shpTextAnswerBG: TShape;
    cplAnswerType: TCardPanel;
    crdTextAnswer: TCard;
    pnlTextAnswer: TPanel;
    pnlTextAnswerRemoveBorder: TPanel;
    memTextAnswer: TMemo;
    crdBoolean: TCard;
    lblFalse: TLabel;
    lblTrue: TLabel;
    rbtBooleanTrue: TRadioButton;
    rbtBooleanFalse: TRadioButton;
    shpBooleanAnswerBG: TShape;
    crdMultipleChoice: TCard;
    rbtMultipleChoice1: TRadioButton;
    rbtMultipleChoice2: TRadioButton;
    rbtMultipleChoice3: TRadioButton;
    rbtMultipleChoice4: TRadioButton;
    lblMultipleChoiceAnswer1: TLabel;
    lblMultipleChoiceAnswer2: TLabel;
    lblMultipleChoiceAnswer3: TLabel;
    lblMultipleChoiceAnswer4: TLabel;
    pnlNextQuestion: TPanel;
    shpNextQuestionBG: TShape;
    lblNextQuestion: TLabel;
    pnlPrevQuestion: TPanel;
    shpPrevQuestionBG: TShape;
    lblPrevQuestion: TLabel;
    pnlQuestionDifficulty: TPanel;
    shpQuestionDifficultyBG: TShape;
    lblQuestionDifficulty: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnswerQuiz: TfrmAnswerQuiz;

implementation

{$R *.dfm}

end.
