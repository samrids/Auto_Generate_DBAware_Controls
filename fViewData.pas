unit fViewData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCalendar, cxDBEdit, cxMaskEdit,
  cxDropDownEdit, cxCalc, cxTextEdit, Vcl.StdCtrls, Vcl.ExtCtrls,
  IOUtils,
  System.UITypes,
  System.Actions, Vcl.ActnList, MemDS, DBAccess, Uni, Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxProgressBar, cxDBProgressBar,
  cxLabel,
  cxScrollBox, cxMemo;

type
  TfrmViewData = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button2: TButton;
    ActionList1: TActionList;
    SaveAction: TAction;
    DeleteAction: TAction;
    cxScrollBox1: TcxScrollBox;
    Button1: TButton;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMultipleColumn: Boolean;
    FRowCount: Word;
    procedure SaveConfig;
    procedure RestoreConfig;
  public
    { Public declarations }
    procedure GenDBAwareControl(Query: TDataset);

    property MultipleColumn: Boolean read FMultipleColumn write FMultipleColumn
      default True;
    property RowCount: Word read FRowCount write FRowCount default 5;

  end;

var
  frmViewData: TfrmViewData;

implementation

{$R *.dfm}
{ TfrmEditData }

uses IniFiles, fDBAwareSetting;

procedure TfrmViewData.Button1Click(Sender: TObject);
begin
  frmDBWareSetting := TfrmDBWareSetting.Create(Self);
  Self.RestoreConfig;
  frmDBWareSetting.Chx_UseMultiColumn.Checked := FMultipleColumn;
  frmDBWareSetting.UpDownRowCount.Position    := FRowCount;
  if frmDBWareSetting.Showmodal = mrOk then
  begin
    SaveConfig;
  end;
  frmDBWareSetting.Close;
  frmDBWareSetting:= nil;
end;

procedure TfrmViewData.Button2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmViewData.FormCreate(Sender: TObject);
begin
  RestoreConfig;
end;

procedure TfrmViewData.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if (ActiveControl is TcxDBTextEdit) or (ActiveControl is TcxDBCalcEdit) or
      (ActiveControl is TcxDBDateEdit) or (ActiveControl is TcxDBCheckBox) then
      SelectNext(ActiveControl as TWinControl, True, True);
    Key := 0;
  end
  else if Key = VK_ESCAPE then
    Self.Close;
end;

procedure TfrmViewData.GenDBAwareControl(Query: TDataset);
var
  Level: byte;
  cxDBTextEdit: TcxDBTextEdit;
  cxDBCalEdit: TcxDBCalcEdit;
  cxDBProgressBar: TcxDBProgressBar;
  cxDBDateEdit: TcxDBDateEdit;
  cxDBCheckBox: TcxDBCheckBox;
  cxDBMemo: TcxDBMemo;
  FieldLabel: TcxLabel;
  i: integer;
  LastBottom: integer;
