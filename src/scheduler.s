    .globl thread_yield
thread_yield:
        call    get_curid
        movr    %eax, %edx
        movl    %edx, 0(%esp) // save cid

        movr    0, %eax
        movl    %eax, 4(%esp) // arguements for set_state (cid, 1)
        call    set_state

        movr    num_chan, %eax
        movl    %eax, (%esp)
        movl    %edx, 4(%esp) // arguments for enqueue (num_chan, cid)
        call    enqueue

        jmp     thread_sched
