#include <stdio.h>

void ex_pointer();

int main()
{

    int ii = 1;
    int *pp;
    pp = &ii;
    printf("%p\n", &ii);
    printf("%d\n", *pp);
    ex_pointer();
    return 0;
}
void ex_pointer()
{
    printf("-----ex_pointer-----\n");
    int i = 2;
    printf("%p\n", &i);
    char a[10];
    printf("%p\n", a);
    printf("%p\n", &a[0]);
    printf("%p\n", &a[1]);

    char *p;
    *p = '1';
    *(p + 1) = '2';
    printf("%p, %c,:: %p, %c\n", p, *p, p + 1, *(p + 1));

    int in = 0x12345678;
    unsigned char *pn = (unsigned char *)&in;
    printf("%x:%x:%x:%x\n", pn[0], pn[1], pn[2], pn[3]);
}