#include <stdio.h>

int main(int argc, char const *argv[])
{
    int dividend = 7;
    int divisor  = -2;
    int quotient = dividend / divisor;
    int reminder = dividend - divisor * quotient;
    if (quotient == -3 && reminder == 1) {
        printf("Mathematicians method.\n");
    } else if (quotient == -4 && reminder == -1) {
        printf("Some Computer Scientists method.\n");
    } else {
        printf("Unexpected quotient: %d with reminder: %d\n", quotient, reminder);
    }
    return 0;
}
