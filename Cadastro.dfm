object FrmCadastro: TFrmCadastro
  Left = 348
  Top = 237
  Caption = 'Cadastro'
  ClientHeight = 583
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LbNome: TLabel
    Left = 16
    Top = 16
    Width = 28
    Height = 13
    Caption = 'Nome'
  end
  object LbIdentidade: TLabel
    Left = 16
    Top = 48
    Width = 50
    Height = 13
    Caption = 'Identidade'
  end
  object LbCPF: TLabel
    Left = 16
    Top = 80
    Width = 20
    Height = 13
    Caption = 'CPF'
  end
  object LbTelefone: TLabel
    Left = 16
    Top = 112
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object LBEmail: TLabel
    Left = 16
    Top = 135
    Width = 25
    Height = 13
    Caption = 'Email'
  end
  object LbCep: TLabel
    Left = 16
    Top = 197
    Width = 19
    Height = 13
    Caption = 'Cep'
  end
  object LbLogra: TLabel
    Left = 16
    Top = 227
    Width = 54
    Height = 13
    Caption = 'Logradouro'
  end
  object LbNum: TLabel
    Left = 16
    Top = 260
    Width = 37
    Height = 13
    Caption = 'Numero'
  end
  object LbComplemento: TLabel
    Left = 153
    Top = 262
    Width = 64
    Height = 13
    Caption = 'Complemento'
  end
  object LbBairro: TLabel
    Left = 16
    Top = 287
    Width = 27
    Height = 13
    Caption = 'Bairro'
  end
  object LbCidade: TLabel
    Left = 16
    Top = 317
    Width = 33
    Height = 13
    Caption = 'Cidade'
  end
  object LbEstado: TLabel
    Left = 223
    Top = 311
    Width = 33
    Height = 13
    Caption = 'Estado'
  end
  object LbPais: TLabel
    Left = 16
    Top = 347
    Width = 20
    Height = 13
    Caption = 'Pais'
  end
  object EdtNome: TEdit
    Left = 89
    Top = 18
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object EdtIdentidade: TEdit
    Left = 88
    Top = 45
    Width = 225
    Height = 21
    TabOrder = 1
  end
  object edtEmail: TEdit
    Left = 88
    Top = 132
    Width = 225
    Height = 21
    TabOrder = 4
  end
  object EdtLogradouro: TEdit
    Left = 89
    Top = 224
    Width = 225
    Height = 21
    TabOrder = 7
  end
  object edtNum: TEdit
    Left = 88
    Top = 257
    Width = 49
    Height = 21
    TabOrder = 8
  end
  object edtComplemento: TEdit
    Left = 223
    Top = 257
    Width = 88
    Height = 21
    TabOrder = 9
  end
  object edtBairro: TEdit
    Left = 90
    Top = 284
    Width = 225
    Height = 21
    TabOrder = 10
  end
  object edtCidade: TEdit
    Left = 88
    Top = 311
    Width = 129
    Height = 21
    TabOrder = 11
  end
  object EdtEstado: TEdit
    Left = 262
    Top = 311
    Width = 52
    Height = 21
    TabOrder = 12
  end
  object EdtPais: TEdit
    Left = 88
    Top = 344
    Width = 225
    Height = 21
    TabOrder = 13
    Text = 'Brasil'
  end
  object BtnEnviar: TButton
    Left = 91
    Top = 389
    Width = 224
    Height = 41
    Caption = 'Enviar'
    TabOrder = 14
    OnClick = BtnEnviarClick
  end
  object edtCep: TMaskEdit
    Left = 88
    Top = 197
    Width = 129
    Height = 21
    EditMask = '00000\-999;1;_'
    MaxLength = 9
    TabOrder = 5
    Text = '     -   '
  end
  object edtCPF: TMaskEdit
    Left = 89
    Top = 78
    Width = 225
    Height = 21
    EditMask = '000\.000\.000\-00;1;_'
    MaxLength = 14
    TabOrder = 2
    Text = '   .   .   -  '
  end
  object edtFone: TMaskEdit
    Left = 88
    Top = 105
    Width = 225
    Height = 21
    EditMask = '!\(99\)90000-0000;1;_'
    MaxLength = 14
    TabOrder = 3
    Text = '(  )     -    '
  end
  object btnBuscaCep: TButton
    Left = 223
    Top = 193
    Width = 91
    Height = 25
    Caption = 'Busca CEP'
    TabOrder = 6
    OnClick = btnBuscaCepClick
  end
  object XMLDocument1: TXMLDocument
    Left = 224
    Top = 463
    DOMVendorDesc = 'MSXML'
  end
  object NMSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 152
    Top = 464
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 152
    Top = 512
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 288
    Top = 464
  end
end
