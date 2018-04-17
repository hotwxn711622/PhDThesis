Definition thread_spawn_spec (adt: RData) (b: block) (b':block) (ofs': int) id q :
                                                               option (RData* Z) :=
  match (pg adt, ikern adt, ihost adt, ipt adt) with
   | (true, true, true, true) =>
     match first_free_PT (pb adt) num_proc with
      | inleft (exist i _) =>
        match (ZMap.get num_chan (abq adt)) with
         | AbQValid l =>
           let ofs := Int.repr ((i + 1) * PgSize -4) in
           let rs := ((ZMap.get i (kctxt adt))#SP <- (Vptr b ofs))#RA <- (Vptr b' ofs') in
           Some (adt {pb: ZMap.set i PTTrue (pb adt)}
             {kctxt: ZMap.set i rs (kctxt adt)}
             {abtcb: ZMap.set i (AbTCBValid READY num_chan) (abtcb adt)}
             {abq: ZMap.set num_chan (AbQValid (i::l)) (abq adt)}, i)
         | _ => None
        end
      | _ => None
     end
   | _ => None
  end.

Function thread_wakeup_spec (n: Z) (adt: RData) : option RData :=
  match (ikern adt, pg adt, ihost adt, ipt adt) with
   | (true, true, true, true) =>
     if zle_lt 0 n num_chan then
       match ZMap.get n (abq adt) with
        | AbQValid l => let la := last l num_proc in
          if zeq la num_proc then Some adt
          else match ZMap.get la (abtcb adt), ZMap.get num_chan (abq adt) with
                | AbTCBValid _ _, AbQValid l' =>
                  Some adt {abtcb: ZMap.set la (AbTCBValid READY num_chan) (abtcb adt)}
                    {abq: ZMap.set num_chan (AbQValid (la:: l'))
                          (ZMap.set n (AbQValid (remove zeq la l)) (abq adt))}
                | _, _ => None
               end
        | _ => None
       end
     else None
   | _ => None
  end.
