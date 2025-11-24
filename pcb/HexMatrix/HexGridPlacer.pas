Function PI : Double;
Begin
     Result := ArcTan(1) * 4;
End;

Function GetHexGridX(D : Double, s : Double, n : Integer, m : Integer) : Double;
Var
   k, t       : Integer;
   edge, v, u : Double;
Begin
     k := (n - 1) Div m;
     t := (n - 1) - k * m;

     v := Cos((PI() * k)       / 3);
     u := Cos((PI() * (k + 1)) / 3);

     edge := u - v;

     Result := (D + s) * (m * v + t * edge);
End;

Function GetHexGridY(D : Double, s : Double, n : Integer, m : Integer) : Double;
Var
   k, t       : Integer;
   edge, v, u : Double;
Begin
     k := (n - 1) Div m;
     t := (n - 1) - k * m;

     v := Sin((PI() * k)       / 3);
     u := Sin((PI() * (k + 1)) / 3);

     edge := u - v;

     Result := (D + s) * (m * v + t * edge);
End;

Function HexGridPlace(D : Double, s : Double, m : Integer);
Var
   n    : Integer;
   x, y : Double;
Begin
     For n := 1 To 6 * m Do
     Begin
          x := GetHexGridX(D, s, n, m);
          y := GetHexGridY(D, s, n, m);

          ShowMessage('n=' + IntToStr(n) + '  x=' + FloatToStr(x) + '  y=' + FloatToStr(y));
     End;
End;

Procedure PrintHexGridPlace;
Begin
     //HexGridPlace(9.2, 0, 1);
     HexGridPlace(1, 0, 1);
End;

Var
   PCBBoard    : IPCB_Board;
   Component   : IPCB_Component;
   Iterator    : IPCB_BoardIterator;
   LEDs        : TInterfaceList;

   HexGridSize : Integer;
   LEDDiameter : Double;

   X           : Double;
   Y           : Double;
Begin
     PCBBoard := PCBServer.GetCurrentPCBBoard;
     if PCBBoard = Nil Then Exit;

     LEDs := TInterfaceList.Create;

     Iterator := PCBBoard.BoardIterator_Create;
     Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
     Iterator.AddFilter_Method(eAllComponents);
     Component := Iterator.FirstPCBObject;

     While Component <> Nil Do
     Begin
          If Pos('D3001_', Component.Name.Text) = 1 Then
          Begin
               LEDs.Add(Component);
               ShowMessage('found led');
          End;

          Component := Iterator.NextPCBObject;
     End;

     PCBBoard.BoardIterator_Destroy(Iterator);
End;

