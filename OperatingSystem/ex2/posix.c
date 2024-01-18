#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

void *func(void *arg);
char buff[256];

sem_t sid;

int main(void)
{
    pthread_t tid;
    int rc;

    rc = sem_init(&sid, 0, 0); // セマフォアを作成・初期化

    pthread_create(&tid, NULL, func, NULL);
    printf("\n ParentProcess: input message ->");

    scanf("%s", buff);

    sem_post(&sid); // Signal meirei

    pthread_join(tid, NULL);
}

void *func(void *args)
{
    sem_wait(&sid); // Wait 命令
    printf("\n ChildProcess: received message -> %s\n", buff);
    pthread_exit(0);
}