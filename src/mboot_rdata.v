  Inductive MMPerm:=
  | MMUsable
  | MMResv.
  
  Inductive MMInfo:=
  | MMValid (s l:Z) (p: MMPerm)
  | MMUndef.
  
  Definition MMTable := ZMap.t MMInfo.

  Inductive globalpointer :=
  | GLOBP (b: ident) (ofs: int)
  | GLOBUndef.

  Definition trapinfo := int * val.

  Record RData :=
    mkRData {
        MM: MMTable; 
        MMSize: Z;
        CR3: globalpointer; 
        ti: trapinfo; 
        pg: bool; 
        ikern: bool; 
        ihost: bool;
        init: bool
    }.
