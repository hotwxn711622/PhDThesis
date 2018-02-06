Fixpoint match_cons_buf (cons_buf: list Z) (cons_buf_concrete: ZMap.t Z) (rpos wpos: Z) : Prop :=
  match cons_buf with
   | nil => rpos = wpos
   | bv :: cons_buf' =>
       ZMap.get rpos cons_buf_concrete = bv /\
       match_cons_buf cons_buf' cons_buf_concrete ((rpos + 1) mod CB_SIZE) wpos
  end.

Inductive R_cons_buf: L_high.Abs -> L_mid.Abs -> Prop :=
| MATCH_CONS_BUF:
    forall d_high d_mid,
      match_cons_buf d_high.cons_buf d_mid.cons_buf_concrete d_mid.rpos d_mid.wpos ->
      R_cons_buf d_high d_mid.
