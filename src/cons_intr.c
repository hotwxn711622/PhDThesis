void serial_intr_handler () {
  unsigned int hasMore, t = 0;
  hasMore = serial_getc ();
  while (hasMore == 1u && t < CB_SIZE) {
    hasMore = serial_getc ();
    t++;
  }
}<@ \columnbreak @>
void cons_init() {
  cons_buf_init();
  serial_init();
}
