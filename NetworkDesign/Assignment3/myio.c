#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>

#include "myio.h"

void writing(int descriptor, char *buf, size_t bufferLen)
{
    size_t sentSize = 0;
    ssize_t sendSize = 0;
    while (sentSize < bufferLen)
    {
        sendSize = write(descriptor, buf, bufferLen);
        if (sendSize < 0)
            EOP(descriptor, "send() failed");
        sentSize += sendSize;
    }
}
int reading(int descriptor, char *buf, size_t bufferLen)
{
    size_t recvSize = 0;
    recvSize = read(descriptor, buf, bufferLen);
    printf("%s", buf);
    if (recvSize == 0)
        EOP(descriptor, "EOF");
    else if (recvSize < 0)
        EOP(descriptor, "read() failed");
    return (int)recvSize;
}

void EOP(int descriptor, char *message)
{
    if (descriptor != STDOUT_FILENO || descriptor != STDIN_FILENO)
        close(descriptor);
    if (strcmp(message, "EOF") != 0)
    {
        perror(message);
        exit(EXIT_FAILURE);
    }
    else
    {
        printf("EOF\n");
        exit(EXIT_SUCCESS);
    }
}

void ErrorHandling(char *message)
{
    perror(message);
    exit(EXIT_FAILURE);
}
