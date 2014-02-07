## read in two integers and compare them
        .text
        .globl   main
main:
        ## read integer a
        li       $v0, 5
        syscall
        move     $t0, $v0
        ## read integer b
        li       $v0, 5
        syscall
        move     $t1, $v0
        ## compare them
        ## gt
        la       $a0, gt_msg
        bgt      $t0, $t1, print
        ## eq
        la       $a0, eq_msg
        beq      $t0, $t1, print
        ## lt
        la       $a0, lt_msg
        j        print
print:
        ## print out
        li       $v0, 4
        syscall
        ## exit
        li       $v0, 10
        syscall

        .data
gt_msg: .asciiz "First is greater than second.\n"
eq_msg: .asciiz "They're equal.\n"
lt_msg: .asciiz "First is less than second.\n"
