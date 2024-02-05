#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/select.h>
#include "server.h"

#define BSIZE 32
#define PORT 10000
#define MAX_CLIENTS 5
#define MAX_PENDING 5

typedef struct
{
    char name[20];
    int price;
    int left;
} Product;

Product products[] = {
    {"apple", 70, 10},
    {"coffee", 100, 1},
    {"milk", 40, 8},
    {"orange", 80, 12},
    {"tea", 50, 15},
};
int num_products = sizeof(products) / sizeof(Product);

int main(void)
{
    int svSock;
    int clientsSet[MAX_CLIENTS];
    memset(clientsSet, 0, sizeof(clientsSet));
    int *connected = 0;
    struct sockaddr_in svAddr;
    fd_set fds;

    if ((svSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
        ErrorHandling("socket() failed");
    memset(&svAddr, 0, sizeof(svAddr));
    svAddr.sin_family = AF_INET;
    svAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    svAddr.sin_port = htons(PORT);
    if (bind(svSock, (struct sockaddr *)&svAddr, sizeof(svAddr)) < 0)
        ErrorHandling("bind() failed");
    printf("binding...\n");
    if (listen(svSock, MAX_PENDING) < 0)
        ErrorHandling("listen() failed");
    printf("listening...\n");
    for (;;)
    {
        FD_ZERO(&fds);
        FD_SET(svSock, &fds);
        int maxfd = svSock;
        for (int i = 0; i < MAX_CLIENTS; i++)
        {
            if (clientsSet[i] != 0)
            {
                FD_SET(clientsSet[i], &fds);
                if (clientsSet[i] > maxfd)
                    maxfd = clientsSet[i];
            }
        }
        if (select(maxfd + 1, &fds, NULL, NULL, NULL) < 0)
            ErrorHandling("select() failed");
        if (FD_ISSET(svSock, &fds))
        {
            serverProcessing(svSock, connected, clientsSet);
        }
    }
}

void serverProcessing(int svSock, int *connected, int *clientsSet)
{
    printf("call AcceptClient\n");
    int c = AcceptClient(svSock);
    printf("debug point\n");
    if (*connected == MAX_CLIENTS)
        EOP(c, "Server is full");
    writing(c, "HELLO", BSIZE);
    printf("connected: %d\n", *connected);
    clientsSet[*connected] = c;
    (*connected)++;
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