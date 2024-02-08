#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/select.h>
#include "server.h"
#include "myio.h"

#define BSIZE 32
#define PORT 10000
#define MAX_CLIENTS 5
#define MAX_PENDING 5
#define PRODUCTS_ROW_SIZE 256

typedef struct
{
    char name[20];
    int price;
    int left;
} Product;

typedef struct
{
    int clSock;
    int coin;
    int drink;
} Client;
Client clients[MAX_CLIENTS];

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
    int resue = 1; // for setsockopt
    struct sockaddr_in svAddr;
    fd_set clfds;
    int maxclfd;
    memset(clients, 0, sizeof(clients));

    if ((svSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
        ErrorHandling("socket() failed");
    memset(&svAddr, 0, sizeof(svAddr));
    if (setsockopt(svSock, SOL_SOCKET, SO_REUSEADDR, &resue, sizeof(int)) < 0)
        ErrorHandling("setsockopt() failed");
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
        setupSelectForClients(&clfds, &maxclfd);

        if (select(maxclfd + 1, &clfds, NULL, NULL, NULL) < 0)
            ErrorHandling("select() failed");

        char buf[BSIZE];
        int clSock = AcceptClient(svSock);
    }
    close(svSock);
    return 0;
}

void printClientsList(int clients)
{
    printf(">> Clients list: \n");
    int j;
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clients[i].clSock != 0)
            printf(" |- Client[%d]: %d\n", i, j);
    }
    printf("\n");
}

void closingAllClient(int clientsSet[])
{
    printf("Closing clients\n");
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clientsSet[i] != 0)
            close(clientsSet[i]);
    }
}

void printProductsList(int descriptor)
{
    printf(">> Products list: \n");
    char buffer[PRODUCTS_ROW_SIZE];
    for (int i = 0; i < num_products; i++)
    {
        memset(buffer, 0, PRODUCTS_ROW_SIZE);
        snprintf(buffer, PRODUCTS_ROW_SIZE, " |- Product[%2d]: %-7s, price: %3d, left: %2d\n", i, products[i].name, products[i].price, products[i].left);
        writing(descriptor, buffer, PRODUCTS_ROW_SIZE);
        writing(STDOUT_FILENO, buffer, PRODUCTS_ROW_SIZE);
    }
    printf("\n");
}

int AcceptClient(int svSock)
{
    int clSock;
    struct sockaddr_in clAddr;
    socklen_t clAddrLen = sizeof(clAddr);
    if ((clSock = accept(svSock, (struct sockaddr *)&clAddr, &clAddrLen)) < 0)
        ErrorHandling("accept() failed");
    printf("Handling client %s, clSock: %d\n", inet_ntoa(clAddr.sin_addr), clSock);
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clients[i].clSock == 0)
        {
            clients[i] = clSock;
            printf("Client[%d] is added: %d\n", i, clSock);
            break;
        }
        if (i == MAX_CLIENTS - 1)
        {
            writing(clSock, "Server is full", BSIZE);
            EOP(clSock, "Server is full");
        }
    }
    printProductsList(clSock);
    return clSock;
}

void setupSelectForClients(fd_set *clfds, int *maxclfd)
{
    FD_ZERO(clfds);
    *maxclfd = 0;
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clients[i].clSock != 0)
            FD_SET(clientsSet[i], clfds);
        if (clients[i] > *maxclfd)
            *maxclfd = clientsSet[i];
    }
}