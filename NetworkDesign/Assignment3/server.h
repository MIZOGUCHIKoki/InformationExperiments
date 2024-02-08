int acceptClient(int svSock);
void closingAllClient(void);
void printClientsList(void);
void printProductsList(int descriptor);
void printProductsList(int descriptor);
void setupSelectForClients(fd_set *clfds, int *maxclfd);