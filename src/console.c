struct ConsoleBuffer {
 char buffer[CB_SIZE + 1];
 unsigned int rpos;
 unsigned int wpos;
};

// in-memory circular buffer
struct ConsoleBuffer cb;

// console buffer module M
void cb_init() {
 cb.rpos = 0;
 cb.wpos = 0;
}
<@ \columnbreak @>
char cb_read () {
 unsigned int rv = CB_EMPTY;
 if (cb.rpos != cb.wpos) {
  rv = cb.buffer[cb.rpos];
  cb.rpos = (cb.rpos + 1) % CB_SIZE;
 }
 return rv;
}

void cb_write (char c) {
 cb.buffer[cb.wpos] = c;
 cb.wpos = (cb.wpos + 1) % CB_SIZE;
 if (cb.rpos == cb.wpos) {
  cb.rpos = (cb.rpos + 1) % CB_SIZE;
 }
}
