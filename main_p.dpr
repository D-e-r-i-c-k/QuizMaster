program main_p;

uses
  Vcl.Forms,
  home_u in 'home_u.pas' {frmHome},
  Vcl.Themes,
  Vcl.Styles,
  quizbox_u in 'quizbox_u.pas',
  api_caller_u in 'api_caller_u.pas',
  question_u in 'question_u.pas',
  database_u in 'database_u.pas' {dmDatabase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.Run;
end.
