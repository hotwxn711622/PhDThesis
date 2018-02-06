Function serial_intr_handler_spec (serial: Abs): option Abs :=
  match (serial.(serial_exist), serial.(irq)) with
  | (true, true)  =>
  	let rxbuf = serial.(RxBuf) in
  	let lrx = serial.(lrx) in
    match last 1 lrx with
    | Recv str =>
      if list_eq_dec Z.eq_dec str rxbuf) then
        if zle (Zlength (serial.(cons_buf) ++ rxbuf) CB_MAX_CHARS
        then Some serial
                  {cons_buf: serial.(cons_buf) ++ rxbuf}
                  {lrx: nextk (lrx, Zlength rxbuf * 2 + 1)}
                  {RxBuf: nil}
                  {irq: false}
        else Some serial
                  {cons_buf: skipn (Z.to_nat (Zlength (serial.(cons_buf) ++ rxbuf)
                                     - CB_MAX_CHARS)) (serial.(cons_buf) ++ rxbuf)}
                  {lrx: nextk (lrx, Zlength rxbuf * 2 + 1)}
                  {RxBuf: nil}
                  {irq: false}
        ...
