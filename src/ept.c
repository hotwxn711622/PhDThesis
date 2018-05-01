uint get_EPTE(uint pml4_idx, uint pdpt_idx, uint pdir_idx, uint ptab_idx) {
    return (uint) EPT.ptab[pdpt_idx][pdir_idx][ptab_idx];
}

void set_EPTE(uint pml4_idx, uint pdpt_idx, uint pdir_idx, uint ptab_idx, uint hpa_val) {
    EPT.ptab[pdpt_idx][pdir_idx][ptab_idx] = (unsigned long long)hpa_val;
}

void set_EPDPTE(uint pml4_idx, uint pdpt_idx) {
    EPT.pdpt[pdpt_idx * 2 + 1] = 0;
    EPT.pdpt[pdpt_idx * 2] = (char *) (&EPT.pdt[pdpt_idx][0]) + 7;
}

void set_EPDTE(uint pml4_idx, uint pdpt_idx, uint pdir_idx) {
    EPT.pdt[pdpt_idx][pdir_idx * 2 + 1] = 0;
    EPT.pdt[pdpt_idx][pdir_idx * 2] = (char *) (&EPT.ptab[pdpt_idx][pdir_idx][0]) + 7;
}

void set_EPML4E(uint pml4_idx) {
    EPT.pml4[1] = 0;
    EPT.pml4[0] = (char *) (EPT.pdpt) + 7;
}


