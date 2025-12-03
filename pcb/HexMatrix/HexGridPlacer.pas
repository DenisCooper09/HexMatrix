Var
   PCBBoard : IPCB_Board;

   Comp     : IPCB_Component;
   CompIter : IPCB_BoardIterator;
   CompList : TInterfaceList;

   i        : Integer;

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

     CompList := TInterfaceList.Create;

     Comp := CompIter.FirstPCBObject;
     While Comp <> Nil Do
     Begin
          If Comp.Selected Then
               CompList.Add(Comp);

          Comp := CompIter.NextPCBObject;
     End;

     PCBBoard.BoardIterator_Destroy(CompIter);

     For i := CompList.Count - 1 DownTo 0 Do
     Begin
          Comp := CompList[i];
          ShowMessage('Component: ' + Comp.Name.Text);
     End;
End;

