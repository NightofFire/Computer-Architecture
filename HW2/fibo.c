/* File:      fibo.c
 * Purpose:   Compute and print the nth Fibonacci number
 *
 * Compile:   gcc -g -Wall -o fibo fibo.c
 * Run:       ./fibo
 *
 * Input:     A positive integer n
 * Output:    The nth Fibonacci number
 *
 * Notes:
 * 1. The program uses the following definition of the Fibonacci
 * numbers:
 *
 *    f_0 = 0
 *    f_1 = 1
 *    f_n = f_(n-1) + f_(n-2), n >= 2
 *
 * 2. The input value n should be positive
 */
#include <stdio.h>

int main(void) {
   int f_new, f_old, f_older, n, i;

   scanf("%d", &n);

   f_old = 1; f_older = 0;
   for (i = 2; i <= n; i++) {
      f_new = f_old + f_older;
      f_older = f_old;
      f_old = f_new;
   }

   printf("%d\n", f_old);  /* Don't worry about newline in assembler */

   return 0;
}
