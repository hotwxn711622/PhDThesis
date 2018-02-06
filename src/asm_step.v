Inductive state: Type :=
  | State: regset -> mem -> state.

Inductive step (ge: genv): state -> trace -> state -> Prop :=
  | exec_step_internal:
      forall b ofs f i rs m rs' m',
      rs PC = Vptr b ofs ->
      Genv.find_funct_ptr ge b = Some (Internal f) ->
      find_instr (Int.unsigned ofs) f.(fn_code) = Some i ->
      exec_instr ge f i rs m = Next rs' m' ->
      step ge (State rs m) E0 (State rs' m')
  | exec_step_annot:
...
  | exec_step_external:
      forall b ef args res rs m t rs' m',
      rs PC = Vptr b Int.zero ->
      Genv.find_funct_ptr ge b = Some (External ef) ->
      extcall_arguments rs m (ef_sig ef) args ->
      external_call' (fun _ => True) ef ge args m t res m' ->
      rs' = (set_regs (loc_external_result (ef_sig ef)) res (undef_regs
              (CR ZF :: CR CF :: CR PF :: CR SF :: CR OF :: nil)
              (undef_regs (map preg_of destroyed_at_call) rs))) #PC <- (rs RA) #RA <- Vundef ->
      forall STACK: forall b o, rs ESP = Vptr b o ->
                  (Ple (Genv.genv_next ge) b /\ Plt b (Mem.nextblock m)),
      forall SP_NOT_VUNDEF: rs ESP <> Vundef,
      forall RA_NOT_VUNDEF: rs RA <> Vundef,
      step ge (State rs m) t (State rs' m')
  | exec_step_prim_call:
      forall b ef rs m t rs' m',
      rs PC = Vptr b Int.zero ->
      Genv.find_funct_ptr ge b = Some (External ef) ->
      primitive_call ef ge rs m t rs' m' ->
      step ge (State rs m) t (State rs' m').
