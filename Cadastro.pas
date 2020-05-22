unit Cadastro;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, msxmldom, XMLDoc, Buttons,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,  Mask, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdMessage, IdAttachment,
  IdAttachmentFile;

  type

  TFrmCadastro = class(TForm)
    EdtNome: TEdit;
    LbNome: TLabel;
    LbIdentidade: TLabel;
    EdtIdentidade: TEdit;
    LbCPF: TLabel;
    LbTelefone: TLabel;
    LBEmail: TLabel;
    edtEmail: TEdit;
    LbCep: TLabel;
    LbLogra: TLabel;
    EdtLogradouro: TEdit;
    LbNum: TLabel;
    edtNum: TEdit;
    LbComplemento: TLabel;
    edtComplemento: TEdit;
    LbBairro: TLabel;
    edtBairro: TEdit;
    LbCidade: TLabel;
    edtCidade: TEdit;
    LbEstado: TLabel;
    EdtEstado: TEdit;
    LbPais: TLabel;
    EdtPais: TEdit;
    BtnEnviar: TButton;
    edtCep: TMaskEdit;
    XMLDocument1: TXMLDocument;
    edtCPF: TMaskEdit;
    edtFone: TMaskEdit;
    btnBuscaCep: TButton;
    NMSMTP1: TIdSMTP;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    procedure btnBuscaCepClick(Sender: TObject);
    procedure BtnEnviarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

{$R *.dfm}

procedure TFrmCadastro.BtnEnviarClick(Sender: TObject);
var
  strX : string;
  XMLDocument: TXMLDocument;
  NodeTabela, NodeRegistro: IXMLNode;

begin

  //Gerando o arquivo XML
  XMLDocument := TXMLDocument.Create(Self);
  try
    XMLDocument.Active := True;
    NodeTabela := XMLDocument.AddChild('Pessoa');
      NodeRegistro := NodeTabela.AddChild('Registro');
      NodeRegistro.ChildValues['Nome'] := edtNome.Text;
      NodeRegistro.ChildValues['Identidade'] := edtIdentidade.Text;
      NodeRegistro.ChildValues['CPF'] := edtCPF.Text;
      NodeRegistro.ChildValues['Telefone'] := edtFone.Text;
      NodeRegistro.ChildValues['Email'] := edtEmail.Text;
      NodeRegistro.ChildValues['CEP'] := edtCEP.Text;
      NodeRegistro.ChildValues['Logradouro'] := edtLogradouro.Text;
      NodeRegistro.ChildValues['Numero'] := edtNum.Text;
      NodeRegistro.ChildValues['Complemento'] := edtComplemento.Text;
      NodeRegistro.ChildValues['Bairro'] := edtBairro.Text;
      NodeRegistro.ChildValues['Cidade'] := edtCidade.Text;
      NodeRegistro.ChildValues['Estado'] := edtEstado.Text;
      NodeRegistro.ChildValues['Pais'] := edtPais.Text;
      XMLDocument.SaveToFile('Cadastro.xml');
  finally
    XMLDocument.Free;
  end;

  //** configura SMTP **
  if IdSMTP.Connected then
      try
        IdSMTP.Disconnect;
      except
  end;

  //Prepara a Mensagem
  IdMessage := TIdMessage.Create(Self);
  IdMessage.From.Name :='Ariane Bonelli';
  IdMessage.From.Address :='ariane@task.com.br';
  IdMessage.Priority := mpNormal;
  IdMessage.Subject := 'Cadastro concluído';
  IdMessage.Date := Now;

  //Adiciona Destinatário
  IdMessage.Recipients.Add;
  strX := '';
  InputQuery('Informe o e-mail de destino:','E-mail:', strX);
  IdMessage.Recipients.EMailAddresses :=strX;


  //Cria o corpo da mensagem
  IdMessage.Body.Clear;
  IdMessage.Body.Add('Prezado Gustavo,');
  IdMessage.Body.Add('');
  IdMessage.Body.Add('Em anexo o casdastro concluído.');
  IdMessage.Body.Add('Nome: '+edtNome.Text);
  IdMessage.Body.Add('Identidade: '+edtIdentidade.Text);
  IdMessage.Body.Add('CPF: '+edtCPF.Text);
  IdMessage.Body.Add('Telefone: '+edtFone.Text);
  IdMessage.Body.Add('E-mail: '+edtEmail.Text);
  IdMessage.Body.Add('Endereço:'+edtNome.Text);
  IdMessage.Body.Add('Logradouro: '+edtLogradouro.Text+','+edtNum.text);
  IdMessage.Body.Add('Complemento: '+edtComplemento.Text);
  IdMessage.Body.Add('Bairro: '+edtBairro.Text);
  IdMessage.Body.Add('Cidade: '+edtCidade.Text+' '+edtEstado.Text);
  IdMessage.Body.Add('País: '+edtPais.Text);
  IdMessage.Body.Add('Atenciosamente,');
  IdMessage.Body.Add('Ariane Bonelli');

  //Anexa o arquivo
  IdMessage.MessageParts.Clear;
  TIdAttachmentFile.Create (IdMessage.MessageParts, TFileName('Cadastro.xml'));


  //Prepara o Servidor
  IdSMTP := TIdSMTP.Create(Self);
  IdSMTP.Host :='smtp.task.com.br';
  IdSMTP.Port :=587;
  IdSMTP.Username := 'ariane@task.com.br';
  IdSMTP.Password :='Mamae70anos';
  IdSMTP.Connect; //Estabelece a conexão
  IdSMTP.Authenticate; //Faz a autenticação

  // se a conexao foi bem sucedida, envia a mensagem
  if IdSMTP.Connected then
   begin
      IdSMTP.Send(IdMessage);
      Application.MessageBox('Email enviado com sucesso!', 'Confirmação',MB_ICONINFORMATION +   MB_OK);
   end;
   // Desconecta do servidor SMTP
   if IdSMTP.Connected then
      IdSMTP.Disconnect;
