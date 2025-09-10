program main_p;

uses
  Vcl.Forms,
  home_u in 'home_u.pas' {frmHome},
  Vcl.Themes,
  Vcl.Styles,
  quizbox_u in 'quizbox_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHome, frmHome);
  Application.Run;
end.
