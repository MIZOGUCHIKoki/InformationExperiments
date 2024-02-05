#include <stdio.h>

char s1[] = "hello1";
char *s2 = "hello2";
int x1 = 100;
int main(void)
{
    int x2 = 200;
    printf(" s1 = %p\n", s1);
    printf("&s2 = %p\n", &s2);
    printf(" s2 = %p\n", s2);
    printf("&x1 = %p\n", &x1);
    printf("&x2 = %p\n", &x2);
    return 0;
}
/*
 s2 = 0x10046ff7c | Hello2\0
                  |
 s1 = 0x102094000 | Hello1\0
&s2 = 0x102094008 | s2(=0x10046ff7c)
&x1 = 0x102094010 | x1
                  |
&x2 = 0x16dd73108 | x2
*/