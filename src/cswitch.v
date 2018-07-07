Definition AddrMake1 (r: ireg) :=
    Addrmode (Some r) (Some (r, Int.repr 2)) (inl Int.zero).

Definition AddrMake2 (r: ireg) :=
    Addrmode None (Some (r, Int.repr 8)) (inr (KCtxtPool_LOC, Int.zero)).

Definition AddrMake3 (r: ireg) (ofs:int) :=
    Addrmode (Some r) None (inl ofs).

Definition Im_cswitch : list instruction :=
    (*save the old kernel context*)
    asm_instruction (Plea EAX (AddrMake1 EAX)) ::  (* EAX = EAX * 3 *)
    asm_instruction (Plea EAX (AddrMake2 EAX)) ::  (* EAX = KCtxtPool_LOC (EAX * 8) *)
    asm_instruction (Pmov_mr (AddrMake3 EAX Int.zero) Asm.ESP) ::
    asm_instruction (Pmov_mr (AddrMake3 EAX (Int.repr 4)) Asm.EDI) ::
    asm_instruction (Pmov_mr (AddrMake3 EAX (Int.repr 8)) Asm.ESI) ::
    asm_instruction (Pmov_mr (AddrMake3 EAX (Int.repr 12)) Asm.EBX) ::
    asm_instruction (Pmov_mr (AddrMake3 EAX (Int.repr 16)) Asm.EBP) ::
    Ppopl_RA ECX ::
    asm_instruction (Pmov_mr (AddrMake3 EAX (Int.repr 20)) ECX) ::

    (*load the new kernel context*)
    asm_instruction (Plea EDX (AddrMake1 EDX)) ::  (* EAX = EAX * 3 *)
    asm_instruction (Plea EDX (AddrMake2 EDX)) ::  (* EAX = KCtxtPool_LOC (EAX * 8) *)

    asm_instruction (Pmov_rm Asm.ESP (AddrMake3 EDX Int.zero)) ::
    asm_instruction (Pmov_rm Asm.EDI (AddrMake3 EDX (Int.repr 4))) ::
    asm_instruction (Pmov_rm Asm.ESI (AddrMake3 EDX (Int.repr 8))) ::
    asm_instruction (Pmov_rm Asm.EBX (AddrMake3 EDX (Int.repr 12))) ::
    asm_instruction (Pmov_rm Asm.EBP (AddrMake3 EDX (Int.repr 16))) ::
    asm_instruction (Pmov_rm Asm.ECX (AddrMake3 EDX (Int.repr 20))) ::
    Ppushl_RA ECX ::
    asm_instruction (Pxor_r EAX) ::
    asm_instruction (Pret) ::
    nil.

Definition cswitch_function: function := mkfunction null_signature Im_cswitch.
