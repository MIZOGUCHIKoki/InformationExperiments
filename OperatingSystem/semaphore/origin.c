#include <stdio.h>
#include <pthread.h>

int flag = 0;
char buff[256];

void *func(void *arg)
{
    while (flag == 0)
        ;
    printf("\n Thread -> %s\n", buff);
    pthread_exit(0);
}

int main()
{
    pthread_t tid;
    pthread_create(&tid, NULL, func, NULL);
    printf("\n ParentProcess: input message ->");
    scanf("%s", buff);
    flag = 1;
    pthread_join(tid, NULL);
    return 0;
}