  Function setPTE_spec (n i vadr padr perm: Z) (adt: RData) : option RData :=
    match (ikern adt, ihost adt, init adt, ipt adt, PTE_Arg n i vadr, ZtoPerm perm) with
      | (true, true, true, true, true, Some p) =>
        if zeq n (PT adt) then None
        else
          if zlt_lt 0 padr (nps adt) then
            let pt:= ZMap.get n (ptpool adt) in
            match ZMap.get i pt with
              | PDEValid pi pdt =>
                let pdt':= ZMap.set vadr (PTEValid padr p) pdt in
                let pt' := ZMap.set i (PDEValid pi pdt') pt in
                Some adt {ptpool: ZMap.set n pt' (ptpool adt)}
              | _ => None
            end
          else None
      | _ => None
    end.

  Definition IDPTE_Arg (i vadr: Z) : bool :=
    if zle_le 0 i (PDX Int.max_unsigned) then
      if zle_le 0 vadr (PTX Int.max_unsigned) then
        true
      else false
    else false.

  Function setIDPTE_spec (i vadr perm: Z) (adt: RData) : option RData :=
    match (ikern adt, pg adt, ihost adt, init adt, ipt adt, IDPTE_Arg i vadr) with
      | (true, false, true, true, true, true) =>
        match ZtoPerm perm with
          | Some p =>
            let pde:= (ZMap.get i (idpde adt)) in
            let pde':= ZMap.set vadr (IDPTEValid p) pde in
            Some adt {idpde: ZMap.set i pde' (idpde adt)}
          | _ => None
        end
      | _ => None
    end.
