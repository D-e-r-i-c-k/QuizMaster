program main_p;

uses
  Vcl.Forms,
  frmHome_u in 'frmHome_u.pas' {Home},
  Vcl.Themes,
  Vcl.Styles,
  clsQuizBoxManager_u in 'clsQuizBoxManager_u.pas',
  clsApiQuizCaller_u in 'clsApiQuizCaller_u.pas',
  clsQuestion_u in 'clsQuestion_u.pas',
  dbMain_u in 'dbMain_u.pas' {dmDatabase: TDataModule},
  frmCreateQuiz_u in 'frmCreateQuiz_u.pas' {frmCreateQuiz},
  dbTemp_u in 'dbTemp_u.pas',
  GLOBALS_u in 'GLOBALS_u.pas',
  clsAiQuizCaller_u in 'clsAiQuizCaller_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TfrmCreateQuiz, frmCreateQuiz);
  Application.Run;
end.
