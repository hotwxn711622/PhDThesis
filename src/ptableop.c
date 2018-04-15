uint pt_read(uint proc_index, uint vaddr) {
    uint pdx_index = vaddr / (4096 * 1024);
    uint pdx_entry = get_PDE(proc_index, pdx_index);
    if (pdx_entry == 0)
      return 0;
    else {
      uint vaddrl = (vaddr / 4096) % 1024;
      return get_PTE(proc_index, pdx_index, vaddrl);
    }
}

uint pt_read_pde(uint proc_index, uint vaddr) {
    uint pdx_index = vaddr / (4096 * 1024);
    return get_PDE(proc_index, pdx_index);
}

void pt_insert_aux(uint proc_index, uint vaddr, uint paddr, uint perm) {
    uint pdx_index = vaddr / (4096 * 1024);
    uint vaddrl = (vaddr / 4096) % 1024;
    set_PTX(proc_index, pdx_index, vaddrl, paddr, perm);
}

void pt_insert_pde(uint proc_index, uint vaddr, uint pi) {
    uint pdx_index = vaddr / (4096 * 1024);
    set_PDEU(proc_index, pdx_index, pi);
}

void pt_rmv_aux(uint proc_index, uint vaddr) {
    uint pdx_index = vaddr / (4096 * 1024);
    uint vaddrl = (vaddr / 4096) % 1024;
    rmv_PTX(proc_index, pdx_index, vaddrl);
}

void pt_rmv_pde(uint proc_index, uint vaddr) {
    uint pdx_index = vaddr / (4096 * 1024);
    rmv_PDE(proc_index, pdx_index);
}
