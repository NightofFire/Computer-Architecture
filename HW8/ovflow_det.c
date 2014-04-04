/* File:      ovflow_det.c
 * Purpose:   Read signed long ints, add them, and determine whether
 *            there's been overflow.
 *
 * Compile:   gcc -g -Wall -DALL_IN_C -o ovflow_det ovflow_det.c
 * Run:       ./ovflow_det
 *
 * Input:     A series of pairs of hexadecimal, long ints.  A pair
 *            of zeroes to quit.
 * Output:    The C sum of each input pair and a message stating
 *            whether the addition overflowed.
 *
 * Notes:
 *
 * 1.  The sequence of hex digits "fedcba9876543210" is printed
 *     so that the user can see how many digits he or she has
 *     entered.
 * 2.  This contains a stub for the Overflow function:  it
 *     always returns 0.
 */
#include <stdio.h>

long Overflow(long m, long n);

int main(void) {
   long m, n, sum;

   printf("Enter two ints (both 0 to quit)\n");
   printf("fedcba9876543210 fedcba9876543210\n");
   scanf("%lx%lx", &m, &n);

   while (m != 0 || n != 0) {
      sum = m + n;
      printf("The C sum of 0x%lx and 0x%lx is 0x%lx\n", m, n, sum);
      if (Overflow(m,n))
         printf("The sum overflowed\n\n");
      else
         printf("The sum didn't overflow\n\n");

      printf("Enter two ints (both 0 to quit)\n");
      printf("fedcba9876543210 fedcba9876543210\n");
      scanf("%lx%lx", &m, &n);
   }

   return 0;
}  /* main */

/*-------------------------------------------------------------------
 * Function:    Overflow
 * Purpose:     Determine whether the sum of the two arguments has
 *              overflowed.
 * Input args:  m, n
 * Ret val:     0 if the sum doesn't overflow, nonzero otherwise
 *
 * Note:        This is just a stub that always returns 0
 */
#ifdef ALL_IN_C
long Overflow(long m, long n) {
   return (m > 0 && n > 0 && (m + n) < 0) || (m < 0 && n < 0 && (m + n) > 0);
}
// Another version
long Overflow2(long m, long n) {
   long carry = 0;
   for (int i = 0; i < 63; ++i) {
      carry += (m & 1) + (n & 1);
      m >>= 1;
      n >>= 1;
      carry >>= 1;
   }
   return (m > 0 && n > 0 && carry > 0) || (m < 0 && n < 0 && carry == 0);
}  /* Overflow */
#endif
