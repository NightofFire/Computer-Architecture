## Fibonacci program
        .global main
main:
        ## read in n
        li      $v0, 5
        syscall
        move    $t0, $v0
        ## init t1,t2
        li      $t1, 0
        li      $t2, 1
loop:   ## while (i--)
        addi    $t0, $t0, -1
        beq     $t0, $zero, finish
        ## fibonacci
        add     $t3, $t1, $t2
        move    $t1, $t2
        move    $t2, $t3
        j       loop
finish:
        move    $a0, $t2
        li      $v0, 1
        syscall
        li      $v0, 10
        syscall
