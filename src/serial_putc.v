Function serial_putc_spec (c: Z) (serial: Abs): option Abs :=
 match (serial.critical, serial.serial_exist) with
 | (true, true) => 
   match serial with
   | mkDevData
     (mkSerialState TxBuf _ _ true base _ false baud db sb par fifo modem) =>
     if config_ok baud db sb par fifo modem then
     match TxBuf with
     | nil =>
       if Z.eq_dec c CHAR_LF
       then Some (serial {TxBuf: CHAR_LF::CHAR_CR::nil} {ltx: snd (next (serial.ltx)) }})
       else Some (serial {TxBuf: c::nil} {ltx: snd (next (serial.ltx))})
     | _ =>
       if Z.eq_dec c CHAR_LF
       then Some (serial {TxBuf: CHAR_LF::CHAR_CR::nil} 
                    {ltx: (next_sendcomplete (serial.ltx))})
       else Some (serial {TxBuf: c :: nil} {ltx: (next_sendcomplete (serial.ltx))})
     end
     else None
     ...
