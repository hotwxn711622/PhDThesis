Inductive set_serial_exist_low_level_spec : genv -> list val -> mem -> option val -> mem :=
    | set_serial_exist_intro_true ge (m m': mem) (b: block) (v: int):
      find_symbol ge serial_exist = Some b ->
      0 < Int.unsigned v ->
      Mem.store Mint32 m b 0 (Vint Int.one) = Some m' ->
      set_serial_exist_low_level_spec ge (Vint v :: nil) m Vundef m'
    | set_serial_exist_intro_false ge (m m': mem) (b: block) (v: int):
      find_symbol ge serial_exist = Some b ->
      0 = Int.unsigned v ->
      Mem.store Mint32 m b 0 (Vint Int.zero) = Some m' ->
      set_serial_exist_low_level_spec ge (Vint v :: nil) m Vundef m'.
