#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
    char *str = (char *)malloc(sizeof(char) * 11);
    size_t sz = read(2, str, 10);
    printf("sz = %zu\n", sz);
    printf("str = %s\n", str);
}