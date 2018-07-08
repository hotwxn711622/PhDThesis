typedef unsigned int uint
#define PT_PERM_UP 0
#define PT_PERM_PTU 7

void set_pt(uint proc_index) {
    set_cr3(PTPool[proc_index]);
}

uint get_PDE(uint proc_index, uint pde_index) {
    return ((uint)PTPool[proc_index][pde_index]) / PAGE_SIZE;
}

void set_PDE(uint proc_index, uint pde_index) {
    PTPool[proc_index][pde_index] = ((char *)(IDPMap[pde_index])) + PT_PERM_PTU;
}

void rmv_PDE(uint proc_index, uint pde_index) {
    PTPool[proc_index][pde_index] = (char *)PT_PERM_UP;
}

void set_PDEU(uint proc_index, uint pde_index, uint pi) {
    PTPool[proc_index][pde_index] = (char *)(pi * PAGE_SIZE + PT_PERM_PTU);
}

uint get_PTE(uint proc_index, uint pde_index, uint vadr) {
    uint offset = (uint)PTPool[proc_index][pde_index] - PT_PERM_PTU;
    return *(uint*)(offset + 4 * vadr);
}

void set_PTE(uint proc_index, uint pde_index, uint vadr, uint padr, uint perm) {
    uint offset = (uint)PTPool[proc_index][pde_index] - PT_PERM_PTU;
    *(uint*)(offset + 4 * vadr) = padr * PAGE_SIZE + perm;
}

void rmv_PTE(uint proc_index, uint pde_index, uint vadr) {
    uint offset = (uint)PTPool[proc_index][pde_index] - PT_PERM_PTU;
    *(uint*)(offset + 4 * vadr) = 0;
}

void set_IDPTE(uint pde_index, uint vadr, uint perm) {
    IDPMap[pde_index][vadr] = (pde_index * 1024 + vadr) * PAGE_SIZE + perm;
}
