void ioapic_init(void) {
 int j = 0;
 int maxintr = ioapic_read(1)>>24;
 while(j <= maxintr) {
  ioapic_write(0x10+2*j,0x10000|gsi+j);
  ioapic_write(0x10+2*j+1,0);
 }
}
<@ \columnbreak @>
void ioapic_mask (unsigned int n)
{
 unsigned int r;
 int m = ioapic_read(1)>>24;
 if (n>=gsi && n<=gsi + m) {
  r = ioapic_read(0x10+2*(n-gsi));
  r |= 0x10000;
  ioapic_write (0x10+2*(n-gsi),r);
 }
}

