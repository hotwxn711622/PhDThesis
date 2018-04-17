Function pt_init_spec (adt: RData)  : option RData :=
 match (init adt, pg adt, in_intr adt, ikern adt, ihost adt, ipt adt) with
  | (false, false, false, true, true, true) =>
    Some adt {MM: machine_mm} {MMSize: machine_mm_size} 
      {AT: initial_AT (MM adt) (MMSize adt)}
      {nps: initial_nps (MM adt) (MMSize adt)} {idpde: initial_idpde (idpde adt)}
      {ptpool: initial_ptpool (ptpool adt)} {pg: true} {PT: 0} {init: true}
  | _ => None 
 end.
