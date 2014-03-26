# Function:     sem_init
# Purpose:      To initialize a semaphore
#
# C Prototype:  int sem_init(sem_t *sem, int pshared, unsigned int value);
# Args:         &sem = rdi
#               pshared = rsi
#               value = rdx
# Return val:   0 on success; -1 on error.
#

        .section .text
        .global sem_init

sem_init:
        push %rbp
        mov  %rsp, %rbp
        mov  %rdx, 0(%rdi)      # set the init value
        mov  $0, %rax           # return 0
        leave
        ret


# Function:     sem_destroy
# Purpose:      To destroy a semaphore
#
# C Prototype:  int sem_destroy(sem_t *sem);
# Args:         &sem = rdi
# Return val:   0 on success; -1 on error.
#

        .section .text
        .global sem_destroy

sem_destroy:
        push %rbp
        mov  %rsp, %rbp
        mov  $-1, %r8
        mov  %r8, 0(%rdi)       # set it to -1 as destruction
        mov  $0, %rax           # return 0
        leave
        ret


# Function:     sem_post
# Purpose:      To unlock a semaphore
#
# C Prototype:  int sem_post(sem_t *sem);
# Args:         &sem = rdi
# Return val:   0 on success; -1 on error and the value is left unchanged.
#

        .section .text
        .global sem_post

sem_post:
        push %rbp
        mov  %rsp, %rbp
        mov  $1, %r8
        mov  %r8, 0(%rdi)       # set it to 1 for unlock
        mov  $0, %rax           # return 0
        leave
        ret


# Function:     sem_wait
# Purpose:      To lock a semaphore
#               decrements (locks) the semaphore pointed to by sem.  If the
#               semaphore's value # is greater than zero, then the decrement
#               proceeds, and the function returns, # immediately.  If the
#               semaphore currently has the value zero, then the call # blocks
#               until either it becomes possible to perform the decrement (i.e.,
#               the # semaphore value rises above zero), or a signal handler
#               interrupts the call.

#
# C Prototype:  int sem_wait(sem_t *sem);
# Args:         &sem = rdi
# Return val:   0 on success; -1 on error and the value is left unchanged.
#

        .section .text
        .global sem_wait

sem_wait:
        push %rbp
        mov  %rsp, %rbp
sem_busy_wait:
        mov  $0, %r8            # r8 = 0
        xchg %r8, 0(%rdi)       # Atomically exchange between r8 and sem
        cmp  $0, %r8            # if r8 == 0 (locked)
        je   sem_busy_wait      # locked, try again

        mov  $0, %rax           # return 0
        leave
        ret
