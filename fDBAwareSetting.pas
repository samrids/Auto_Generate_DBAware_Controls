unit fDBAwareSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmDBWareSetting = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    UpDownRowCount: TUpDown;
    Chx_UseMultiColumn: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDBWareSetting: TfrmDBWareSetting;

implementation

{$R *.dfm}

end.
