#include <stdio.h>
#include <stdlib.h>
int main(void)
{
    int *p;
    p = (int *)malloc(sizeof(int)); // int 格納用領域
    if (p == NULL)
    {
        perror("malloc");
        exit(1);
    }
    *p = 99;
    printf("*p = %d\n", *p);
    free(p); // pがさす領域を解放
    return 0;
}