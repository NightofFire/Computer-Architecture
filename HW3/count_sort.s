### Author:     Wanzhang Sheng
### Purpose:    Count sort of a list of ints
###
        .text
        .globl  main
main:
        ## 404()=ra, 400()=n, 0~396()=list
        subu    $sp, $sp, 408
        sw      $ra, 404($sp)   # save up $ra
        ## read in n
        li      $v0, 5
        syscall
        sw      $v0, 400($sp)   # save n
        ## read the list
        move    $a0, $sp        # &list[0]
        lw      $a1, 400($sp)   # n
        jal     read_list
        ## count sort
        li      $t7, 999        # TODO:test
        move    $a0, $sp        # &list[0]
        lw      $a1, 400($sp)   # n
        jal     count_sort
        ## print the list
        move    $a0, $sp        # &list[0]
        lw      $a1, 400($sp)   # n
        jal     print_list
        ## restore ra and cleanup
        lw      $ra, 404($sp)
        addu    $sp, $sp, 408
        ## exit
        li      $v0, 10
        syscall

read_list: # FUNCTION: a0=list[0], a1=n
        li      $t0, 0          # i
read_loop:
        bge     $t0, $a1, read_list_done # t0 >= a1
        ## read in list[i]
        li      $v0, 5
        syscall
        ## save list[i]
        sll     $t1, $t0, 2              # &list[i] - &list[0]
        add     $t1, $t1, $a0            # &list[i]
        sw      $v0, 0($t1)     # save to *&list[i]
        ## loop
        addi    $t0, $t0, 1
        j       read_loop
read_list_done: # return
        jr      $ra

print_list: # FUCTION: a0=&list[0], a1=n
        ## save s0 and s1
        subu    $sp, $sp, 8
        sw      $s1, 4($sp)     # save s1
        sw      $s0, 0($sp)     # save s0
        ## store a0, a1
        move    $s0, $a0
        move    $s1, $a1
        ## start the loop
        li      $t0, 0          # i
print_loop:
        bge     $t0, $s1, print_list_done # t0 >= a1
        ## locate list[i]
        sll     $t1, $t0, 2     # &list[i] - &list[0]
        add     $t1, $t1, $s0   # &list[i]
        ## print list[i]
        lw      $a0, 0($t1)
        li      $v0, 1
        syscall
        ## print a space
        la      $a0, space
        li      $v0, 4
        syscall
        ## loop
        addi    $t0, $t0, 1
        j       print_loop
print_list_done: # return
        ## print a newline
        la      $a0, newline
        li      $v0, 4
        syscall
        ## restore s0 and s1
        lw      $s0, 0($sp)     # restore s0
        lw      $s1, 4($sp)     # restore s1
        addu    $sp, $sp, 8     # clean up
        jr      $ra             # return

count_sort: # FUNCTION: a0=&list[0], a1=n
        subu    $sp, $sp, 416   # list[100] + s0 + s1 + s2 + ra
        sw      $ra, 412($sp)   # save ra
        sw      $s2, 408($sp)   # save s2
        sw      $s1, 404($sp)   # save s1
        sw      $s0, 400($sp)   # save s0
        ## save a0, a1
        move    $s0, $a0        # s0=&list[0]
        move    $s1, $a1        # s1=n
        ## start loop
        li      $s2, 0          # s2=i
count_sort_loop:
        bge     $s2, $s1, count_sort_done # i>=n
        ## find_pos
        sll     $t0, $s2, 2     # &list[i] - &list[0]
        add     $t0, $t0, $s0   # &list[i]
        lw      $a0, 0($t0)     # a0=list[i]
        move    $a1, $s2        # a1=i
        move    $a2, $s0        # a2=&list[0]
        move    $a3, $s1        # a3=n
        jal     find_pos
        ## get &new_list[loc]
        sll     $t0, $v0, 2     # &new[loc] - &new[0]
        add     $t0, $t0, $sp   # &new[loc]
        ## get list[i]
        sll     $t1, $s2, 2     # &list[i] - &list[0]
        add     $t1, $t1, $s0   # &list[i]
        lw      $t1, 0($t1)     # list[i]
        ## new_list[loc] = list[i]
        sw      $t1, 0($t0)     # new_list[loc] = list[i]
        addi    $s2, $s2, 1     # i++
        j       count_sort_loop
count_sort_done:
        ## copy_list
        move    $a0, $sp        # &new_list
        move    $a1, $s0        # &list
        move    $a2, $s1        # n
        jal     copy_list
        ## clean up
        lw      $s0, 400($sp)
        lw      $s1, 404($sp)
        lw      $s2, 408($sp)
        lw      $ra, 412($sp)
        addu    $sp, $sp, 416
        ## return
        jr      $ra             # return count_sort

find_pos: # FUNCTION: a0=val, a1=i, a2=&list, a3=n
        li      $t0, 0        # j
        li      $t1, 0        # count
find_pos_loop:
        bge     $t0, $a3, find_pos_done
        ## get list[j]
        sll     $t3, $t0, 2     # &list[j] - &list
        add     $t3, $t3, $a2   # &list[j]
        lw      $t3, 0($t3)     # list[j]
        ## if (list[j] < val) count++
        blt     $t3, $a0, find_pos_count # if (list[j] < val)
        ## if (list[j] != val) next
        bne     $t3, $a0, find_pos_next
        ## if (list[j] == val && j < i) count++
        blt     $t0, $a1, find_pos_count
        j       find_pos_next
find_pos_count: # count++
        addi    $t1, $t1, 1          # count++
find_pos_next:
        addi    $t0, $t0, 1
        j       find_pos_loop
find_pos_done:
        move    $v0, $t1        # return count
        jr      $ra

copy_list: # FUNCTION: a0=&new_list, a1=&list, a2=n
        li      $t0, 0          # i
copy_list_loop:
        bge     $t0, $a2, copy_list_done # i>=n
        ## get new_list[i]
        sll     $t1, $t0, 2     # &new_list[i] - &new_list
        add     $t1, $t1, $a0   # &new_list[i]
        lw      $t1, 0($t1)     # new_list[i]
        ## get &list[i]
        sll     $t2, $t0, 2     # &list[i] - &list
        add     $t2, $t2, $a1   # &list[i]
        ## list[i] = new_list[i]
        sw      $t1, 0($t2)     # list[i] = new_list[i]
        ## next
        addi    $t0, $t0, 1          # i++
        j       copy_list_loop
copy_list_done:
        jr      $ra

        .data
space:   .asciiz " "
newline: .asciiz "\n"
