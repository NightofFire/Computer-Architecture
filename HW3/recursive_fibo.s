## use recursion to compute the nth Fibonacci number
        .globl  main
main:
        ## save up $ra
        subu    $sp, $sp, 4
        sw      $ra, 0($sp)
        ## read in n
        li      $v0, 5
        syscall
        ## n = $a0, call fibo
        move    $a0, $v0
        jal     fibo
        ## return fibo(n) = $v0
        move    $a0, $v0
        li      $v0, 1
        syscall
        ## restore $ra
        lw      $ra, 0($sp)
        addu    $sp, $sp, 4
        ## exit
        li      $v0, 10
        syscall
fibo:   # n = $a0, fibo(n) = $v0
        ## if n==0, return n
        li      $t0, 1
        bgt     $a0, $t0, fibo_rec
        move    $v0, $a0
        jr      $ra
fibo_rec:
        ## save up 0()=$ra, 4()=$a0=n, 8()=fibo(n-1)
        subu    $sp, $sp, 12
        sw      $a0, 4($sp)
        sw      $ra, 0($sp)
        ## call fibo(n-1)
        subi    $a0, $a0, 1
        jal     fibo
        sw      $v0, 8($sp)
        ## call fibo(n-2)
        lw      $a0, 4($sp)
        subi    $a0, $a0, 2
        jal     fibo
        ## add fibo(n-1) and fibo(n-2) to $v0
        lw      $a0, 8($sp)     #n-1
        add     $v0, $a0, $v0   #n-2
        ## restore $ra
        lw      $ra, 0($sp)
        addu    $sp, $sp, 12
        ## return
        jr      $ra
