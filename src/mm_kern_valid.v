Definition MM_kern_valid (mm: MMTable) (n size: Z) :=
  exists i s l,
    0 <= i < size /\
    ZMap.get i mm = MMValid s l MMUsable /\ 
    s <= n * PAGESIZE /\ l + s >= ( (n + 1) * PAGESIZE).
