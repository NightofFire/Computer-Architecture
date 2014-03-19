# Function:     Recursive
# Purpose:      Print values of the function R(i,j) defined by
#               the formulas
#
#                   R(i,j) = i - j, if i or j is < 0
#                   R(i,j) = R(i-1, j) + R(i, j-1), otherwise
#
# C Prototype:  long Recursive(long i, long j);
# Args:         i = rdi
#               j = rsi
# Return val:   Recursive(i, j) = rax
#

        .section .text
        .global Recursive

Recursive:
        push %rbp
        mov  %rsp, %rbp

        # Is i < 0?
        cmp  $0, %rdi
        jl   lt_0
        # Is j < 0?
        cmp  $0, %rsi
        jl   lt_0
        # Recursively
        jmp  gt_0

lt_0:
        mov  %rdi, %rax         # rax = i
        subq %rsi, %rax         # rax = i - j
        jmp  done

gt_0:
        push  %rdi              # Save i = rdi
        sub  $1, %rdi           # i = i-1
        call Recursive          # rax = Recursive(i-1, j)
        pop  %rdi               # Restore i
        push %rax               # Save Recursive(i-1, j)

        push %rsi               # Save j = rsi
        sub  $1, %rsi           # j = j-1
        call Recursive          # rax = Recursive(i, j-1)
        pop  %rsi               # Restore j

        pop  %rdx               # rdx = Recursive(i-1, j)
        add  %rdx, %rax         # rax = Recursive(i-1, j) + Recursive(i, j-1)

done:
        leave
        ret
