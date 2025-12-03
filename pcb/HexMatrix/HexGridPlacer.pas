Procedure PlaceComponentsInHexGrid(Size : Integer, CompList : TInterfaceList);
Var
   Comp             : IPCB_Component;
   i                : Integer;

   r, q, dq, q0, q1 : Integer;
   qLeft, qRight    : Integer;

   LeftRight        : Boolean;

Begin
     For r := Size - 1 DownTo -Size + 1 Do
     Begin
          qLeft     := -r * Ord(r < 0)  - (Size - 1);
          qRight    := -r * Ord(r >= 0) + (Size - 1);

          LeftRight := (r And 1) Xor (Size And 1);

          dq        := IfThen(LeftRight, 1, -1);
          q0        := IfThen(LeftRight, qLeft, qRight);
          q1        := IfThen(LeftRight, qRight, qLeft);

          q := q0;
          While q <> q1 + dq Do
          Begin
               ShowMessage(IntToStr(q) + ' ' + IntToStr(r));
               q := q + dq;
          End;
     End;
End;

Var
   PCBBoard : IPCB_Board;

   Comp     : IPCB_Component;
   CompIter : IPCB_BoardIterator;
   CompList : TInterfaceList;

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

     PlaceComponentsInHexGrid(3, CompList);
End;

