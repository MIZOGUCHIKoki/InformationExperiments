#include <stdio.h>
#include <pthread.h>
int count = 0;
pthread_mutex_t mutex; // lock変数

void *funcA(void *params);
void *funcB(void *params);

int main(void)
{
    pthread_t tid1, tid2;
    int i;

    pthread_mutex_init(&mutex, NULL);
    pthread_create(&tid1, NULL, funcA, NULL);
    pthread_create(&tid2, NULL, funcB, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);

    pthread_mutex_destroy(&mutex); // lock変数の破棄
    printf("count = %d\n", count);
}

void *funcA(void *params)
{
    for (int i = 0; i < 1000000; i++)
    {
        pthread_mutex_lock(&mutex); // lock
        count++;
        pthread_mutex_unlock(&mutex); // unlock
    }
    pthread_exit(0);
}

void *funcB(void *params)
{
    for (int i = 0; i < 1000000; i++)
    {
        pthread_mutex_lock(&mutex); // lock
        count++;
        pthread_mutex_unlock(&mutex); // unlock
    }
    pthread_exit(0);
}