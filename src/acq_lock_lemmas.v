Lemma WaitTicketWraparoundStops: forall bound cpu b ticket l l',
    WaitTicketWraparound bound cpu b ticket l = Some l' ->
    exists k,
        (k <= bound)%nat /\
        (forall n, (0 <= n < k)%nat -> WaitTicketWraparound n cpu b ticket l = None) /\
        WaitTicketWraparound k cpu b ticket l = Some l' /\
        forall j, (k <= j)%nat -> WaitTicketWraparoundSafe j cpu b ticket l = l'.

Lemma WaitTicketWraparoundImpliesSafe: forall bound cpu b ticket l l',
    WaitTicketWraparound bound cpu b ticket l = Some l' ->
    WaitTicketWraparoundSafe bound cpu b ticket l = l'.

Lemma WaitTicketWraparoundSafeInv: forall bound cpu b ticket l l',
    WaitTicketWraparoundSafe (S bound) cpu b ticket l = Some l' ->
    (forall j, (j < (S bound))%nat -> WaitTicketWraparound j cpu b ticket l = None) ->
    exists l'',
        WaitTicketWraparoundSafe bound cpu b ticket l = l'' /\
        WaitTicketWraparoundSafe 1 cpu b ticket l'' = l'.

Lemma WaitTicketWraparoundSafeNeq: forall bound cpu b ticket l l' ticket now tl,
    WaitTicketWraparound bound cpu b ticket l = None ->
    WaitTicketWraparoundSafe bound cpu b ticket l = l' ->
    (bound > 0)%nat ->
    ReplayTicketWraparound l' = Some (ticket, now, tl) ->
    now <> ticket.

Lemma WaitTicketWraparoundEq: forall bound cpu b ticket l l' ticket' now tl,
    WaitTicketWraparound bound cpu b ticket l = Some l' ->
    ReplayTicketWraparound l' = Some (ticket', now, tl) ->
    now = ticket.
