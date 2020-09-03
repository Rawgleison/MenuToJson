{***********************************************************************
*
*   TI Gestor - Novo Sistema
*   Criador: Raul Amaral
*   Data   : 02/09/2020
*   Resumo : Classe para gerar o Json para a montagem do menu lateral
*   Exemplo de Uso: memo.Lines.Text := TMenuSystem.New(DM.conFB).ToJson;
***********************************************************************}
unit untClassMenu;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Json, Rest.Json;

type
  IMenuSystem = interface
  ['{815108DB-A4B8-4BA8-8BD6-0269DBE5D61F}']
    function MenuToObjectJson(pId: Integer): TJSONArray;
    function ToJson(pFormated: Boolean = False): string;
  end;

  TMenuSystem = class(TInterfacedObject, IMenuSystem)
  private
    FCon: TFDConnection;
    function FormatJson(Json: String): String;
  public
    constructor Create(Connection: TFDConnection);
    destructor Destroy;
    function ToJson(pFormated: Boolean = False): String;
    function MenuToObjectJson(pId: Integer): TJSONArray;
    class function New(Conn: TFDConnection): IMenuSystem;
  end;

implementation

{ TMenuSystem }

constructor TMenuSystem.Create(Connection: TFDConnection);
begin
  FCon := Connection;
end;

destructor TMenuSystem.Destroy;
begin
  FreeAndNil(FCon);
end;

function TMenuSystem.FormatJson(Json: String): String;
var
  tmpJson: TJsonObject;
  Res: TStringList;
  I: Integer;
begin
  Res := TStringList.Create;
  try
    tmpJson := TJSONObject.ParseJSONValue(Json) as TJsonObject;
    Res.Text := StringReplace(TJson.Format(tmpJson),'}'#13#10',','},',[rfReplaceAll]);
    for I := Res.count - 1 downto 0 do
    begin
      if Trim(Res[I]) = '' then
        Res.Delete(I);
    end;
    Result := Res.Text;
  finally
    Res.Free;
    FreeAndNil(tmpJson);
  end;
end;

function TMenuSystem.MenuToObjectJson(pId: Integer): TJSONArray;
var
  vQr: TFDQuery;
  vWhere: String;
  vItem: TJsonObject;
  vArr: TJsonArray;
begin
  vArr := TJSONArray.Create;
  vQr := TFDQuery.Create(nil);
  try
    vQr.Connection := FCon;

    //Trato se vou retornar um array principal ou um children
    if pId > 0 then
      vWhere := 'WHERE ID_ROTA_PARENT = '+pId.ToString
    else
      vWhere := 'WHERE ID_ROTA_PARENT IS NULL';

    vQr.Open('SELECT * FROM ROTAS '+vWhere);

    while not vQr.Eof do
    begin
      vItem := TJsonObject.Create;
      vItem.AddPair('id',vQr.FieldByName('id_rota').AsString);
      vItem.AddPair('name',vQr.FieldByName('nome').AsString);
      vItem.AddPair('children',TJsonObject(MenuToObjectJson(vQr.FieldByName('id_rota').AsInteger)));
      if vItem.GetValue('children').ToJSON = '[]' then
        vItem.RemovePair('children').Free;
      vArr.AddElement(vItem);
      vQr.Next;
    end;
    Result := vArr;
  finally
    vQr.Free;
  end;
end;

class function TMenuSystem.New(Conn: TFDConnection): IMenuSystem;
begin
  Result := Self.Create(Conn);
end;

function TMenuSystem.ToJson(pFormated: Boolean = False): String;
var
  vJsonObj: TJsonObject;
begin
  vJsonObj := TJsonObject.Create;
  try
     vJsonObj.AddPair('Items',TJsonObject(MenuToObjectJson(0)));
     if pFormated then
       Result := FormatJson(vJsonObj.ToJSON)
     else
       Result := vJsonObj.ToJSON;
  finally
    vJsonObj.Free;
  end;
end;

end.
