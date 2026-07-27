program SimuladorMinhoca;

uses
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {frmPrincipal},
  uMinhoca in 'uMinhoca.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.