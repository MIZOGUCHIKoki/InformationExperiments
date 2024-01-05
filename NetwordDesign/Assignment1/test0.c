#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int *p = malloc(sizeof(int)); // It is neccessary to secure memory space for p.
    *p = 0;
    printf(" p = %p\n", p);
    printf("&p = %p\n", &p);
    printf("*p = %d\n", *p);

    int a = 10;
    int *q;
    q = &a; // allocate memory on stack.
    printf("q = %d\n", *q);
    return 0;
}