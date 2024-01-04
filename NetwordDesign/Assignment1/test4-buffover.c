#include <stdio.h>

int mul2(int x) { return x * 2; }
int mul3(int x) { return x * 3; }

int main(void)
{
    int n;
    int (*func)(int); // funcの型はint(int)型
    char buf[16];
    func = mul2;
    printf("mul2: %p\n", mul2);
    printf("mul3: %p\n", mul3);
    printf("main: %p\n", main);
    printf("&func:%p\nbuf:  %p\n", &func, buf);
    printf("func: %p\n", func);
    gets(buf);
    printf("func: %p\n", func);
    n = func(10);
    printf("mul2 (10): %d\n", n);
    return 0;
}