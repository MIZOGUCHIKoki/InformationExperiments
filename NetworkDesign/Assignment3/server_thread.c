#include <stdio.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <pthread.h>

#define BSIZE 32
#define MAX_PENDING 5
#define PORT 10000

struct ThreadArgs
{
    int clSock;
};

int AcceptClient(int svSock);
void *ThreadFunc(void *args);
void ClientProcessing(int clSock);
void writing(int descriptor, char *buf, size_t bufferLen);
void reading(int descriptor, char *buf, size_t bufferLen);
void EOP(int descriptor, char *message);
void ErrorHandling(char *messages);

unsigned int connecteddClients = 0;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int main()
{
    int svSock;
    int clSock;
    struct sockaddr_in svAddr; // server addr struct
    size_t clAddrLen;          // client address struct length

    pthread_t tid;

    if ((svSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
        ErrorHandling("socket() failed");
    memset(&svAddr, 0, sizeof(svAddr));
    svAddr.sin_family = AF_INET;

    svAddr.sin_addr.s_addr = htonl(INADDR_ANY); // server address is defined by world card
    svAddr.sin_port = htons(PORT);
    if (bind(svSock, (struct sockaddr *)&svAddr, sizeof(svAddr)) < 0)
        ErrorHandling("bind() failed");
    printf("binding...\n");
    if (listen(svSock, MAX_PENDING) < 0)
        ErrorHandling("listen() failed");
    printf("listening...\n");
    struct ThreadArgs *threadArgs;
    fd_set fds;
    for (;;)
    {
        clSock = AcceptClient(svSock);
        if ((threadArgs = (struct ThreadArgs *)malloc(sizeof(struct ThreadArgs))) == NULL)
            ErrorHandling("malloc() faild");
        (*threadArgs).clSock = clSock;

        if (pthread_create(&tid, NULL, ThreadFunc, (void *)threadArgs) != 0)
            ErrorHandling("pthread_create() failed");
        printf("with thread %ld\n", (long int)tid);
    }
}

int AcceptClient(int svSock)
{
    int clSock;
    struct sockaddr_in clAddr;
    socklen_t clAddrLen = sizeof(clAddr);
    if ((clSock = accept(svSock, (struct sockaddr *)&clAddr, &clAddrLen)) < 0)
        ErrorHandling("accept() failed");
    printf("Handling client %s\n", inet_ntoa(clAddr.sin_addr));
    return clSock;
}

void *ThreadFunc(void *args)
{
    int clSock;                                   // client socket
    clSock = ((struct ThreadArgs *)args)->clSock; // get the client socket
    free(args);                                   // free the memory
    ClientProcessing(clSock);
    return (NULL);
}

void ClientProcessing(int clSock)
{
    char *msg = "HELLO\0";
    writing(clSock, msg, sizeof(msg));
    char buffer[BSIZE];
    for (;;)
    {
        reading(clSock, buffer, BSIZE);
        writing(clSock, buffer, BSIZE);
    }
}

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