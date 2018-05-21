struct EPTStruct {
    char * pml4[1024];
    char * pdpt[1024];
    char * pdt[4][1024];
    unsigned long long ptab[4][512][512];
};

extern struct EPTStruct EPT;

------------------------------------------------

(* PTab entry *)
Inductive EPTE:=
  | EPTEValid (hpa: Z)
  | EPTEUndef.

Definition EPTAB := ZMap.t EPTE.

(* PDT entry *)
Inductive EPDTE :=
  | EPDTEValid (eptab : EPTAB)
  | EPDTEUndef.

Definition EPDT := ZMap.t EPDTE.

(* PDPT entry *)
Inductive EPDPTE :=
  | EPDPTEValid (epdt: EPDT)
  | EPDPTEUndef.

Definition EPDPT := ZMap.t EPDPTE.

(* PML4 entry *)

Inductive EPML4E :=
  | EPML4EValid (epdpt: EPDPT)
  | EPML4EUndef.

Definition EPT := ZMap.t EPML4E.



