Ltac isn_evar v t := match v with
                       | _ => is_evar v; fail 2
                       | _ => t
                     end.
Ltac hasn_evar e t := match v with
                       | _ => has_evar e; fail 2
                       | _ => t
                      end.
Ltac seassumption := match goal with 
                        | [|- ?le ! _ = Some _] => isn_evar le eassumption
                        | [|- 0 <= ?x <= Int.max_unsigned] => hasn_evar x eassumption
                        | [|- 0 <= ?x <= Int64.max_unsigned] => hasn_evar x eassumption
                        | [|- 0 <= ?x] => hasn_evar x eassumption
                        | [|- ?x <= Int.max_unsigned] => hasn_evar x eassumption
                        | [|- ?x <= Int64.max_unsigned] => hasn_evar x eassumption
                        | _ => eassumption
                     end.
Ltac sreflexivity := match goal with
                        | [|- _ <= _] => fail 1
                        | [|- _ >= _] => fail 1
                        | _ => reflexivity
                     end.

Ltac simpleproof := assumption || omega || trivial || sreflexivity || seassumption || auto.
