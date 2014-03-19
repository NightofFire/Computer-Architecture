/* File:     recursive.c
 * Purpose:  Print values of the function R(i,j) defined by
 *           the formulas
 *
 *              R(i,j) = i - j, if i or j is < 0
 *              R(i,j) = R(i-1, j) + R(i, j-1), otherwise
 *
 * Compile:  gcc -g -Wall -o recursive recursive.c
 * Run:      ./recursive <n>
 *
 * Input:    None
 * Output:   Table of values of R(i,j) for 0 <= i < n and
 *           0 <= j < n
 */
#include <stdio.h>
#include <stdlib.h>

long Recursive(long i, long j);

int main(int argc, char* argv[]) {
   long n, i, j, r;

   if (argc != 2) {
      fprintf(stderr, "usage: %s <n>\n", argv[0]);
      exit(0);
   }
   n = strtol(argv[1], NULL, 10);

   for (i = 0; i < n; i++) {
      for (j = 0; j < n; j++) {
         r = Recursive(i, j);
         printf("%6ld ", r);
      }
      printf("\n");
   }

   return 0;
}  /* main */


#ifdef ALL_IN_C
long Recursive(long i, long j) {
   long t1, t2, r;

   if (i < 0) {
      r = i - j;
   } else if (j < 0) {
      r = i - j;
   } else {
      t1 = Recursive(i-1, j);
      t2 = Recursive(i, j-1);
      r = t1 + t2;
   }
   return r;
}  /* Recursive */
#endif
