uint ept_get_page_entry(uint gpa) {
  uint pdpt = gpa / (512 * 512) % 512;
  uint pdir = gpa / 512 % 512;
  uint ptab = gpa % 512;
  uint entry = get_EPTE(0, pdpt, pdir, ptab);
  return entry;
}

void ept_set_page_entry(uint gpa, uint hpa) {
  uint pdpt = gpa / (512 * 512) % 512;
  uint pdir = gpa / 512 % 512;
  uint ptab = gpa % 512;
  set_EPTE(0, pdpt, pdir, ptab, hpa);
}

void ept_add_mapping(uint gpa, uint hpa, uint mem_type) {
  uint pdpt = gpa / (1024 * 1024 * 1024) % 512;
  uint pdir = gpa / (2 * 1024 * 1024) % 512;
  uint ptab = gpa / (4 * 1024) % 512;
  set_EPTE (0, pdpt, pdir, ptab,
        (hpa & EPT_ADDR_MASK) | EPT_PG_IGNORE_PAT_or_PERM
           | (((unsigned char) mem_type) << EPT_PG_MEMORY_TYPE));
}

void ept_init() {
  proc_init();
  set_EPML4E(0);
  uint i = 0;
  while(i < 4) {
    set_EPDPTE(0, i);
    uint j = 0;
    while (j < 512) {
      set_EPDTE(0, i, j);
      j ++;
    }
    i ++;
  }
}
