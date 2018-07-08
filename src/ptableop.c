uint pt_read(uint proc_index, uint vaddr) {
    uint pde_index = vaddr / (4096 * 1024);
    uint pde_entry = get_PDE(proc_index, pde_index);
    if (pde_entry == 0)
      return 0;
    else {
      uint pte_index = (vaddr / 4096) % 1024;
      return get_PTE(proc_index, pde_index, pte_index);
    }
}

uint pt_read_pde(uint proc_index, uint vaddr) {
    uint pde_index = vaddr / (4096 * 1024);
    return get_PDE(proc_index, pde_index);
}

void pt_insert_aux(uint proc_index, uint vaddr, uint paddr, uint perm) {
    uint pde_index = vaddr / (4096 * 1024);
    uint pte_index = (vaddr / 4096) % 1024;
    set_PTE(proc_index, pde_index, pte_index, paddr, perm);
}

void pt_insert_pde(uint proc_index, uint vaddr, uint pi) {
    uint pde_index = vaddr / (4096 * 1024);
    set_PDEU(proc_index, pde_index, pi);
}

void pt_rmv_aux(uint proc_index, uint vaddr) {
    uint pde_index = vaddr / (4096 * 1024);
    uint pte_index = (vaddr / 4096) % 1024;
    rmv_PTE(proc_index, pde_index, pte_index);
}

void pt_rmv_pde(uint proc_index, uint vaddr) {
    uint pde_index = vaddr / (4096 * 1024);
    rmv_PDE(proc_index, pde_index);
}
