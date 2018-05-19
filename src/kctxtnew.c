uint kctxt_new(void * entry) {
    uint proc_index = pt_new();
    if (proc_index == num_proc) {
        return num_proc;
    }
    else {
        set_SP(proc_index, & STACK_LOC[proc_index][PAGE_SIZE - 4]);
        set_RA(proc_index, entry);
        return proc_index;
    }
}
