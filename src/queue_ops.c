void enqueue(uint chan_index, uint proc_index) {
    uint tail = get_tail(chan_index);
    if(tail == num_proc) {
        set_prev(proc_index, num_proc);
        set_next(proc_index, num_proc);
        set_head(chan_index, proc_index);
        set_tail(chan_index, proc_index);
    }
    else {
        set_next(tail, proc_index);
        set_prev(proc_index, tail);
        set_next(proc_index, num_proc);
        set_tail(chan_index, proc_index);
    }
}

uint dequeue(uint chan_index) {
    uint proc_index = num_proc;
    uint head = get_head(chan_index);
    if(head != num_proc) {
        proc_index = head;
        uint next = get_next(head);
        if(next == num_proc) {
            set_head(chan_index, num_proc);
            set_tail(chan_index, num_proc);
        }
        else {
            set_prev(next, num_proc);
            set_head(chan_index, next);
        }
    }
    return proc_index;
}
