Record RData :=
  mkRData {
    cb: list Z
  }.

Function cb_init_spec (d: RData) : option RData :=
  Some d {cb: nil}.

Function cb_write_spec (c: Z) (d: RData) : option RData :=
  let buf := cb d in
  if zlt (Zlength buf) CB_SIZE then
    Some d {cb: buf ++ [c]}
  else
    Some d {cb: skipn 1 (buf ++ [c])}.

Function cb_read_spec (d: RData): option (RData * Z) :=
  match (cb d) with
    | nil => Some (d, CB_EMPTY)
    | c :: tl => Some (d {cb: tl}, c)
  end.