begin
  DataSource1.DataSet := Query;
  if Query.FieldCount >= 20 then
    Self.WindowState := wsMaximized;

  Level := 0;
  LastBottom := 14;
  for i := 0 to Pred(Query.FieldCount) do
  begin
    FieldLabel := TcxLabel.Create(cxScrollBox1);
    FieldLabel.Transparent := True;
    FieldLabel.name := format('Lbl_%s%d',
      [Query.Fields.Fields[i].FieldName, i]);

    if MultipleColumn then
    begin
      if i mod RowCount = 0 then
      begin
        LastBottom := 14;
        Level := i div RowCount;
      end;
    end;

    FieldLabel.Left := 20 + (400 * Level);
    FieldLabel.Top := LastBottom + 6;

    FieldLabel.visible := True;
    FieldLabel.ShowHint := True;
    FieldLabel.Hint := Query.Fields.Fields[i].FieldName;
    FieldLabel.parent := cxScrollBox1;

    if ((Query.Fields.Fields[i].DataType = ftLargeInt) or
      (Query.Fields.Fields[i].DataType = ftInteger) or
      (Query.Fields.Fields[i].DataType = ftSmallint) or
      (Query.Fields.Fields[i].DataType = ftWord) or
      (Query.Fields.Fields[i].DataType = ftCurrency) or
      (Query.Fields.Fields[i].DataType = ftFloat)) then
    begin
      if ((POS('PROGRESS', uppercase(Query.Fields.Fields[i].FieldName)) > 0) or
        (POS('PERCENT', uppercase(Query.Fields.Fields[i].FieldName)) > 0)) then
      begin
        cxDBProgressBar := TcxDBProgressBar.Create(Self);
        cxDBProgressBar.name := format('cxDBProgressBar_%s%d',
          [Query.Fields.Fields[i].FieldName, i]);

        cxDBProgressBar.Width := 250;
        cxDBProgressBar.Left := 120 + (400 * Level);
        cxDBProgressBar.Top := FieldLabel.Top; // 26*(i-(Level*26));
        cxDBProgressBar.DataBinding.DataField := Query.Fields.Fields[i]
          .FieldName;
        cxDBProgressBar.DataBinding.DataSource := DataSource1;
        cxDBProgressBar.TabOrder := i;
        cxDBProgressBar.visible := True;
        cxDBProgressBar.parent := cxScrollBox1;
        LastBottom := cxDBProgressBar.BoundsRect.Bottom;
      end
      else
      begin
        cxDBCalEdit := TcxDBCalcEdit.Create(cxScrollBox1);
        cxDBCalEdit.name := format('cxDBCalEdit_%s%d',
          [Query.Fields.Fields[i].FieldName, i]);

        cxDBCalEdit.Width := 250;
        cxDBCalEdit.Left := 120 + (400 * Level);
        cxDBCalEdit.Top := FieldLabel.Top; // 26*(i-(Level*26));
        cxDBCalEdit.DataBinding.DataField := Query.Fields.Fields[i].FieldName;
        cxDBCalEdit.DataBinding.DataSource := DataSource1;
        cxDBCalEdit.TabOrder := i;
        cxDBCalEdit.visible := True;
        cxDBCalEdit.parent := cxScrollBox1;
        LastBottom := cxDBCalEdit.BoundsRect.Bottom;
      end;
    end
    else if Query.Fields.Fields[i].DataType = ftBoolean then
    begin
      cxDBCheckBox := TcxDBCheckBox.Create(cxScrollBox1);
      cxDBCheckBox.name := format('cxDBCheckBox_%s%d',
        [Query.Fields.Fields[i].FieldName, i]);
      cxDBCheckBox.Width := 250;
      cxDBCheckBox.Left := 120 + (400 * Level);
      cxDBCheckBox.Top := FieldLabel.Top; // 26*(i-(Level*26));
      cxDBCheckBox.Caption := '';
      cxDBCheckBox.DataBinding.DataField := Query.Fields.Fields[i].FieldName;
      cxDBCheckBox.DataBinding.DataSource := DataSource1;
      cxDBCheckBox.TabOrder := i;
      cxDBCheckBox.visible := True;
      cxDBCheckBox.parent := cxScrollBox1;
      LastBottom := cxDBCheckBox.BoundsRect.Bottom;
    end
    else if ((Query.Fields.Fields[i].DataType = ftDate) or
      (Query.Fields.Fields[i].DataType = ftDateTime)) then
    begin
      cxDBDateEdit := TcxDBDateEdit.Create(cxScrollBox1);
      cxDBDateEdit.name := format('cxDBDateEdit_%s%d',
        [Query.Fields.Fields[i].FieldName, i]);
      cxDBDateEdit.Width := 250;
      cxDBDateEdit.Left := 120 + (400 * Level);
      cxDBDateEdit.Top := FieldLabel.Top;
      cxDBDateEdit.DataBinding.DataField := Query.Fields.Fields[i].FieldName;
      cxDBDateEdit.DataBinding.DataSource := DataSource1;
      cxDBDateEdit.TabOrder := i;
      cxDBDateEdit.visible := True;
      cxDBDateEdit.parent := cxScrollBox1;
      LastBottom := cxDBDateEdit.BoundsRect.Bottom;
    end
    // ---
    else if (Query.Fields.Fields[i].DataType = ftWideMemo) or
      (Query.Fields.Fields[i].DataType = Data.DB.ftMemo) then
    begin
      cxDBMemo := TcxDBMemo.Create(cxScrollBox1);
      cxDBMemo.name := format('cxDBMemo_%s%d',
        [Query.Fields.Fields[i].FieldName, i]);
      cxDBMemo.Width := 250;
      cxDBMemo.Height := 120;
      cxDBMemo.Left := 120 + (400 * Level);
      cxDBMemo.Top := FieldLabel.Top;
      cxDBMemo.Properties.ScrollBars := ssBoth;

      cxDBMemo.DataBinding.DataField := Query.Fields.Fields[i].FieldName;
      cxDBMemo.DataBinding.DataSource := DataSource1;
      cxDBMemo.TabOrder := i;
      cxDBMemo.visible := True;
      cxDBMemo.parent := cxScrollBox1;
      LastBottom := cxDBMemo.BoundsRect.Bottom;
    end

    else
    begin
      cxDBTextEdit := TcxDBTextEdit.Create(cxScrollBox1);
      cxDBTextEdit.name := format('cxDBTextEdit_%s%d',
        [Query.Fields.Fields[i].FieldName, i]);
      cxDBTextEdit.Width := 250;
      cxDBTextEdit.Left := 120 + (400 * Level);
      cxDBTextEdit.Top := FieldLabel.Top;
      cxDBTextEdit.DataBinding.DataField := Query.Fields.Fields[i].FieldName;
      cxDBTextEdit.DataBinding.DataSource := DataSource1;
      cxDBTextEdit.TabOrder := i;
      cxDBTextEdit.visible := True;
      cxDBTextEdit.parent := cxScrollBox1;
      LastBottom := cxDBTextEdit.BoundsRect.Bottom;
    end;

    if Length(Query.Fields.Fields[i].FieldName) > 14 then
      FieldLabel.Caption :=
        format('%s', [Copy(Query.Fields.Fields[i].FieldName, 1, 14) + '... :'])
    else
      FieldLabel.Caption :=
        format('%s', [Query.Fields.Fields[i].FieldName + ' :']);

  end;
end;

procedure TfrmViewData.RestoreConfig;
var
  Aw1: TInifile;
  iniPath: String;
begin
  iniPath := ExtractFilePath(paramstr(0))+'dbware.conf';
  Aw1 := TInifile.Create(iniPath);
  try
    FMultipleColumn := Aw1.ReadBool('DBawareGen', 'UseMultiColumn', True);
    FRowCount := Aw1.ReadInteger('DBawareGen', 'RowCount', 5);
  finally
    Aw1.free;
  end;
end;

procedure TfrmViewData.SaveConfig;
var
  Aw1: TInifile;
  iniPath: String;
begin
  iniPath := ExtractFilePath(paramstr(0))+'dbware.conf';
  Aw1 := TInifile.Create(iniPath);
  try
    Aw1.WriteBool('DBawareGen', 'UseMultiColumn', frmDBWareSetting.Chx_UseMultiColumn.Checked);
    Aw1.WriteInteger('DBawareGen', 'RowCount', frmDBWareSetting.UpDownRowCount.Position);
  finally
    Aw1.free;
  end;
end;

end.
