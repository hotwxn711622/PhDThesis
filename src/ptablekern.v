Function ptRmv_spec (n vadr: Z) (adt: RData): option (RData * Z) :=
  match (ikern adt, ihost adt, init adt, ipt adt, pg adt, pt_Arg' n vadr) with
    | (true, true, true, true, true, true) =>
      if zeq n (PT adt) then None
      else
       let pt:= ZMap.get n (ptpool adt) in
       let pdi := PDX vadr in
       match ZMap.get pdi pt with
        | PDEValid pi pdt =>
          if zlt_lt 0 pi maxpage then
           let pti := PTX vadr in
            match ZMap.get pti pdt with
             | PTEValid padr _ =>
               if zlt_lt 0 padr maxpage then
                match ZMap.get padr (AT adt) with
                | ATValid true ATNorm =>
                  let pdt':= ZMap.set pti PTEUnPresent pdt in
                  let pt' := ZMap.set pdi (PDEValid pi pdt') pt in
                  Some (adt {AT: ZMap.set padr (ATValid true ATNorm) (AT adt)}
                    {ptpool: ZMap.set n pt' (ptpool adt)}, padr)
                | _ => None
                end 
               else None
             | PTEUnPresent => Some (adt, 0)
             | _ => None
            end 
          else None
        | _ => None 
       end
    | _ => None 
  end.

Function pt_init_kern_spec (adt: RData)  : option RData :=
 match (init adt, pg adt, in_intr adt, ikern adt, ihost adt, ipt adt) with
  | (false, false, false, true, true, true) =>
    Some adt {MM: machine_mm} {MMSize: machine_mm_size} 
             {AT: initial_AT (MM adt) (MMSize adt)}
             {nps: initial_nps (MM adt) (MMSize adt)} {idpde: initial_idpde (idpde adt)}
             {ptpool: initial_ptpool (ptpool adt)} {init: true}
  | _ => None 
 end.
