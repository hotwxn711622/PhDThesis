uint pt_insert(uint proc_index, uint vadr, uint padr, uint perm) {
  uint result = 0;
  uint pi = pt_read_pde(proc_index, vadr);
  if(pi == 0) {
    result = pt_alloc_pde(proc_index, vadr);
    if (result == 0)
      result = MagicNumber;
  }
  if (result != MagicNumber) {
    pt_insert_aux(proc_index, vadr, padr, perm);
  }
  return result;
}

uint pt_rmv(uint proc_index, uint vadr) {
  uint padr = pt_read(proc_index, vadr);
  if (padr != 0) {
    pt_rmv_aux(proc_index, vadr);
  }
  return padr;
}

void pt_init_kern() {
  pt_init_comm();
  uint i = MEMLOW / PAGE_SIZE;
  while(i < MEMHIGH / PAGE_SIZE) {
    set_PDE(0, i);
    i ++;
  }
}
