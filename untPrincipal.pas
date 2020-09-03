unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvRichEdit, untClassMenu, untDM,
  Json, REST.Json;

type
  TfrmPrincipal = class(TForm)
    redtJson: TJvRichEdit;
    btnVai: TButton;
    chkFormatado: TCheckBox;
    procedure btnVaiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnVaiClick(Sender: TObject);
begin
  redtJson.Lines.Text := TMenuSystem.New(DM.conFB).ToJson(chkFormatado.Checked);
end;

end.
