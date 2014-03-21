# Author:       Wanzhang Sheng
#
# Function:     Bubble_sort
# Purpose:      Sort list using bubble sort
# C Prototype:  void Bubble_sort(long a[], long n);
# Args:         a[] = rdi
#               n   = rsi
# Return val:   void
#

        .section .text
        .global Bubble_sort

Bubble_sort:
        push %rbp
        mov  %rsp, %rbp

        push %rbx               # rbx = temp
        push %r12               # r12 = list_length
        push %r13               # r13 = i

        push %rsi               # 8(%rsp) = rsi = n
        push %rdi               # 0(%rsp) = rdi = &a[0]

        mov  8(%rsp), %r12      # r12 = n
        jmp  list_length_test

list_length_loop:
        mov  $0, %r13           # r13 = i = 0
        jmp  i_test

i_loop:
        mov  %r13, %rdi         # rdi = i
        sal  $3, %rdi           # rdi = i * 8
        add  0(%rsp), %rdi      # rdi = rdi + &a[0] = &a[i]
        mov  %rdi, %rsi         # rsi = rdi = &a[i]
        add  $8, %rsi           # rsi = rsi + 8 = &a[i+1]

        mov  0(%rdi), %r8       # r8 = a[i]
        mov  0(%rsi), %r9       # r9 = a[i+1]
        cmp  %r9, %r8           # a[i] ? a[i+1]
        jle  if_else            # a[i] <= a[i+1]
        call Swap               # a[i] > a[i+1]
if_else:
        add  $1, %r13           # i++

i_test:
        mov  %r12, %rbx         # rbx = r12 = list_length
        sub  $1, %rbx           # rbx = rbx - 1
        cmp  %rbx, %r13         # i ? list_length-1
        jl   i_loop             # i < list_length-1

        sub  $1, %r12           # list_length--

list_length_test:
        cmp  $2, %r12           # list_length ? 2
        jge  list_length_loop   # list_length >= 2

done:
        pop  %rdi               # Restore rdi
        pop  %rsi               # Restore rsi
        pop  %r13               # Restore r13
        pop  %r12               # Restore r12
        pop  %rbx               # Restore rbx
        leave
        ret


# Function:     Swap
# Purpose:      Swap contents of x_p and y_p
# C Prototype:  void Swap(long* x_p, long* y_p);
# Args:         &x_p = rdi
#               &y_p = rsi
# Return val:   void
#

        .section .text
        .global Swap

Swap:
        push %rbp
        mov  %rsp, %rbp

        push %r8                # Save r8
        push %r9                # Save r9
        mov  0(%rdi), %r8       # r8   = *x_p
        mov  0(%rsi), %r9       # r9   = *y_p
        mov  %r9, 0(%rdi)       # *x_p = r9 = *y_p
        mov  %r8, 0(%rsi)       # *y_p = r8 = *x_p
        pop  %r9                # Restore r9
        pop  %r8                # Restore r8

        # done
        leave
        ret
