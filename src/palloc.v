  Function palloc_spec (adt: RData): option (RData * Z) :=
    match (ikern adt, init adt, ihost adt) with
      | (true, true, true) =>
          match first_free (AT adt) (nps adt) with
            | inleft (exist i _) =>
              Some (adt {AT: ZMap.set i (ATValid true ATNorm) (AT adt)}, i)
            | _ => Some (adt, NPS)
          end
      | _ => None
    end.
