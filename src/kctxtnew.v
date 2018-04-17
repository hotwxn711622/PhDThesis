  Definition kctxt_new_spec (adt: RData) (b: block) (b':block) (ofs': int) id q:
                                                            option (RData * Z) :=
    match (pg adt, ikern adt, ihost adt, ipt adt) with
      | (true, true, true, true) =>
        match first_free_PT (pb adt) num_proc with
          | inleft (exist i _) =>
            let ofs := Int.repr ((i + 1) * PAGE_SIZE -4) in
            let rs := ((ZMap.get i (kctxt adt)) # SP <- (Vptr b ofs)) # RA <- (Vptr b' ofs') in
            Some (adt {pb: ZMap.set i PTTrue (pb adt)}
                      {kctxt: ZMap.set i rs (kctxt adt)}, i)
          | _ => None
        end
      | _ => None
    end.
