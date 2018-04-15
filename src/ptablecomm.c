uint pt_alloc_pde(uint proc_index, uint vadr) {
  uint pi = palloc();
  if (pi != 0) {
    pt_insert_pde(proc_index, vadr, pi);
    uint pde_index = vadr / (PAGE_SIZE * 1024);
    uint i = 0;
    while (i < 1024) {
      rmv_PTE(proc_index, pde_index, i);
      i ++;
    }
  }
  return pi;
}

void pt_free_pde(uint proc_index, uint vadr) {
  uint pi = pt_read_pde(proc_index, vadr);
  pt_rmv_pde(proc_index, vadr);
  pfree(pi);
}

void pt_init_comm() {
  idpde_init();
  uint i = 0;
  while(i < num_proc) {
    uint j = 0;
    while(j < 1024) {
      if (j < MEMLOW / 1024)
        set_PDE(i, j);
      else if(j >= MEMHIGH / 1024)
        set_PDE(i, j);
      else
        rmv_PDE(i, j);
      j++;
    }
    i++;
  }
}
