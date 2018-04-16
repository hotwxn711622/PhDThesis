uint pt_resv(uint proc_index, uint vaddr, uint perm) {
    uint result;
    uint pi = palloc(proc_index);
    if (pi == 0)
      result = MagicNumber;
    else
      result = pt_insert(proc_index, vaddr, pi, perm);
    return result;
}

void pmap_init() {
    pt_init();
    set_bit(0, 1);
    uint i = 1;
    while(i < num_proc)
    {
        set_bit(i, 0);
        i++;
    }
}
