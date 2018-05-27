Definition acquire_lock_intermediate_spec (b: Z) (bound: Z) (adt: RData) : option RData :=
  match (ikern adt, ihost adt, valid_lock_range) with
    | (true, true, true) =>
      match ZMap.get b (event_log adt) with
        | ObservableEvents l =>
          let cpu := CPU_ID adt in
          let l1 := (E_INC_TICKET cpu b) :: (EnvCtxt cpu l) ++ l in
          match ReplayTicket l1 with
            | t, _ =>
              match WaitTicket bound cpu b (t - 1) l1 with
                | Some l2 =>
                  let l3 := (E_PULL cpu b) :: l2 in
                  Some adt {event_log: ZMap.set b (ObservableEvents l3) (event_log adt)}
                | _ => None
              end
          end
        | _ => None
       end
     | _ => None
  end.
