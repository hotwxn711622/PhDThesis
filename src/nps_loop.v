Lemma nps_loop_correct: forall (m: memb) (adt: RData) le size,
  init adt = true ->
  ikern adt = true ->
  ihost adt = true ->
  size = (MMSize adt) ->
  PTree.get tsize le = Some (Vint (Int.repr size)) ->
  PTree.get ti le = Some (Vint (Int.zero)) ->
  PTree.get tnps le = Some (Vint (Int.zero)) ->
  exists le' nps,
    exec_stmt ge (PTree.empty _) le ((m, adt): mem) (Swhile nps_while_condition nps_while_body) E0 le' (m, adt) Out_normal /\
    PTree.get tsize le' = Some (Vint (Int.repr size)) /\
    PTree.get tnps le' = Some (Vint (Int.repr nps)) /\
    nps = initial_nps (MM adt) size.
