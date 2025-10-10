unit dbTemp_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, System.JSON,
  System.Generics.Collections, Vcl.Dialogs, clsApiQuizCaller_u;

type
  TdmCache = class
  private
    FtblQuizCategories: TFDMemTable;
  public
    constructor Create;
    destructor Destroy; override;

    function GetAllCategoryNames: TList<string>;
    function GetAllCategoryIDs: TList<integer>;
    function GetCategoryID(Category: string): integer;

    procedure CacheAllCategories;
    procedure InitCategories;
  end;

var
  QuizCaller: TApiQuizCaller;

implementation

constructor TdmCache.Create;
begin
  FtblQuizCategories := TFDMemTable.Create(nil);
  InitCategories;
end;

destructor TdmCache.Destroy;
begin
  FtblQuizCategories.Free;
  inherited;
end;

procedure TdmCache.InitCategories;
begin
  FtblQuizCategories.Close;
  FtblQuizCategories.FieldDefs.Clear;
  FtblQuizCategories.FieldDefs.Add('CategoryID', ftInteger);
  FtblQuizCategories.FieldDefs.Add('CategoryName', ftString, 255);
  FtblQuizCategories.CreateDataSet;
end;

procedure TdmCache.CacheAllCategories;
var
  IDList: TList<integer>;
  NameList: TList<string>;
  n: integer;
begin
  QuizCaller := TApiQuizCaller.Create;

  NameList := QuizCaller.GetAllCategoriesNames;
  IDList := QuizCaller.GetAllCategoriesIDs;

  for n := 0 to IDList.Count - 1 do
  begin
    FtblQuizCategories.Append;
    FtblQuizCategories.FieldByName('CategoryID').AsInteger := IDList[n];
    FtblQuizCategories.FieldByName('CategoryName').AsString := NameList[n];
    FtblQuizCategories.Post;
  end;
end;

function TdmCache.GetAllCategoryNames: TList<string>;
var
  NamesList: TList<string>;
begin
  NamesList := TList<string>.Create;
  FtblQuizCategories.First;
  while not FtblQuizCategories.Eof do
  begin
    NamesList.Add(FtblQuizCategories['CategoryName']);
    FtblQuizCategories.Next;
  end;
  Result := NamesList;
end;

function TdmCache.GetAllCategoryIDs: TList<integer>;
var
  IDList: TList<integer>;
begin
  IDList := TList<integer>.Create;
  FtblQuizCategories.First;
  while not FtblQuizCategories.Eof do
  begin
    IDList.Add(FtblQuizCategories['CategoryID']);
    FtblQuizCategories.Next;
  end;
  Result := IDList;
end;

function TdmCache.GetCategoryID(Category: string): integer;
begin
  FtblQuizCategories.First;
  while not FtblQuizCategories.Eof do
  begin
    if FtblQuizCategories['CategoryName'] = Category then
    begin
      Result := FtblQuizCategories['CategoryID'];
      exit
    end
    else
    begin
      FtblQuizCategories.Next
    end;
  end;
  Result := -1;
end;

end.

