# Auto_Generate_DBAware_Controls
Delphi:
  - Code stuff to Auto.Generate DB Aware controls at runtime.
  - (This project use devexpres control*)

How to:
  
  frmViewData:= TfrmViewData.create(Self);
  frmViewData.GenDBAwareControl(cxDbtv1.DataController.DataSet);
  frmViewData.ShowModal;
