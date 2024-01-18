#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
    pid_t pid1, pid2;
    int count = 1;
    printf("PointA :count=%d\n", count);

    pid1 = fork();
    if (pid1 == 0)
        count = 2;
    else
        count = 3;
    printf("PointB :count=%d\n", count);

    pid2 = fork();
    if (pid2 == 0)
        count = 4;
    else
        count = 5;
    printf("PointC :count=%d\n", count);
    _exit(0);
}
