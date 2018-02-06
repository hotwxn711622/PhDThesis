unsigned int serial_getc () {
  unsigned int rv = 0;
  unsigned int rx;
  if (get_serial_exist()) {
    if (serial_read(COM1 + COM_LSR, BIT1) % 2 == 1) {
      rx = serial_read(COM1 + COM_RX, M_ALL);
      cons_buf_write(rx);
      rv = 1;
    }
  }
  return rv;
}
