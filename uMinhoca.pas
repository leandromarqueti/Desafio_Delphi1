unit uMinhoca;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, Vcl.Graphics;

type
  // Eventos para notificar a UI de forma desvinculada
  TOnProgressoEvent = procedure(const PosicaoAtual, TotalSubidas: Integer) of object;
  TOnEstadoCoresEvent = procedure(const Cor: TColor) of object;

  TMinhocaSimulador = class
  private
    FProfundidadeTotal: Integer;
    FAvancoPorVez: Integer;
    FQuedaPorVez: Integer;
    FPosicaoAtual: Integer;
    FQtdSubidas: Integer;

    FOnProgresso: TOnProgressoEvent;
    FOnAtingiuMetade: TOnEstadoCoresEvent;
    FOnSaiuDoBuraco: TOnEstadoCoresEvent;

    procedure ValidarParametros;
  public
    constructor Create(aProfundidade, aAvanco, aQueda: Integer);
    procedure ExecutarSimulacaoPassoAPasso(aDelayQuedaMs: Integer = 1000);

    property OnProgresso: TOnProgressoEvent read FOnProgresso write FOnProgresso;
    property OnAtingiuMetade: TOnEstadoCoresEvent read FOnAtingiuMetade write FOnAtingiuMetade;
    property OnSaiuDoBuraco: TOnEstadoCoresEvent read FOnSaiuDoBuraco write FOnSaiuDoBuraco;
  end;

implementation

uses
  Vcl.Forms;

constructor TMinhocaSimulador.Create(aProfundidade, aAvanco, aQueda: Integer);
begin
  inherited Create;
  FProfundidadeTotal := aProfundidade;
  FAvancoPorVez := aAvanco;
  FQuedaPorVez := aQueda;
  FPosicaoAtual := 0;
  FQtdSubidas := 0;
end;

procedure TMinhocaSimulador.ValidarParametros;
begin
  if FProfundidadeTotal <= 0 then
    raise Exception.Create('A profundidade deve ser maior que zero.');
    
  if FAvancoPorVez <= 0 then
    raise Exception.Create('O avanço por vez deve ser maior que zero.');
    
  if (FAvancoPorVez <= FQuedaPorVez) and (FAvancoPorVez < FProfundidadeTotal) then
    raise Exception.Create('A minhoca nunca sairá do buraco pois a queda é maior ou igual ao avanço!');
end;

procedure TMinhocaSimulador.ExecutarSimulacaoPassoAPasso(aDelayQuedaMs: Integer);
var
  MetadeCaminho: Double;
  AtingiuMetadeNotificado: Boolean;
begin
  ValidarParametros;

  FPosicaoAtual := 0;
  FQtdSubidas := 0;
  MetadeCaminho := FProfundidadeTotal / 2.0;
  AtingiuMetadeNotificado := False;

  while FPosicaoAtual < FProfundidadeTotal do
  begin
    // 1. Minhoca sobe
    Inc(FQtdSubidas);
    Inc(FPosicaoAtual, FAvancoPorVez);

    // Notifica progresso para a UI
    if Assigned(FOnProgresso) then
      FOnProgresso(FPosicaoAtual, FQtdSubidas);

    // Verifica se atingiu a metade do caminho
    if (FPosicaoAtual >= MetadeCaminho) and not AtingiuMetadeNotificado then
    begin
      AtingiuMetadeNotificado := True;
      if Assigned(FOnAtingiuMetade) then
        FOnAtingiuMetade(clYellow);
    end;

    // 2. Verifica se já saiu do buraco após o avanço
    if FPosicaoAtual >= FProfundidadeTotal then
      Break;

    // 3. Minhoca cai e faz a pausa de 1 segundo (conforme regra do problema)
    Dec(FPosicaoAtual, FQuedaPorVez);

    // Garante que não fique abaixo de 0
    if FPosicaoAtual < 0 then
      FPosicaoAtual := 0;

    // Notifica progresso após a queda
    if Assigned(FOnProgresso) then
      FOnProgresso(FPosicaoAtual, FQtdSubidas);

    // Pausa exigida na regra quando ela cai (mantendo a UI responsiva)
    Sleep(aDelayQuedaMs);
    Application.ProcessMessages;
  end;

  // Notifica conclusão (Quadro Verde)
  if Assigned(FOnSaiuDoBuraco) then
    FOnSaiuDoBuraco(clGreen);
end;

end.