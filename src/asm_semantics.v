Definition exec_instr (ge: genv) (f: function) (i: instruction) (rs: regset) (m: mem) : outcome :=
  match i with
  | Pmov_rr rd r1 =>
      Next (nextinstr (rs#rd <- (rs r1))) m
  | Pmov_ri rd n =>
      Next (nextinstr_nf (rs#rd <- (Vint n))) m
  | Pmov_rm rd a =>
      exec_load _ _ ge Mint32 m a rs rd
  | Pmov_mr a r1 =>
      exec_store _ _ ge Mint32 m a rs r1 nil
  | Plea rd a =>
      Next (nextinstr (rs#rd <- (eval_addrmode ge a rs))) m
  | Psub_rr rd r1 =>
      Next (nextinstr_nf (rs#rd <- (Val.sub rs#rd rs#r1))) m
  | Pimul_ri rd n =>
      Next (nextinstr_nf (rs#rd <- (Val.mul rs#rd (Vint n)))) m
  | Pjmp_l lbl =>
      goto_label f lbl rs m
  | Pcall_s id sg =>
      Next (rs#RA <- (Val.add rs#PC Vone) #PC <- (symbol_offset ge id Int.zero)) m
  | Pret =>
      Next (rs#PC <- (rs#RA) #RA <- Vundef) m
  | Pallocframe sz ofs_ra ofs_link =>
      let (m1, stk) := Mem.alloc m 0 sz in
      let sp := Vptr stk Int.zero in
      match Mem.storev Mint32 m1 (Val.add sp (Vint ofs_link)) rs#ESP with
      | None => Stuck
      | Some m2 =>
          match Mem.storev Mint32 m2 (Val.add sp (Vint ofs_ra)) rs#RA with
          | None => Stuck
          | Some m3 => Next (nextinstr (rs #EDX <- (rs#ESP) #ESP <- sp)) m3
          end
      end
  | Pfreeframe sz ofs_ra ofs_link =>
      match Mem.loadv Mint32 m (Val.add rs#ESP (Vint ofs_ra)) with
      | None => Stuck
      | Some ra =>
          match Mem.loadv Mint32 m (Val.add rs#ESP (Vint ofs_link)) with
          | None => Stuck
          | Some sp =>
              match rs#ESP with
              | Vptr stk ofs =>
                  match Mem.free m stk 0 sz with
                  | None => Stuck
                  | Some m' => Next (nextinstr (rs#ESP <- sp #RA <- ra)) m'
                  end
              | _ => Stuck
              end
          end
      end
...
  end.
