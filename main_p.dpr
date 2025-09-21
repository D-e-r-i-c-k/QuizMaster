program main_p;

uses
  Vcl.Forms,
  home_u in 'home_u.pas' {frmHome},
  Vcl.Themes,
  Vcl.Styles,
  quizbox_u in 'quizbox_u.pas',
  quiz_caller_u in 'quiz_caller_u.pas',
  question_u in 'question_u.pas',
  database_u in 'database_u.pas' {dmDatabase: TDataModule},
  frmCreateQuiz_u in 'frmCreateQuiz_u.pas' {frmCreateQuiz},
  dmTempDB in 'dmTempDB.pas',
  dbTemp_u in 'dbTemp_u.pas',
  GLOBALS_u in 'GLOBALS_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmCreateQuiz, frmCreateQuiz);
  Application.Run;
end.
