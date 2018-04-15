  Function mem_init_spec (adt: RData) : option RData :=
    match (init adt, pg adt, ikern adt, ihost adt) with
      | (false, false, true, true) =>
            Some adt {MM: machine_mm} {MMSize: machine_mm_size} {AT: initial_AT (MM adt) (MMSize adt)} {nps: initial_nps (MM adt) (MMSize adt)} {init: true}
      | _ => None
    end.
