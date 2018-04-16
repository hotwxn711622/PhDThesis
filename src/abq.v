Inductive AbQueue :=
| AbQUndef
| AbQValid (l: list Z).

Definition AbQueuePool := ZMap.t AbQueue.

Inductive AbTCB :=
| AbTCBUndef
| AbTCBValid (tds: ThreadState) (inQ: Z).

Definition AbTCBPool := ZMap.t AbTCB.

Function enqueue_spec (n i: Z) (adt: RData): option RData :=
  match (ikern adt, pg adt, ihost adt, ipt adt) with
   | (true, true, true, true) =>
     if Queue_arg n i then
      match (ZMap.get n (abq adt), ZMap.get i (pb adt))  with
       | (AbQValid l, PTTrue) =>
         match (ZMap.get i (abtcb adt)) with
          | AbTCBValid st b =>
            if zeq b (-1) then
              Some adt {abtcb: ZMap.set i (AbTCBValid st n) (abtcb adt)}
              {abq: ZMap.set n (AbQValid (i::l)) (abq adt)}
            else None
          | _ => None end
       | _ => None end
     else None
   | _ => None end.

Function dequeue_spec (n: Z) (adt: RData): option (RData * Z) :=
  match (ikern adt, pg adt, ihost adt, ipt adt) with
   | (true, true, true, true) =>
     if zle_le 0 n num_chan then
      match (ZMap.get n (abq adt)) with
       | AbQValid l => let la := last l num_proc in
         if zeq la num_proc then Some (adt, la)
         else match (ZMap.get la (abtcb adt)) with
              | AbTCBValid st _ =>
                Some (adt {abtcb: ZMap.set la (AbTCBValid st (-1)) (abtcb adt)}
                {abq: ZMap.set n (AbQValid (remove zeq la l)) (abq adt)}, la)
              | _ => None end
       | _ => None end
     else None
   | _ => None end.
