Lemma cb_init_body_correct: forall m m' d d' le,
    cb_init_lspec ge nil (m, d) Vundef (m', d') ->
    exists le',
        exec_stmt ge (PTree.empty _) le (m, d) cb_init_body E0 le' (m', d') Out_normal.
Proof:
    (* introduce variables appearing with forall as well as the premise *)
    intros.
    (* turn the le' into an existential variable *)
    esplit.
    (* invert cb_init_lspec to get the individual preconditions *)
    inversion H.
    (* unfold the function body definition *)
    unfold cb_init_body.
    (* invocation of the main automation tactic *)
    cauto.
    (* the memory store operations in the low-level specification uses Int.zero
       while we get (Int.repr 0) in the subgoals *)
    change (Int.repr 0) with Int.zero; eauto.
    change (Int.repr 0) with Int.zero; eauto.
Qed.
