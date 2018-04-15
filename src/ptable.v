#define NUM_PROC 1024

extern char * PTPool[NUM_PROC][1024];
extern unsigned int IDPMap[1024][1024];

-----------------------------------------------
Inductive PTPerm: Type :=
  | PTP
  | PTU
  | PTK (b: bool).

Inductive PTEInfo:=
  | PTEValid (v: Z) (p: PTPerm)
  | PTEUnPresent
  | PTEUndef.

Definition PTE := ZMap.t PTEInfo.

Inductive PDE :=
  | PDEValid (pi: Z) (pte: PTE)
  | PDEID
  | PDEUnPresent
  | PDEUndef.

Inductive IDPTEInfo:=
  | IDPTEValid (p: PTPerm)
  | IDPTEUndef.

Definition IDPTE := ZMap.t IDPTEInfo.
Definition IDPDE := ZMap.t IDPTE.

Definition PMap := ZMap.t PDE.
Definition PMapPool := ZMap.t PMap.
