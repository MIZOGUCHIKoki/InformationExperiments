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
        FD_SET(STDIN_FILENO, &fds);
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
        if (FD_ISSET(STDIN_FILENO, &fds))
        {
            char buf[BSIZE];
            int r = read(STDIN_FILENO, buf, BSIZE);
            if (r == 0)
            {
                closingClSock(clientsSet);
                EOP(svSock, "EOF");
            }
            if (r < 0)
                closingClSock(clientsSet);
            EOP(svSock, "read() failed");
            if (r > 0)
                continue;
        }
    }
    close(svSock);
    return 0;
}

void serverProcessing(int svSock, int *connected, int *clientsSet)
{
    // printf("call AcceptClient\n");
    int c = AcceptClient(svSock);
    printf("connected: %d\n", *connected);
    printf("debug point\n");
    // if (*connected == MAX_CLIENTS)
    // EOP(c, "ERROR");
    // writing(c, "HELLO", BSIZE);
    clientsSet[*connected] = c;
    (*connected)++;
    printf("connected: %d\n", *connected);
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

void closingClSock(int *clientsSet)
{
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clientsSet[i] != 0)
        {
            close(clientsSet[i]);
            clientsSet[i] = 0;
        }
    }
}

void sendProductList()
{
    for (int i = 0; i < num_products; ++i)
    {
        char buffer[BSIZE];
        snprintf(buffer, BSIZE, "%s(%d(%d)) ", products[i].name, products[i].price, products[i].left);
        write(STDOUT_FILENO, buffer, strlen(buffer));
    }
    write(STDOUT_FILENO, "\n", 1);
}