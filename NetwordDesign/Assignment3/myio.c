#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void EOP(int descriptor, char *message);

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
    printf(">> sent: %s\n", buf);
}
void reading(int descriptor, char *buf, size_t bufferLen)
{
    size_t recvSize = 0;
    recvSize = read(descriptor, buf, bufferLen);
    printf(">> received: %s\n", buf);
    if (recvSize == 0)
        EOP(descriptor, "EOF");
    else if (recvSize < 0)
        EOP(descriptor, "read() failed");
}