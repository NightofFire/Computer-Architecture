## readin three ints, a, b, c
## print out a+b-c
        .globl   main
main:
        ## read integer a
        li       $v0, 5
        syscall
        move     $t0, $v0
        ## read integer b
        li       $v0, 5
        syscall
        add      $t0, $t0, $v0   # a = a + b
        ## read integer c
        li       $v0, 5
        syscall
        sub      $t0, $t0, $v0   # a = a - c
        ## print out
        li       $v0, 1
        move     $a0, $t0
        syscall
        ## exit
        li       $v0, 10
        syscall
