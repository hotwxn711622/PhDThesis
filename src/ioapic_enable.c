void ioapic_enable (uint32_t irq, 
uint32_t lapicid, uint32_t trigger_mode, 
uint32_t polarity) {
 int maxintr = (ioapic_read (IOAPIC_VER)
                          >> 16)&(0xff);
 if (irq >= gsi && irq <= gsi + maxintr)
 {
  uint32_t i = IOAPIC_TBL + 2*(irq-gsi);
  ioapic_write (i, ((trigger_mode<<15) + (polarity<<13) + (T_IRQ0 + irq)));
  ioapic_write (i + 1, lapicid << 24);
 }
}<@ \columnbreak @>
Function ioapic_enable_spec (irq: Z) 
(lapicid: Z) (trigger: Z) (polarity: Z) 
(ioapic: Abs): option Abs :=
 match ioapic.init with
 | true =>
   if config_ok irq lapicid trigger polarity then
   	let idx := Z.to_nat irq in
    Some (ioapic
          {irqs[idx]: irq + IRQ0}
          {IoApicEnables[idx]: true})
   else None
   ...
