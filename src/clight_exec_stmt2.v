Inductive exec_stmt: env -> temp_env -> mem -> statement -> trace -> temp_env ->
                                                        mem -> outcome -> Prop :=
  ...
  | exec_Sloop_stop1: forall e le m s1 s2 t le' m' out' out,
      exec_stmt e le m s1 t le' m' out' ->
      out_break_or_return out' out ->
      exec_stmt e le m (Sloop s1 s2) t le' m' out
  | exec_Sloop_stop2: forall e le m s1 s2 t1 le1 m1 out1 t2 le2 m2 out2 out,
      exec_stmt e le m s1 t1 le1 m1 out1 ->
      out_normal_or_continue out1 ->
      exec_stmt e le1 m1 s2 t2 le2 m2 out2 ->
      out_break_or_return out2 out ->
      exec_stmt e le m (Sloop s1 s2) (t1**t2) le2 m2 out
  | exec_Sloop_loop: forall e le m s1 s2 t1 le1 m1 out1 t2 le2 m2 t3 le3 m3 out,
      exec_stmt e le m s1 t1 le1 m1 out1 ->
      out_normal_or_continue out1 ->
      exec_stmt e le1 m1 s2 t2 le2 m2 Out_normal ->
      exec_stmt e le2 m2 (Sloop s1 s2) t3 le3 m3 out ->
      exec_stmt e le m (Sloop s1 s2) (t1**t2**t3) le3 m3 out
  | exec_Scall:   forall e le m optid a al tyargs tyres cconv vf vargs f t m' vres,
      classify_fun (typeof a) = fun_case_f tyargs tyres cconv ->
      eval_expr ge e le m a vf ->
      eval_exprlist ge e le m al tyargs vargs ->
      Genv.find_funct ge vf = Some f ->
      type_of_fundef f = Tfunction tyargs tyres cconv ->
      eval_funcall m f vargs t m' vres ->
      exec_stmt e le m (Scall optid a al) t (set_opttemp optid vres le) m' Out_normal

with eval_funcall: mem -> fundef -> list val -> trace -> mem -> val -> Prop :=
  | eval_funcall_internal: forall le le' m f vargs t e m2 m3 out vres m4,
      function_entry ge f vargs m e le m2 ->
      exec_stmt e le m2 f.(fn_body) t le' m3 out ->
      outcome_result_value out f.(fn_return) vres ->
      Mem.free_list m3 (blocks_of_env e) = Some m4 ->
      eval_funcall m (Internal f) vargs t m4 vres
  | eval_funcall_external: forall m ef targs tres cconv vargs t vres m',
      external_call ef (writable_block ge) ge vargs m t vres m' ->
      eval_funcall m (External ef targs tres cconv) vargs t m' vres.
