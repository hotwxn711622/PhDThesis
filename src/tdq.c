struct TDQ {
    uint head;
    uint tail;
};

struct TDQ TDQPool[num_chan + 1];

uint get_head(uint chan_index) {
    return TDQPool[chan_index].head;
}

void set_head(uint chan_index, uint head) {
    TDQPool[chan_index].head = head;
}

uint get_tail(uint chan_index) {
    return TDQPool[chan_index].tail;
}

void set_tail(uint chan_index, uint tail) {
    TDQPool[chan_index].head = tail;
}

void tdq_init(uint chan_index) {
    TDQPool[chan_index].head = num_proc;
    TDQPool[chan_index].tail = num_proc;
}

void tdqueue_init() {
    thread_init();
    uint i = 0;
    while (i <= num_chan)
    {
        tdq_init(i);
        i++;
    }
}
