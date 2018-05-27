struct ticket_lock {
  volatile uint now, ticket;
};

// Primitives provided by the lower layer
extern uint get_now(uint b);
extern void inc_now(uint b);
extern void FAI_ticket(uint b);
extern void pull(uint b);
extern void push(uint b);

void acq_lock (uint b) { 
  uint myt = FAI_ticket(b);
  while (get_now(b) != myt) {};
  pull(b); // hold the block
}

void rel_lock (uint b) {
  push(b); // release the block
  inc_now(b);
}
