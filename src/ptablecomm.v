Function ptAllocPDE_spec  (nn vadr: Z) (adt: RData): option (RData * Z) :=
  match (ikern adt, ihost adt, init adt, ipt adt, pt_Arg' nn vadr) with
  | (true, true, true, true, true) =>
   if zeq nn (PT adt) then None
   else match ZMap.get (PDX vadr) (ZMap.get nn (ptpool adt)) with
     | PDEUnPresent =>
       match first_free (AT adt) (nps adt) with
        | inleft (exist pi _) =>
          Some (adt {AT: ZMap.set pi (ATValid true ATNorm) (AT adt)}
            {ptpool: (ZMap.set nn (ZMap.set (PDX vadr) (PDEValid pi real_init_PTE)
            (ZMap.get nn (ptpool adt))) (ptpool adt))} , pi)
        | _ => Some (adt, 0) end
     | _ => None end
  | _ => None end.

Function ptFreePDE_spec (n vadr: Z) (adt: RData): option RData :=
  match (ikern adt, ihost adt, init adt, ipt adt, pt_Arg' n vadr) with
  | (true, true, true, true, true) =>
   if zeq n (PT adt) then None
   else match ZMap.get (PDX vadr) (ZMap.get n (ptpool adt)) with
    | PDEValid pi _ =>
      if zle_lt 0 pi maxpage then
      match ZMap.get pi (AT adt) with
       | ATValid true ATNorm =>
         let pt':= ZMap.set (PDX vadr) PDEUnPresent (ZMap.get n (ptpool adt)) in
           Some adt {AT: ZMap.set pi (ATValid false ATNorm) (AT adt)}
           {ptpool: ZMap.set n pt' (ptpool adt)}
       | _ => None
      end else None
    | _ => None end
  |_ => None end.

Function pt_init_comm_spec (adt: RData)  : option RData :=
 match (init adt, pg adt, in_intr adt, ikern adt, ihost adt, ipt adt) with
  | (false, false, false, true, true, true) =>
    Some adt {MM: machine_mm} {MMSize: machine_mm_size} {AT: initial_AT (MM adt) (MMSize adt)}
      {nps: initial_nps (MM adt) (MMSize adt)} {idpde: initial_idpde (idpde adt)}
      {ptpool: initial_ptpool_comm (ptpool adt)} {init: true}
  | _ => None end.
