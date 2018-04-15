#define PT_PERM_PTKF 3
#define PT_PERM_PTKT 259

void idpde_init() {

  unsigned int i, j;
  unsigned int perm;

  mem_init();

  i = 0;
  while(i < 1024) {

    if (i < MEMLOW / 1024)
      perm = PT_PERM_PTKT;
    else if (i >= MEMHIGH / 1024)
      perm = PT_PERM_PTKT;
    else
      perm = PT_PERM_PTKF;

    j = 0;
    while(j < 1024) {
      set_IDPTE(i, j, perm);
      j ++;
    }

    i ++;
  }
}
