Definition acquire_lock_spec (b: Z) (adt: RData): option RData :=
    let cpu := CPU_ID adt in
    match (ikern adt, ihost adt, valid_lock_range b) with
      | (true, true, true) =>
        match ZMap.get b (event_log adt) with
          | ObservableEvents l =>
              let l' := (E_ACQ_LOCK cpu b) :: (EnvCtxt, cpu, l) ++ l in
              Some (adt {event_log: ZMap.set b (ObservableEvents l') (event_log adt)})
          | _ => None
        end
      | _ => None
    end.

Function release_lock_spec (b: Z) (adt: RData): option RData :=
    let cpu := CPU_ID adt in
    match (ikern adt, ihost adt, valid_lock_range b) with
      | (true, true, true) =>
        match ZMap.get b (evnt_log adt) with
          | ObservableEvents l =>
              let l' := (E_REL_LOCK cpu b) :: (EnvCtxt, cpu, l) ++ l in
              Some (adt {event_log: ZMap.set b (ObservableEvents l') (event_log adt)})
          | _ => None
        end
      | _ => None
    end.
