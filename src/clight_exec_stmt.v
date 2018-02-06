Variable ge : genv.
Inductive exec_stmt: env -> temp_env -> mem -> statement -> trace -> temp_env ->
                                                        mem -> outcome -> Prop :=
  | exec_Sskip:   forall e le m,
      exec_stmt e le m Sskip E0 le m Out_normal
  | exec_Sassign:   forall e le m a1 a2 loc ofs v2 v m',
      eval_lvalue ge e le m a1 loc ofs ->
      eval_expr ge e le m a2 v2 ->
      sem_cast v2 (typeof a2) (typeof a1) = Some v ->
      assign_loc ge (typeof a1) m loc ofs v m' ->
      exec_stmt e le m (Sassign a1 a2) E0 le m' Out_normal
  | exec_Sset:     forall e le m id a v,
      eval_expr ge e le m a v ->
      exec_stmt e le m (Sset id a) E0 (PTree.set id v le) m Out_normal
  | exec_Sseq_1:   forall e le m s1 s2 t1 le1 m1 t2 le2 m2 out,
      exec_stmt e le m s1 t1 le1 m1 Out_normal ->
      exec_stmt e le1 m1 s2 t2 le2 m2 out ->
      exec_stmt e le m (Ssequence s1 s2) (t1 ** t2) le2 m2 out
  | exec_Sseq_2:   forall e le m s1 s2 t1 le1 m1 out,
      exec_stmt e le m s1 t1 le1 m1 out ->
      out <> Out_normal ->
      exec_stmt e le m (Ssequence s1 s2) t1 le1 m1 out
  | exec_Sifthenelse: forall e le m a s1 s2 v1 b t le' m' out,
      eval_expr ge e le m a v1 ->
      bool_val v1 (typeof a) = Some b ->
      exec_stmt e le m (if b then s1 else s2) t le' m' out ->
      exec_stmt e le m (Sifthenelse a s1 s2) t le' m' out
  | exec_Sreturn_none:   forall e le m,
      exec_stmt e le m (Sreturn None) E0 le m (Out_return None)
  | exec_Sreturn_some: forall e le m a v,
      eval_expr ge e le m a v ->
      exec_stmt e le m (Sreturn (Some a)) E0 le m (Out_return (Some (v, typeof a)))
  | exec_Sbreak:   forall e le m,
      exec_stmt e le m Sbreak E0 le m Out_break
  | exec_Scontinue:   forall e le m,
      exec_stmt e le m Scontinue E0 le m Out_continue
  | exec_Sswitch:   forall e le m a t n sl le1 m1 out,
      eval_expr ge e le m a (Vint n) ->
      exec_stmt e le m (seq_of_labeled_statement (select_switch n sl)) t le1 m1 out ->
      exec_stmt e le m (Sswitch a sl) t le1 m1 (outcome_switch out)
  ...
