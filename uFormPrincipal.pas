unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, 
  uMinhoca;

type
  TfrmPrincipal = class(TForm)
    edtProfundidade: TLabeledEdit;
    edtAvanco: TLabeledEdit;
    edtQueda: TLabeledEdit;
    btnIniciar: TButton;
    pnlIndicador: TPanel;
    lblResultado: TLabel;
    procedure btnIniciarClick(Sender: TObject);
  private
    procedure AtualizarProgressoUI(const PosicaoAtual, TotalSubidas: Integer);
    procedure MudarCorIndicadorUI(const Cor: TColor);
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnIniciarClick(Sender: TObject);
var
  Simulador: TMinhocaSimulador;
  Profundidade, Avanco, Queda: Integer;
begin
  // Validação dos Inputs da Tela
  if not TryStrToInt(edtProfundidade.Text, Profundidade) or
     not TryStrToInt(edtAvanco.Text, Avanco) or
     not TryStrToInt(edtQueda.Text, Queda) then
  begin
    MessageDlg('Por favor, informe valores numéricos inteiros válidos.', mtError, [mbOK], 0);
    Exit;
  end;

  // Reset visual
  pnlIndicador.Color := clBtnFace;
  pnlIndicador.Caption := 'Em andamento...';
  btnIniciar.Enabled := False;

  Simulador := TMinhocaSimulador.Create(Profundidade, Avanco, Queda);
  try
    // Inscrição nos Eventos da Regra de Negócio
    Simulador.OnProgresso := AtualizarProgressoUI;
    Simulador.OnAtingiuMetade := MudarCorIndicadorUI;
    Simulador.OnSaiuDoBuraco := MudarCorIndicadorUI;

    try
      Simulador.ExecutarSimulacaoPassoAPasso(1000); // 1000ms = 1 segundo de pausa na queda
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtWarning, [mbOK], 0);
        pnlIndicador.Caption := 'Erro na Simulação';
      end;
    end;
  finally
    Simulador.Free;
    btnIniciar.Enabled := True;
  end;
end;

procedure TfrmPrincipal.AtualizarProgressoUI(const PosicaoAtual, TotalSubidas: Integer);
begin
  lblResultado.Caption := Format('Posição Atual: %d cm | Quantidade de Subidas: %d', [PosicaoAtual, TotalSubidas]);
  Application.ProcessMessages;
end;

procedure TfrmPrincipal.MudarCorIndicadorUI(const Cor: TColor);
begin
  pnlIndicador.Color := Cor;
  
  if Cor = clYellow then
    pnlIndicador.Caption := 'METADE ALCANÇADA!'
  else if Cor = clGreen then
    pnlIndicador.Caption := 'SAIU DO BURACO!';
    
  Application.ProcessMessages;
end;

end.