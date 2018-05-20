uint thread_spawn(void * entry) {
    uint i = kctxt_new(entry);
    set_state(i, READY);
    enqueue(num_chan, i);
    return i;
}

void thread_wakeup(uint chan_index) {
    uint proc_index = dequeue(chan_index);
    if(proc_index != num_proc) {
        set_state(proc_index, READY);
        enqueue(num_chan, proc_index);
    }
}

void sched_init() {
    tdqueue_init();
    set_curid(0);
    set_state(0, RUN);
}
