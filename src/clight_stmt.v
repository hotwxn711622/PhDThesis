Inductive statement : Type :=
  | Sskip : statement                   (* do nothing *)
  | Sassign : expr -> expr -> statement (* assignment [lvalue = rvalue] *)
  | Sset : ident -> expr -> statement   (* assignment [tempvar = rvalue] *)
  | Scall: option ident -> expr -> list expr -> statement (* function call *)
  | Ssequence : statement -> statement -> statement  (* sequence *)
  | Sifthenelse : expr  -> statement -> statement -> statement (* conditional *)
  | Sloop: statement -> statement -> statement (* infinite loop *)
  | Sbreak : statement                      (* [break] statement *)
  | Scontinue : statement                   (* [continue] statement *)
  | Sreturn : option expr -> statement      (* [return] statement *)
  | Sswitch : expr -> labeled_statements -> statement  (* [switch] statement *)
  | Slabel : label -> statement -> statement
  | Sgoto : label -> statement

with labeled_statements : Type :=            (* cases of a [switch] *)
  | LSnil: labeled_statements
  | LScons: option int -> statement -> labeled_statements -> labeled_statements.
                      (* [None] is [default], [Some x] is [case x] *)

(* The C loops are derived forms. *)

Definition Swhile (e: expr) (s: statement) :=
  Sloop (Ssequence (Sifthenelse e Sskip Sbreak) s) Sskip.

Definition Sdowhile (s: statement) (e: expr) :=
  Sloop s (Sifthenelse e Sskip Sbreak).

Definition Sfor (s1: statement) (e2: expr) (s3: statement) (s4: statement) :=
  Ssequence s1 (Sloop (Ssequence (Sifthenelse e2 Sskip Sbreak) s3) s4).

