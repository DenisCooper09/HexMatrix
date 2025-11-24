Var
   PCBBoard : IPCB_Board;
   Comp     : IPCB_Component;
   CompIter : IPCB_BoardIterator;

Begin
     PCBBoard := PCBServer.GetCurrentPCBBoard;
     If PCBBoard = Nil Then
     Begin
          ShowMessage('No PCB open!');
          Exit;
     End;

     CompIter := PCBBoard.BoardIterator_Create;
     CompIter.AddFilter_ObjectSet(MkSet(eComponentObject));
     CompIter.AddFilter_Method(MkSet(eAllComponents));

     Comp := CompIter.FirstPCBObject;
     While Comp <> Nil Do
     Begin
          If Comp.Selected Then
          Begin
               ShowMessage('Component: ' + Comp.Name.Text);
          End;

          Comp := CompIter.NextPCBObject;
     End;

     PCBBoard.BoardIterator_Destroy(CompIter);
End;

