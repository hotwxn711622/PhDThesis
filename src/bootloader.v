  Function bootloader_spec (adt: RData) : option RData :=
    match (init adt, pg adt, ikern adt, ihost adt) with
      | (false, false, true, true) =>
            Some adt {MM: machine_mm} {MMSize: machine_mm_size} {init: true}
      | _ => None
    end.
