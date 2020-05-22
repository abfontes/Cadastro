program PCadastro;

uses
  Forms,
  Cadastro in 'Cadastro.pas' {FrmCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCadastro, FrmCadastro);
  Application.Run;
end.
