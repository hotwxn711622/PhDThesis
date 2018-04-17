Function thread_yield_spec (adt: RData) (rs: KContext) : option (RData * KContext) :=
  match (pg adt, ikern adt, ihost adt, ipt adt) with
    | (true, true, true, true) =>
      match ZMap.get num_chan (abq adt) with
        | AbQValid l =>
          let la := last l num_proc in
          if zeq la num_proc then None
          else
           Some (adt {kctxt: ZMap.set (cid adt) rs (kctxt adt)}
                {abtcb: ZMap.set la (AbTCBValid RUN (-1))
                        (ZMap.set (cid adt) (AbTCBValid READY num_chan) (abtcb adt))}
                {abq: ZMap.set num_chan (AbQValid (remove zeq la ((cid adt) :: l))) (abq adt)}
                {cid: la}
                , ZMap.get la (kctxt adt))
        | _ => None
      end
    | _ => None
  end.
