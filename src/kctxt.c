istruct KCtxtStruct {
    void * ESP;
    void * EDI;
    void * ESI;
    void * EBX;
    void * EBP;
    void * RA;
};

struct KCtxtStruct KCtxtPool[num_proc];

void set_SP(uint proc_index, void * esp) {
    KCtxtPool[proc_index].ESP = esp;
}

void set_RA(uint proc_index, void * entry) {
    KCtxtPool[proc_index].RA = entry;
}
