#include <stdio.h>

extern int add(int x, int y);
extern int multiply(int x, int y);

int main() {
    int sum = add(4, 7);
    printf("Sum of 4 and 7 in D: %d\n", sum);
    int product = multiply(4, 7);
    printf("Product of 4 and 7 in D: %d\n", product);
    return 0;
}
