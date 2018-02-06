Inductive instruction: Type :=
  (* Moves *)
  | Pmov_rr (rd: ireg) (r1: ireg)       (* [mov] (32-bit int) *)
  | Pmov_ri (rd: ireg) (n: int)
  | Pmov_rm (rd: ireg) (a: addrmode)
  | Pmov_mr (a: addrmode) (rs: ireg)
...
  (* Moves with conversion *)
...
  (* Integer arithmetic *)
  | Plea (rd: ireg) (a: addrmode)
  | Psub_rr (rd: ireg) (r1: ireg)
  | Pimul_ri (rd: ireg) (n: int)
...
  (* Floating-point arithmetic *)
...
  (* Branches and calls *)
  | Pjmp_l (l: label)
  | Pcall_s (symb: ident) (sg: signature)
  | Pret
...
  (* Pseudo-instructions *)
  | Pallocframe(sz: Z) (ofs_ra ofs_link: int)
  | Pfreeframe(sz: Z) (ofs_ra ofs_link: int)
...

