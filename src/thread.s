    .globl thread_sched
thread_sched:
        movr    num_chan, %eax
        movl    %eax, (%esp) // arguments for dequeue (num_chan)
        call    dequeue

        movl    %eax, 0(%esp) // return vaule :last l, also the arguments
        movr    1, %eax
        movl    %eax, 4(%esp) // arguements for set_state (last l, 1)
        call    set_state

        call    get_curid
        movl    %eax, 4(%esp) // save cid

        call    set_curid // argument is already there, set_curid (last l)

        movl    0(%esp), %edx
        movl    4(%esp), %eax
        jmp kctxt_switch
