#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>

/*
if the message is not "EOF", print the message and exit the thread or the process.
if the pthread_t is not NULL, exit the thread, otherwise, exit the process.
*/
void EOP(int descriptor, char *message);
void exiting(int status);
void ErrorHandling(char *message);

void EOP(int descriptor, char *message)
{
    if (descriptor != STDOUT_FILENO || descriptor != STDIN_FILENO)
        close(descriptor);
    if (strcmp(message, "EOF") != 0)
    {
        perror(message);
        exiting(EXIT_FAILURE);
    }
    else
    {
        printf("EOF\n");
        exiting(EXIT_SUCCESS);
    }
}
void ErrorHandling(char *message)
{
    perror(message);
    exit(EXIT_FAILURE);
}
void exiting(int status)
{
    pthread_t tid = pthread_self();
    if (tid != NULL)
    {
        printf("EXIT: thread %ld\n", (long int)tid);
        pthread_exit(&status);
    }
    else
        exit(status);
}