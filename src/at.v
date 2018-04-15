  struct AT {
    unsigned int isnorm;
    unsigned int allocated;
  };
  struct AT ATable[NUM_PAGES];
  --------------------------------------
  Inductive ATType: Type :=
  | ATKern
  | ATResv
  | ATNorm.

  Inductive ATInfo :=
  | ATValid (b: bool) (t: ATType)
  | ATUndef.

  Definition ATable := ZMap.t ATInfo.
