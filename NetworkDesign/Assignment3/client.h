void recvFromServer(char *buffer, int sock); // Receive string from the server
void requestProductsList(int sock);          // Recviced string from prompt
char *HostName2IpAddr(char *hostName, char *port);