end;

procedure TFrmCadastro.btnBuscaCepClick(Sender: TObject);
var
  RESTClient: TRESTClient;
  RESTResponse: TRESTResponse;
  RESTRequest: TRESTRequest;
  RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  FDMemTable1: TFDMemTable;

begin
  if ((edtCep.Text = '     -   ') or (length(edtCep.Text) <8)) then   // Se o CEP não está preenchido
  begin
    showMessage('Informe o CEP.')
  end
  else begin
    RESTClient := TRESTClient.Create(nil);
    RESTClient.BaseURL := 'http://viacep.com.br/ws/' + edtCep.text + '/json';
    RESTClient.FallbackCharsetEncoding := 'UTF-8';
    RESTClient.HandleRedirects := True;

    RESTResponse := TRESTResponse.Create(nil);

    RESTRequest := TRESTRequest.Create(nil);
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;

    FDMemTable1 := TFDMemTable.Create(nil);

    RESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);
    RESTResponseDataSetAdapter.DataSet := FDMemTable1;
    RESTResponseDataSetAdapter.Response := RESTResponse;
    RESTResponseDataSetAdapter.Active := True;


    RESTRequest.Execute;

    if (RESTResponse.StatusCode = 200) and (pos('erro',RESTResponse.Content)=0)then
    begin
      edtLogradouro.text := FDMemTable1.FieldByName('logradouro').AsString;
      EdtCidade.text := FDMemTable1.FieldByName('localidade').AsString;
      EdtBairro.text := FDMemTable1.FieldByName('bairro').AsString;
      EdtEstado.text := FDMemTable1.FieldByName('uf').AsString;
    end else showMessage('Cep não cadastrado.');

    //Libera componentes
    RESTClient.Free;
    RESTResponse.Free;
    RESTRequest.Free;
    RESTResponseDataSetAdapter.Free;
    FDMemTable1.Free;
  end; //do if
end;


end.
