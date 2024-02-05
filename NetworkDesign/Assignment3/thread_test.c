#include <stdio.h>
#include <pthread.h>

void *s_function(void)
{
    pthread_t thread_id = pthread_self();
    printf("Thread ID from 2nd_function: %lu\n", (unsigned long)thread_id);
    return NULL;
}

void *thread_function(void *arg)
{
    pthread_t thread_id = pthread_self();
    printf("Thread ID from thread_function: %lu\n", (unsigned long)thread_id);

    // 2nd_functionを呼び出す
    s_function();

    return NULL;
}

int main()
{
    printf("Thread ID from main: %lu\n", (unsigned long)pthread_self());
    pthread_exit(NULL);
    pthread_t thread;
    pthread_create(&thread, NULL, thread_function, NULL);
    pthread_join(thread, NULL);
    return 0;
}
