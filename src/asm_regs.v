(* Integer registers. *)

Inductive ireg: Type :=
  | EAX: ireg  | EBX: ireg  | ECX: ireg  | EDX: ireg
  | ESI: ireg  | EDI: ireg  | EBP: ireg  | ESP: ireg.

(* Floating-point registers, i.e. SSE2 registers *)

Inductive freg: Type :=
  | XMM0: freg  | XMM1: freg  | XMM2: freg  | XMM3: freg
  | XMM4: freg  | XMM5: freg  | XMM6: freg  | XMM7: freg.

(* Bits of the flags register. *)

Inductive crbit: Type :=
  | ZF | CF | PF | SF | OF.

(* All registers modeled here. *)

Inductive preg: Type :=
  | PC: preg                   (* program counter *)
  | IR: ireg -> preg            (* integer register *)
  | FR: freg -> preg            (* XMM register *)
  | ST0: preg                  (* top of FP stack *)
  | CR: crbit -> preg           (* bit of the flags register *)
  | RA: preg.                  (* pseudo-reg representing return address *)

(* Register set is defined as a partial map from preg to CompCert value type val. *)
Definition regset := Pregmap.t val. 
