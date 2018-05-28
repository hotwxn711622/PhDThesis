#define KSTACK_SIZE     4096
#define KSTACK_MAGIC    0x98765432

struct kstack
{
    // Since the x86 processor finds the TSS from a descriptor in the GDT,
    // each processor needs its own TSS segment descriptor in some GDT.
    // We could have a single, "global" GDT with multiple TSS descriptors,
    // but it's easier just to have a separate fixed-size GDT per CPU.
    segdesc_t gdt[CPU_GDT_NDESC];

    // Each CPU needs its own TSS,
    // because when the processor switches from lower to higher privilege,
    // it loads a new stack pointer (ESP) and stack segment (SS)
    // for the higher privilege level from this task state structure.
    tss_t tss;

    uint32_t cpu_idx;
    uint32_t magic;

    uint8_t kstack_lo[1];
    uint8_t kstack_hi[0] gcc_aligned(KSTACK_SIZE);
};
