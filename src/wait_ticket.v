Fixpoint WaitTicket (bound: nat) (cpu b ticket: Z) (l: list Event) :=
  match bound with
    | O => None
    | S k =>
      let l' := (E_GET_NOW cpu b) :: (EnvCtxt cpu l) ++ l in
      match ReplayTicket l' with
        | _, now =>
            if zeq ticket now then 
                Some l'
            else
                WaitTicket k cpu b ticket l'
      end
  end.
