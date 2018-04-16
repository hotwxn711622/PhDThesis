Function thread_sched_spec (adt: RData) (rs: KContext) : option (RData*KContext) :=
  match (pg adt, ikern adt, ihost adt, ipt adt) with
   | (true, true, true, true) =>
     match ZMap.get num_chan (abq adt) with
      | AbQValid l => let la := last l num_proc in
        if zeq la num_proc then None
        else match ZMap.get la (pb adt), ZMap.get la (abtcb adt) with
              | PTTrue, AbTCBValid _ _ =>
                match (ZMap.get (cid adt) (abtcb adt)) with
                 | AbTCBValid st _ =>
                   if ThreadState_dec st RUN then None
                   else if zeq (cid adt) la then None
                   else Some (adt {kctxt: ZMap.set (cid adt) rs (kctxt adt)}
                        {abtcb: ZMap.set la (AbTCBValid RUN (-1)) (abtcb adt)}
                        {abq: ZMap.set num_chan (AbQValid (remove zeq la l)) (abq adt)}
                        {cid: la}, ZMap.get la (kctxt adt))
                 | _ => None
                end
              | _, _ => None
             end
      | _ => None
     end
   | _ => None
  end.
