  Inductive cb_init_lspec: genv -> list val -> mem * RData -> option val -> mem * RData :=
    cb_init_spec_low_intro ge (m m0 m': mem) (d: RData) b:
      find_symbol ge cb = Some b ->
      Mem.store Mint32 m b (CB_SIZE * 4) (Vint (Int.zero)) = Some m0 ->
      Mem.store Mint32 m0 b ((CB_SIZE + 1) * 4) (Vint (Int.zero)) = Some m' ->
      cb_init_lspec ge nil (m, d) Vundef (m', d).

  Inductive cb_write_lspec: genv -> list val -> mem * RData -> option val -> mem * RData :=
  | cb_write_spec_low_intro1 ge (m m0 m': mem) (d: RData) b rpos wpos wpos' c:
      find_symbol ge cb = Some b ->
      Mem.load Mint32 m b ((CB_SIZE + 1) * 4) = Some (Vint wpos) ->
      0 <= Int.unsigned wpos < CB_SIZE ->
      Mem.store Mint32 m b (Int.unsigned wpos * 4) (Vint c) = Some m0 ->
      wpos' = Int.repr ((Int.unsigned wpos + 1) mod CB_SIZE) ->
      Mem.load Mint32 m b (CB_SIZE * 4) = Some (Vint rpos) ->
      Int.unsigned wpos' <> Int.unsigned rpos ->
      Mem.store Mint32 m0 b ((CB_SIZE + 1) * 4) (Vint wpos') = Some m' ->
      cb_write_lspec ge (Vint c :: nil) (m, d) Vundef (m', d)
  | cb_write_spec_low_intro2 ge (m m0 m1 m': mem) (d: RData) b rpos rpos' wpos wpos' c:
      find_symbol ge cb = Some b ->
      Mem.load Mint32 m b ((CB_SIZE + 1) * 4) = Some (Vint wpos) ->
      0 <= Int.unsigned wpos < CB_SIZE ->
      Mem.store Mint32 m b (Int.unsigned wpos * 4) (Vint c) = Some m0 ->
      wpos' = Int.repr ((Int.unsigned wpos + 1) mod CB_SIZE) ->
      Mem.store Mint32 m0 b ((CB_SIZE + 1) * 4) (Vint wpos') = Some m1 ->
      Mem.load Mint32 m b (CB_SIZE * 4) = Some (Vint rpos) ->
      Int.unsigned wpos' = Int.unsigned rpos ->
      rpos' = Int.repr ((Int.unsigned rpos + 1) mod CB_SIZE) ->
      Mem.store Mint32 m1 b (CB_SIZE * 4) (Vint rpos') = Some m' ->
      cb_write_lspec ge (Vint c :: nil) (m, d) Vundef (m', d).

  Inductive cb_read_lspec: genv -> list val -> mem * RData -> option val -> mem * RData :=
  | cb_read_spec_low_intro1 ge (m: mem) (d: RData) b rpos wpos:
      find_symbol ge cb = Some b ->
      Mem.load Mint32 m b (CB_SIZE * 4) = Some (Vint rpos) ->
      Mem.load Mint32 m b ((CB_SIZE + 1) * 4) = Some (Vint wpos) ->
      Int.unsigned rpos = Int.unsigned wpos ->
      cb_read_lspec ge nil (m, d) (Vint Int.zero) (m, d)
  | cb_read_spec_low_intro2 ge (m m': mem) (d: RData) b rpos wpos c:
      find_symbol ge cb = Some b ->
      Mem.load Mint32 m b (CB_SIZE * 4) = Some (Vint rpos) ->
      Mem.load Mint32 m b ((CB_SIZE + 1) * 4) = Some (Vint wpos) ->
      Int.unsigned rpos <> Int.unsigned wpos ->
      Mem.load Mint32 m b ((Int.unsigned rpos) * 4) = Some (Vint c) ->
      Mem.store Mint32 m b (CB_SIZE * 4)
                        (Vint (Int.repr((Int.unsigned rpos + 1) mod CB_SIZE))) = Some m' ->
      0 <= Int.unsigned rpos < CB_SIZE ->
      cb_read_lspec ge nil (m, d) (Vint c) (m', d).
