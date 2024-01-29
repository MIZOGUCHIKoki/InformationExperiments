#include <stdio.h>      // printf(), fprintf()
#include <sys/socket.h> // socket(), connect(), send(), recv()
#include <netdb.h>      // struct addrinfo, getaddrinfo(), gai_strerror()
#include <arpa/inet.h>  // sockaddr_in, inet_addr()
#include <stdlib.h>     // atoi()
#include <string.h>     // memset()
#include <unistd.h>     // close()

#define RCVSIZE 32 // Size of receive buffer

void ErrorHandling(char *message);                              // Error handling function
void HostName2IpAddr(char *hostName, char *port, char *ipAddr); // Convert host name to IP address

int main(int argc, char *argv[])
{
    printf(">> executed client ------ \n");
    int sock;                                                            // socket descriptor
    struct sockaddr_in server_addr;                                      // server address structure
    char *serverHostFromArgs;                                            // server host from command line
    char *serverIpAddr = (char *)malloc(sizeof(char) * INET_ADDRSTRLEN); // server IP address
    char *serverPort;                                                    // server port
    char *sendString;                                                    // string to send to server
    unsigned int sendStringLen;                                          // length of sendString
    char Buffer[RCVSIZE];                                                // Buffer for received string
    unsigned int BufferLen;                                              // length of Buffer
    int bytesRcvd, totalBytesRcvd;                                       // bytes read in single recv() and total bytes read

    if (argc != 3) // Test for correct number of arguments
    {
        fprintf(stderr, "Usage: %s <Server Host name> <Server Port>\n", argv[0]); // argv[0] is in executable file name
        exit(1);
    }

    serverHostFromArgs = argv[1]; // First arg: server host name
    serverPort = argv[2];         // Third arg: server port
    printf("Host Name   : %s\n", serverHostFromArgs);
    printf("Port number : %s\n", serverPort);

    // Convert host name to IP address

    if ((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) // Create a reliable, stream socket using TCP
    {
        ErrorHandling("socket() failed");
    }

    /* some functions description:
    inet_addr() converts [the Internet host address from IPv4 numbers-and-dots notation] into [binary data in network byte order].
    htons() converts [number from host byte order] to [number in network byte order].
    atoi() converts [string] to [integer].
    inet_ntop() converts [the network byte ordered 32-bit IPv4 address] to [dotted-decimal format].

    - connetct(socket descriptor, server address structure, size of server address structure);
        if success, return 0, else return -1.
    - send(socket descriptor, string to send, length of string to send, flag);
        if success, return number of bytes sent, else return -1.
    - inet_ntop(address family, pointer to binary data, pointer to string to store result, length of string to store result)
        if success, return pointer to string, else return NULL.
    */

    // Construct the server address structure
    memset(&server_addr, 0, sizeof(server_addr)); // Zero out structure
    server_addr.sin_family = AF_INET;             // Internet address family

    HostName2IpAddr(serverHostFromArgs, serverPort, serverIpAddr);
    printf("serverIpAddr: %s\n", serverIpAddr);
    server_addr.sin_addr.s_addr = inet_addr(serverIpAddr);
    server_addr.sin_port = htons(atoi(serverPort)); // Server port

    sendString = "Hello, world!"; // String to send
    sendStringLen = strlen(sendString);

    // Establish the connection to the server
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) // server_addr is a pointer to [struct sockaddr_in]
    {
        close(sock);
        ErrorHandling("connect() failed");
    }

    // Send the string to the server
    if (send(sock, sendString, sendStringLen, 0) != sendStringLen)
    {
        close(sock);
        ErrorHandling("send() sent a different number of bytes than expected");
    }

    // Receive the same string back from the server
    // if ((bytesRcvd = (sock, Buffer, RCVSIZE - 1, 0)) < 0)
    // {
    //     close(sock);
    //     ErrorHandling("recv() failed");
    // }
    // else if (bytesRcvd > 0)
    // {
    // }

    close(sock);
    return 0;
}

void HostName2IpAddr(char *hostName, char *port, char *ipAddr)
{
    struct addrinfo moreInfo, *response;    // More info about host
    memset(&moreInfo, 0, sizeof(moreInfo)); // Zero out structure
    moreInfo.ai_family = AF_INET;           // IPv4 only
    moreInfo.ai_socktype = SOCK_STREAM;     // Only TCP

    if (getaddrinfo(hostName, port, &moreInfo, &response) != 0)
    {
        ErrorHandling("getaddrinfo() failed");
    }

    // inet_ntoa() is a legacy function that converts the network byte ordered 32-bit IPv4 address to dotted-decimal format
    // inet_ntop() converts the network byte ordered 32-bit IPv4 address to dotted-decimal format
    if (inet_ntop(AF_INET, &((struct sockaddr_in *)response->ai_addr)->sin_addr, ipAddr, INET_ADDRSTRLEN) == NULL)
    {
        ErrorHandling("inet_ntop() failed");
    }
    printf("IP address of %s is %s\n", hostName, ipAddr);
    freeaddrinfo(response); // Free address structure
    return ipAddr;
}