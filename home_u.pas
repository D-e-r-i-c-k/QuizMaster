unit home_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TfrmHome = class(TForm)
    lblTitle: TLabel;
    pnlHeader: TPanel;
    lblSubTitle: TLabel;
    shpStat1: TShape;
    pnlStat1: TPanel;
    lblStat1Num: TLabel;
    lblStat1Text: TLabel;
    imgStat1: TImage;
    pnlStat2: TPanel;
    shpStat2: TShape;
    lblStat2Num: TLabel;
    lblStat2Text: TLabel;
    imgStat2: TImage;
    pnlStat3: TPanel;
    shpStat3: TShape;
    lblStat3Num: TLabel;
    lblStat3Text: TLabel;
    imgStat3: TImage;
    pnlStat4: TPanel;
    shpStat4: TShape;
    lblStat4Num: TLabel;
    lblStat4Text: TLabel;
    imgStat4: TImage;
    pnlDailyQuiz: TPanel;
    shpDailyQuiz: TShape;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.dfm}


procedure TfrmHome.FormCreate(Sender: TObject);
begin
  imgStat1.Picture.LoadFromFile('icons/imgStat1.png');
  imgStat2.Picture.LoadFromFile('icons/imgStat2.png');
  imgStat3.Picture.LoadFromFile('icons/imgStat3.png');
  imgStat4.Picture.LoadFromFile('icons/imgStat4.png');
end;

end.


