uint ept_gpa_to_hpa(uint gpa) {
    uint result;
    uint entry = ept_get_page_entry(gpa);

    // perm = EPT_PG_RD | EPT_PG_WR | EPT_PG_EX = 7
    if ((entry & 7) == 0)
        result = 0;
    else
        result = (entry & 0xfffff000) | (gpa & 4095);

    return result;
}

uint ept_mmap(uint gpa, uint hpa, uint mem_type) {
    uint result;
    uint pg_entry = ept_get_page_entry(gpa);

    if ((pg_entry & 7) == 0)
        result = ept_add_mapping(gpa, hpa, mem_type);
    else
        result = 1;

    return result;
}

void ept_set_permission(uint gpa, uint perm) {
    uint entry = ept_get_page_entry(gpa);

    ept_set_page_entry(gpa, (entry & 0xfffff000) | (perm & 7));
}
