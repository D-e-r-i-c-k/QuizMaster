program main_p;

uses
  Vcl.Forms,
  home_u in 'home_u.pas' {frmHome},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Blue');
  Application.CreateForm(TfrmHome, frmHome);
  Application.Run;
end.
