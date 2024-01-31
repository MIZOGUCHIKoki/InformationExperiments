## some functions description:
- `inet_addr()` converts the Internet host address from IPv4 numbers-and-dots notation into binary data in network byte-ordered.
- `htons()` converts the number from host byte-ordered to the number in network byte-ordered.
- `atoi()` converts a string to an integer.
- `inet_addr()` converts `x.x.x.x` to `XX...XXX`. For example, 127.0.0.1 -> 16777343.

- `inet_ntop()` converts the network byte ordered 32-bit IPv4 address to dotted-decimal format.

- `connect(socket descriptor, server address structure, size of server address structure);`
    - if successful, return 0, else return -1.

- `send(socket descriptor, string to send, length of string to send, flag);`
    - if successful, return the number of bytes sent, else return -1.
    
- `inet_ntop(address family, pointer to binary data, pointer to string to store result, length of string to store result);`
    - if successful, return a pointer to string, else return NULL.

- `inet_ntoa()` is a legacy function that converts the network byte-ordered 32-bit IPv4 address to dotted-decimal format.
- `inet_ntop()` converts the network byte ordered 32-bit IPv4 address to dotted-decimal format.

- `htons()` host -> network short. (16-bit)
- `htonl()` host -> network long. (32-bit)
- `ntohs()` network -> host short. (16-bit)
- `ntohl()`	netwok -> host long. (32-bit)
