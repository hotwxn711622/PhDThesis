Inductive expr : Type :=
  | Econst_int: int -> type -> expr       (* integer literal *)
  | Econst_float: float -> type -> expr   (* float literal *)
  | Econst_long: int64 -> type -> expr    (* long integer literal *)
  | Evar: ident -> type -> expr           (* variable *)
  | Etempvar: ident -> type -> expr       (* temporary variable *)
  | Ederef: expr -> type -> expr          (* pointer dereference (unary [*]) *)
  | Eaddrof: expr -> type -> expr         (* address-of operator ([&]) *)
  | Eunop: unary_operation -> expr -> type -> expr  (* unary operation *)
  | Ebinop: binary_operation -> expr -> expr -> type -> expr (* binary operation *)
  | Ecast: expr -> type -> expr   (* type cast ([(ty) e]) *)
  | Efield: expr -> ident -> type -> expr. (* access to a member of a struct or union *)

Inductive unary_operation : Type :=
  | Onotbool : unary_operation          (* boolean negation ([!] in C) *)
  | Onotint : unary_operation           (* integer complement ([~] in C) *)
  | Oneg : unary_operation              (* opposite (unary [-]) *)
  | Oabsfloat : unary_operation.        (* floating-point absolute value *)

Inductive binary_operation : Type :=
  | Oadd : binary_operation             (* addition (binary [+]) *)
  | Osub : binary_operation             (* subtraction (binary [-]) *)
  | Omul : binary_operation             (* multiplication (binary [*]) *)
  | Odiv : binary_operation             (* division ([/]) *)
  | Omod : binary_operation             (* remainder ([%]) *)
  | Oand : binary_operation             (* bitwise and ([&]) *)
  | Oor : binary_operation              (* bitwise or ([|]) *)
  | Oxor : binary_operation             (* bitwise xor ([^]) *)
  | Oshl : binary_operation             (* left shift ([<<]) *)
  | Oshr : binary_operation             (* right shift ([>>]) *)
  | Oeq: binary_operation               (* comparison ([==]) *)
  | One: binary_operation               (* comparison ([!=]) *)
  | Olt: binary_operation               (* comparison ([<]) *)
  | Ogt: binary_operation               (* comparison ([>]) *)
  | Ole: binary_operation               (* comparison ([<=]) *)
  | Oge: binary_operation.              (* comparison ([>=]) *)
