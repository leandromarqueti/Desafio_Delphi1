object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Simulador de Subida da Minhoca'
  ClientHeight = 280
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblResultado: TLabel
    Left = 20
    Top = 220
    Width = 230
    Height = 13
    Caption = 'Posi'#231'’'#227'o Atual: 0 cm | Quantidade de Subidas: 0'
  end
  object edtProfundidade: TLabeledEdit
    Left = 20
    Top = 30
    Width = 100
    Height = 21
    EditLabel.Width = 127
    EditLabel.Height = 13
    EditLabel.Caption = 'Profundidade do Buraco (cm):'
    TabOrder = 0
  end
  object edtAvanco: TLabeledEdit
    Left = 140
    Top = 30
    Width = 100
    Height = 21
    EditLabel.Width = 83
    EditLabel.Height = 13
    EditLabel.Caption = 'Avan'#231'o por Vez (cm):'
    TabOrder = 1
  end
  object edtQueda: TLabeledEdit
    Left = 260
    Top = 30
    Width = 100
    Height = 21
    EditLabel.Width = 81
    EditLabel.Height = 13
    EditLabel.Caption = 'Queda por Vez (cm):'
    TabOrder = 2
  end
  object btnIniciar: TButton
    Left = 20
    Top = 70
    Width = 340
    Height = 35
    Caption = 'Iniciar Simula'#231''#227'o'
    TabOrder = 3
    OnClick = btnIniciarClick
  end
  object pnlIndicador: TPanel
    Left = 20
    Top = 125
    Width = 340
    Height = 80
    Caption = 'Aguardando In'#237'cio...'
    ParentBackground = False
    TabOrder = 4
  end
end