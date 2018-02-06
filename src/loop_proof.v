Module LoopProofSimpleWhile.

Section S.

  Variables (condition: expr) (body: statement) (genv: genv) (env: env)
            (P Q: temp_env -> mem -> Prop).

  Record t  : Type := make {

         W: Type;

         lt: W-> W-> Prop;

         lt_wf: well_founded lt;

         I: temp_env-> mem-> W-> Prop;

         P_implies_I: forall le m, P le m-> exists n0, I le m n0;

         I_invariant:
          forall le m n, I le m n-> 
            exists v b, (
              eval_expr genv env le m condition v /\
              (bool_val v (typeof condition) = Some b) /\
              (b = false -> Q le m) /\
              (b = true -> 
               exists le' m', exec_stmt genv env le m body E0 le' m' Out_normal /\
                              exists n', lt n' n /\ I le' m' n'
              )
            )
  }.

  Theorem termination: t -> forall le m, P le m ->
    (exists le' m',
       exec_stmt genv env le m (Swhile condition body) E0 le' m' Out_normal /\ Q le' m').
  Proof.
    (* proof by induction on the termination metric and *)
    (* by case analysis on the loop condition *)
    ...
  Qed.

End S.

End LoopProofSimpleWhile.