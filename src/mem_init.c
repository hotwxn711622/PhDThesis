void mem_init()
{
    unsigned int i, j, s, l, isnorm, nps, maxs, size, mm, flag;
    boot_loader();
    i = 0;
    size = get_size();

    // compute and set nps
    nps = 0;
    while(i < size) {
        s = get_mms(i);
        l = get_mml(i);
        maxs = (s + l) / PAGESIZE + 1;
        if(maxs > nps)
            nps = maxs;
        i++;
    }
    set_nps(nps);

    // initilize allocation table
    i = 0;
    while(i < nps) {
        if(i < MEMLOW || i >= MEMHIGH)
            set_norm(i, 1);
        else {
            j = 0;
            flag = 0;
            isnorm = 0;
            while(j < size && flag == 0) {
                s = get_mms(j);
                l = get_mml(j);
                isnorm = is_usable(j);
                if(s <= i * PAGESIZE && l + s >= (i + 1) * PAGESIZE)
                    flag = 1;
                j++;
            }
            if(flag == 1 && isnorm == 1)
                set_norm(i, 2);
            else
                set_norm(i, 0);
        }
        i++;
    }
}

