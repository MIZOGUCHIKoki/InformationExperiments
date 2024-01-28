struct in_addr
{
    unsigned long s_addr; // 32-bit IPv4 address, network byte ordered
};

struct sockaddr_in
{
    unsigned short sin_family; // TCP/IP(AF_INET)
    unsigned short sin_port;   // port number
    struct in_addr sin_addr;   // IPv4 address(32-bit)
    char sin_zero[8];          // unused
};

struct sockaddr
{
    unsigned short sa_family; // address family(AF_INET, AF_INET6, AF_UNIX...)
    char sa_data[14];         // 14 bytes of protocol address
};