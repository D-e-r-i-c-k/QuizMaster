// dbTemp_u.pas
// Purpose: Temporary database helper module used for intermediate storage
// or transient operations during QuizMaster runtime. Documentation-only
// edits were made; no code logic was changed.

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
  // CacheAllCategories
  // Purpose: Populate an in-memory table (FtblQuizCategories) with all
  // category IDs and names fetched from the external API. This avoids
  // calling the remote API repeatedly during the app lifecycle.
  // Notes:
  // - QuizCaller.GetAllCategoriesNames/GetAllCategoriesIDs are called
  //   and their returned lists are expected to be the same length and
  //   correspond by index.
  // - FtblQuizCategories is appended to; callers should call InitCategories
  //   if reinitialization is desirable.
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
  // GetAllCategoryNames
  // Purpose: Return an owned TList<string> of all category names stored
  // in the in-memory table. Caller must free the returned list.
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
  // GetAllCategoryIDs
  // Purpose: Return an owned TList<integer> of all category IDs stored
  // in the in-memory table. Caller must free the returned list.
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
  // GetCategoryID
  // Purpose: Lookup the CategoryID for a given CategoryName in the
  // in-memory table. Returns -1 if not found.
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
