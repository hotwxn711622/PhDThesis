  Definition PDE_Arg (n i: Z) : bool :=
    if zle_lt 0 n num_proc then
      if zle_le 0 i (PDX Int.max_unsigned) then
        true
      else false
    else false.

  Definition PTE_Arg (n i vadr: Z): bool :=
    if PDE_Arg n i then
      if zle_le 0 vadr (PTX Int.max_unsigned) then
        true
      else false
    else false.

  Function setPDE_spec (n i: Z) (adt: RData) : option RData :=
    match (ikern adt, pg adt, ihost adt, init adt, ipt adt, PDE_Arg n i) with
      | (true, false, true, true, true, true) =>
        let pt':= ZMap.set i PDEID (ZMap.get n (ptpool adt)) in
        Some adt {ptpool: (ZMap.set n pt' (ptpool adt))}
      |_ => None
    end.

  Function rmvPTE_spec (n i vadr: Z) (adt: RData) : option RData :=
    match (ikern adt, ihost adt, init adt, ipt adt, PTE_Arg n i vadr) with
      | (true, true, true, true, true) =>
        if zeq n (PT adt) then None
        else
          let pt:= ZMap.get n (ptpool adt) in
          match ZMap.get i pt with
            | PDEValid pi pdt =>
              let pdt':= ZMap.set vadr PTEUnPresent pdt in
              let pt' := ZMap.set i (PDEValid pi pdt') pt in
              Some adt {ptpool: ZMap.set n pt' (ptpool adt)}
            | _ => None
          end
      | _ => None
    end.
