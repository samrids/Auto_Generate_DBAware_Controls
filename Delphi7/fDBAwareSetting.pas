unit fDBAwareSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmDBWareSetting = class(TForm)
    Label1: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    UpDownRowCount: TUpDown;
    Chx_UseMultiColumn: TCheckBox;
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
