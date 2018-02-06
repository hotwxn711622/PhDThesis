struct ticket_lock {
  volatile uint n, t;
};

// Primitives provided by the lower layer
extern uint get_n(uint b);
extern void inc_n(uint b);
extern void FAI_t(uint b);
extern void pull(uint b);
extern void push(uint b);

void acq_lock (uint b) { 
  uint myt = FAI_t(b);
  while (get_n(b) != myt) {};
  pull(b); // hold the block
}

void rel_lock (uint b) {
  push(b); // release the block
  inc_n(b);
}
