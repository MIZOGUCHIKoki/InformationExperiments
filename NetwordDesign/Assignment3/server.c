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

struct Product
{
    char name[16];
    unsigned short price;
    int sock;
};

struct ThreadArgs
{
    int clientSock;
};

ErrorHandling(char *message);

int main()
{
    int svSock;
    int clSock;
    struct sockaddr_in svAddr; // server addr struct
    unsigned short svPort;     // server port
    unsigned short clAddrLen;  // client address struct length

    if ((svSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
        ErrorHandling("socket() failed");
    memset(&svAddr, 0, sizeof(svAddr));
    svAddr.sin_family = AF_INET;
    svAddr.sin_addr.s_addr = htonl(INADDR_ANY); // server address is defined by world card
    svAddr.sin_port = htons(svPort);
    if (bind(svSock, (struct sockaddr *)&svAddr, sizeof(svAddr)) < 0)
        ErrorHandling("bind() failed");
    printf("binding...");
    if (listen(svSock, MAX_PENDING) < 0)
        ErrorHandling("listen() failed");
    printf("listening...");
    struct ThreadArgs *threadArgs;

    for (;;)
    {
        clSock = AcceptTCPConnection(svSock);
        if (threadArgs = (struct ThreadArgs *)malloc(sizeof(struct ThreadArgs)) == NULL)
            ErrorHandling("malloc() faild");
    }
}
