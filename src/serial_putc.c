void serial_putc (unsigned int c) {
 unsigned int lsr = 0, i;
 if ( get_serial_exist() ){
  for (i = 0;	!lsr && i < 12800; i++) {
   lsr = serial_read(0x3FD) & 0x20;
   delay();
  }
  serial_write (0x3F8, c);
  ...
}
<@ \columnbreak @>
unsigned int serial_getc () {
 unsigned int rv = 0;
 unsigned int rx;
 if (get_serial_exist()) {
  if (serial_read(COM1+COM_LSR, BIT1)%2==1) {
   rx = serial_read(COM1+COM_RX, M_ALL);
   cb_write(rx);
   ...
}
