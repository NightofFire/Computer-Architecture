# Test
        .globl main
main:
        li     $t0, 0
        sw     $t0, 0($sp)      # init lock as locked
        move   $a0, $sp
        jal    sem_post         # call sem_post
        lw     $t0, 0($sp)
        li     $a0, 1           # error code 1
        bne    $t0, 1, done     # check if the lock is unlocked

        li     $t0, 1
        sw     $t0, 0($sp)      # init lock as unlocked
        move   $a0, $sp
        jal    sem_wait         # call sem_wait
        lw     $t0, 0($sp)
        li     $a0, 2           # error code 2
        bne    $t0, 0, done     # check if the lock is locked

        li     $a0, 0           # no error
        b      done             # finished

done:
        li     $v0, 1
        syscall
        li     $v0, 10
        syscall


# Function:     sem_post
# Purpose:      To unlock a semaphore
#
# C Prototype:  int sem_post(sem_t *sem);
# Args:         &sem = a0
# Return val:   0 on success; -1 on error and the value is left unchanged.
#
        .globl  sem_post
sem_post:
        li      $t0, 1
        sw      $t0, 0($a0)     # set it to 1 for unlock
        li      $v0, 0          # return 0
        jr      $ra

# Function:     sem_wait
# Purpose:      To lock a semaphore
#
# C Prototype:  int sem_wait(sem_t *sem);
# Args:         &sem = a0
# Return val:   0 on success; -1 on error and the value is left unchanged.
#
        .globl  sem_wait
sem_wait:
        li      $t0, 0
        ll      $t1, 0($a0)             # linked load sem
        sc      $t0, 0($a0)             # change sem if not changed by others
        beq     $t0, $zero, sem_wait    # if t0 == 0 (changed), try again
        beq     $t1, 0, sem_wait        # if t1 == 0 (locked), try again

        li      $v0, 0                  # return 0
        jr      $ra
