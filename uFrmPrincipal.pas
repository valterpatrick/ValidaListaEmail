unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.RegularExpressions;

type
  TFrmPrincipal = class(TForm)
    MemoEmails: TMemo;
    Label1: TLabel;
    MemoEmailsValidos: TMemo;
    MemoEmailsInvalidos: TMemo;
    BtnValidar: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    procedure BtnValidarClick(Sender: TObject);
  private
    function IsValidEmail(const Email: string): Boolean;
  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}


procedure TFrmPrincipal.BtnValidarClick(Sender: TObject);
var
  I: Integer;
begin
  if MemoEmails.Lines.Count = 0 then
    raise Exception.Create('A lista de email está vazia.');

  MemoEmailsValidos.Lines.Clear;
  MemoEmailsInvalidos.Lines.Clear;
  for I := 0 to MemoEmails.Lines.Count - 1 do
  begin
    if MemoEmails.Lines[I].Trim <> '' then
    begin
      if IsValidEmail(MemoEmails.Lines[I].Trim) then
        MemoEmailsValidos.Lines.Add(MemoEmails.Lines[I].Trim)
      else
        MemoEmailsInvalidos.Lines.Add(MemoEmails.Lines[I].Trim);
    end;
  end;

  if (MemoEmailsValidos.Lines.Count + MemoEmailsInvalidos.Lines.Count) = 0 then
    raise Exception.Create('A lista de email está vazia.');
  Application.MessageBox(PWideChar('Foram validados ' + (MemoEmailsValidos.Lines.Count + MemoEmailsInvalidos.Lines.Count).ToString +
    ' emails, sendo ' + MemoEmailsValidos.Lines.Count.ToString + ' válidos e ' + MemoEmailsInvalidos.Lines.Count.ToString +
    ' inválidos.'), 'Informação', MB_ICONINFORMATION + MB_OK);
end;

function TFrmPrincipal.IsValidEmail(const Email: string): Boolean;
const
  // Função desenvolvida com a ajuda do ChatGPT 4 Turbo
  EmailRegexPattern: string = '^(?!.*\.\.)(?!.*\.$)(?!^\.)[a-zA-Z0-9._-]+(?<=[a-zA-Z0-9])@(?!-)(?!.*--)[a-zA-Z0-9.-]+(?<!-)\.[a-zA-Z]{2,}$';
begin
  Result := TRegEx.IsMatch(Email, EmailRegexPattern);
end;

end.
