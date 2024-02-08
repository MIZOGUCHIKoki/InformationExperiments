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
#define PRODUCT_DRINK_NAME_SIZE 20

typedef struct
{
    char name[PRODUCT_DRINK_NAME_SIZE];
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
        FD_ZERO(&clfds);
        setupSelectForClients(&clfds, &maxclfd);
        FD_SET(svSock, &clfds);
        FD_SET(STDIN_FILENO, &clfds);
        maxclfd = (svSock > maxclfd) ? svSock : maxclfd;
        maxclfd = (STDIN_FILENO > maxclfd) ? STDIN_FILENO : maxclfd;

        if (select(maxclfd + 1, &clfds, NULL, NULL, NULL) < 0)
            ErrorHandling("select() failed");
        if (FD_ISSET(svSock, &clfds)) // a new connection
        {
            acceptClient(svSock);
        }
        if (FD_ISSET(STDIN_FILENO, &clfds))
        {
            char buf[BSIZE];
            memset(buf, 0, BSIZE);
            int n = read(STDIN_FILENO, buf, BSIZE);
            if (n == 0)
            {
                closingAllClient();
                EOP(svSock, "EOF");
            }
            if (strcmp(buf, "cls\n") == 0)
                printClientsList();
            else if (strcmp(buf, "ls\n") == 0)
                printProductsList(STDOUT_FILENO);

            else
                printf("Unknown command: %s\n", buf);
            continue;
        }
        for (int i = 0; i < MAX_CLIENTS; i++)
        {
            if (FD_ISSET(clients[i].clSock, &clfds))
            {
                char buf[BSIZE];
                memset(buf, 0, BSIZE);
                int n = read(clients[i].clSock, buf, BSIZE);
                if (n < 0)
                    EOP(clients[i].clSock, "read() failed");
                printf("client[%d](%d) >> %s\n", i, clients[i].clSock, buf);
                if (n == 0)
                {
                    close(clients[i].clSock);
                    clients[i].clSock = 0;
                    printf("Client[%d] is closed\n", i);
                    break;
                }
                if (strcmp(buf, "ls") == 0)
                {
                    printProductsList(clients[i].clSock);
                    break;
                }
            }
        }
    }
    close(svSock);
    return 0;
}

void printClientsList()
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

void closingAllClient()
{
    printf("Closing all conected clients\n");
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clients[i].clSock != 0)
            close(clients[i].clSock);
    }
}

void printProductsList(int descriptor)
{
    printf(">> Products list to {fds: %d}\n", descriptor);
    // writing(descriptor, ">> Products list:\n", BSIZE);
    char buffer[PRODUCTS_ROW_SIZE];
    for (int i = 0; i < num_products; i++)
    {
        memset(buffer, 0, PRODUCTS_ROW_SIZE);
        snprintf(buffer, PRODUCTS_ROW_SIZE, " |- Product[%2d]: %-7s, price: %3d, left: %2d\n", i, products[i].name, products[i].price, products[i].left);
        writing(descriptor, buffer, PRODUCTS_ROW_SIZE);
    }
    printf("\n");
}

int acceptClient(int svSock)
{
    int cs;
    struct sockaddr_in clAddr;
    socklen_t clAddrLen = sizeof(clAddr);
    if ((cs = accept(svSock, (struct sockaddr *)&clAddr, &clAddrLen)) < 0)
        ErrorHandling("accept() failed");
    printf("Handling client %s, clSock: %d\n", inet_ntoa(clAddr.sin_addr), cs);
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clients[i].clSock == 0)
        {
            clients[i].clSock = cs;
            printf("Client[%d] is added: %d\n", i, cs);
            break;
        }
        if (i == MAX_CLIENTS - 1)
        {
            writing(cs, "Server is full", BSIZE);
            return -1;
        }
    }
    printProductsList(cs);
    return cs;
}

void setupSelectForClients(fd_set *clfds, int *maxclfd)
{
    FD_ZERO(clfds);
    *maxclfd = 0;
    for (int i = 0; i < MAX_CLIENTS; i++)
    {
        if (clients[i].clSock != 0)
            FD_SET(clients[i].clSock, clfds);
        if (clients[i].clSock > *maxclfd)
            *maxclfd = clients[i].clSock;
    }
}

void drinkAndPayment()
{
}