Function disable_irq (ioapic: Abs) 
  (n: nat): Abs :=
  (ioapic {irqs[n]: T_IRQ0 + Z.of_nat n} 
  	      {masks[n]: true}).

Fixpoint ioapic_init_aux (ioapic: Abs) 
 (n: nat): Abs :=
 match n with
 | O => disable_irq ioapic 0
 | S n' => 
   let ioapic' := (ioapic_init_aux ioapic n') in
   disable_irq ioapic' n
 end.
<@ \columnbreak @>
Function ioapic_init_spec (ioapic: Abs) 
 : option Abs :=
 match ioapic.init with
 | false =>
  let n := ioapic.MaxIntr + 1 in
  if zeq n (Zlength ioapic.irqs)
  then
   if zeq n (Zlength ioapic.masks) then
    Some (ioapic_init_aux ioapic (Z.to_nat (n - 1)))
   else
    None
   ...
