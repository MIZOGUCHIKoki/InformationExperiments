#include <stdio.h>      // printf(), fprintf()
#include <sys/socket.h> // socket(), connect(), send(), recv()
#include <netdb.h>      // struct addrinfo, getaddrinfo(), gai_strerror()
#include <arpa/inet.h>  // sockaddr_in, inet_addr()
#include <stdlib.h>     // atoi()
#include <string.h>     // memset()
#include <unistd.h>     // close(), read(), write()
#include <sys/select.h> // select()
#include "myio.h"       // ErrorHandling(), writing(), reading()
#include "client.h"     //

#define BSIZE 256 // Size of receive buffer

int main(int argc, char *argv[])
{
    int sock;                       // socket descriptor
    struct sockaddr_in server_addr; // server address structure
    char *serverHostFromArgs;       // server host from command line
    char *serverPort;               // server port
    char Buffer[BSIZE];             // Buffer for received string
    size_t sendLen, recvedLen;      // length of Buffer

    if (argc != 3) // Test for correct number of arguments
    {
        fprintf(stderr, "Usage: %s <Server Host name> <Server Port>\n", argv[0]); // argv[0] is in executable file name
        exit(1);
    }

    serverHostFromArgs = argv[1]; // First arg: server host name
    serverPort = argv[2];         // Third arg: server port
    printf("Host Name   : %s\n", serverHostFromArgs);
    printf("Port number : %s\n", serverPort);

    // Create a reliable, stream socket using TCP
    if ((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) // Create a reliable, stream socket using TCP
    {
        ErrorHandling("socket() failed");
    }

    // Construct the server address structure
    memset(&server_addr, 0, sizeof(server_addr));                         // Zero out structure
    server_addr.sin_family = AF_INET;                                     // Internet address family
    char *serverIpAddr = HostName2IpAddr(serverHostFromArgs, serverPort); // Convert host name to IP address
    server_addr.sin_addr.s_addr = inet_addr(serverIpAddr);                // Server IP address; network byte-ordered (127.0.0.1->16777343)
    server_addr.sin_port = htons(atoi(serverPort));                       // Server port; host to network short

    // Establish the connection to the server
    // server_addr is a pointer to struct-sockaddr_in
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0)
    {
        close(sock);
        ErrorHandling("connect() failed");
    }
    printf(">> Connected to client: %s:%s\n", serverIpAddr, serverPort);

    // setup select function
    fd_set fds; // Set of file descriptors
    int max_fd;
    for (;;)
    {                                                         // Maximum file descriptor
        FD_ZERO(&fds);                                        // Clear all bits
        FD_SET(STDIN_FILENO, &fds);                           // Set bit for stdin
        FD_SET(sock, &fds);                                   // Set bit for sock
        max_fd = (sock > STDIN_FILENO) ? sock : STDIN_FILENO; // max_fd = max(sock, STDIN_FILENO)
        select(max_fd + 1, &fds, NULL, NULL, NULL);           // Wait for activity
        if (FD_ISSET(STDIN_FILENO, &fds))
        {
            memset(Buffer, 0, BSIZE);
            int n = read(STDIN_FILENO, Buffer, BSIZE);
            if (n == 0)
                EOP(sock, "EOF");
            else if (n < 0)
                EOP(sock, "read() failed");
            Buffer[n - 1] = '\0'; // remove newline
            writing(sock, Buffer, n);
        }
        if (FD_ISSET(sock, &fds))
        {
            recvFromServer(Buffer, sock);
        }
    }
    return 0;
}

void recvFromServer(char *buffer, int sock)
{
    memset(buffer, 0, BSIZE); // initialize buffer
    reading(sock, buffer, BSIZE);
}

char *HostName2IpAddr(char *hostName, char *port)
{
    struct addrinfo moreInfo, *response;    // More info about host
    memset(&moreInfo, 0, sizeof(moreInfo)); // Zero out structure
    moreInfo.ai_family = AF_INET;           // IPv4 only
    moreInfo.ai_socktype = SOCK_STREAM;     // Only TCP

    if (getaddrinfo(hostName, port, &moreInfo, &response) != 0)
    {
        ErrorHandling("getaddrinfo() failed");
    }

    char *ipAddr = inet_ntoa(((struct sockaddr_in *)response->ai_addr)->sin_addr);
    printf(">> IP address of %s is %s\n", hostName, ipAddr);
    freeaddrinfo(response); // Free address structure
    return ipAddr;
}
