struct TCB {
    uint state;
    uint prev;
    uint next;
};

struct TCB TCBPool[num_proc];

uint get_state(uint proc_index) {
    return TCBPool[proc_index].state;
}

void set_state(uint proc_index, uint state) {
    TCBPool[proc_index].state = state;
}

uint get_prev(uint proc_index) {
    return TCBPool[proc_index].prev;
}

void set_prev(uint proc_index, uint prev) {
    TCBPool[proc_index].prev = prev;
}

uint get_next(uint proc_index) {
    return TCBPool[proc_index].next;
}

void set_next(uint proc_index, uint next) {
    TCBPool[proc_index].next = next;
}

void tcb_init(uint proc_index) {
    TCBPool[proc_index].state = TSTATE_DEAD;
    TCBPool[proc_index].prev = num_proc;
    TCBPool[proc_index].next = num_proc;
}

void thread_init() {
    pt_init_kern();
    uint i = 0;
    while (i < num_proc) {
        tcb_init(i);
        i++;
    }
}
