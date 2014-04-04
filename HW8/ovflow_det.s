# Author:       Wanzhang Sheng
#
# Function:     Overflow
# Purpose:      Determine whether the sum of the two arguments has
#               overflowed.
#
# C Prototype:  long Overflow(long m, long n);
# Input args:   rdi = m, rsi = n
# Ret val:      0 if the sum doesn't overflow, nonzero otherwise
#

        .section .text
        .global Overflow

Overflow:
        push    %rbp
        mov     %rsp, %rbp

        addq    %rsi, %rdi      # rdi = m + n
        jo      over
        mov     $0, %rax        # return 0
        jmp     done
over:
        mov     $1, %rax        # return 1
done:
        leave
        ret
