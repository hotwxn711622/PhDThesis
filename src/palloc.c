unsigned int palloc()
{
    unsigned int tnps, index, is_allocated, is_norm, free_index;

    tnps = get_nps();
    index = 0;
    free_index = tnps;
    while( index < tnps && free_index == tnps )
    {
        is_norm = is_norm(index);
        if( is_norm == 2 )
        {
            is_allocated = at_get(index);
            if( !is_allocated )
                free_index = index;
        }
        index ++;
    }
    if( free_index != tnps )
      at_set(free_index, 1);

    return free_index;
} 
