Lemma cb_init_body_correct: forall m m' d d' le,
    cb_init_lspec ge nil (m, d) Vundef (m', d') ->
    exists le',
        exec_stmt ge (PTree.empty _) le (m, d) cb_init_body E0 le' (m', d') Out_normal.

Lemma cb_write_body_correct: forall m m' d d' le cval,
    PTree.get c le = Some (Vint cval) ->
    cb_write_lspec ge (Vint cval :: nil) (m, d) Vundef (m', d') ->
    exists le',
        exec_stmt ge (PTree.empty _) le (m, d) cb_write_body E0 le' (m', d') Out_normal.

(* Notation tuint := (Tint I32 Unsigned noattr) *)
Lemma cb_read_body_correct: forall m m' d d' le cval,
    cb_read_lspec ge nil (m, d) (Vint cval) (m', d') ->
    exists le',
        exec_stmt ge (PTree.empty _) le (m, d) cb_read_body E0 le' (m', d')
                                                 (Out_return (Some (Vint cval, tuint))).
