Function putc_scan_log (t: log)(bound: nat): option log :=
 match bound with
 | O => None
 | S bound' =>
   match next (t, SerialEnv) with
   | (SendingCompAck, t') => Some t'
   | (_, t') => putc_scan_log t' bound'
   end
 end.
<@ \columnbreak @>
Definition next_sendcomplete (t: log) :=
 match putc_scan_log t 12800%nat with
 | None => nextk (t, 12800)
 | Some i => next i
 end.