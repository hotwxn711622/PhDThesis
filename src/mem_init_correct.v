Theorem mem_init_correct: forall m adt adt' le,
    mem_init_spec adt = Some adt' ->
    exists le',
        exec_stmt ge (PTree.empty) le ((m, adt): mem) mem_init_code E0 le' (m, adt') Out_normal.
