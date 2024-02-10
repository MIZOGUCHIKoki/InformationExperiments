int acceptClient(int svSock);
void clearClientInfo(int clIndex);
void closingAllClient(void);
int searchDrinks(char *buf, int clIndex);
void printClientsList(void);
void printProductsList(int descriptor);
void printProductsList(int descriptor);
void setupSelectForClients(fd_set *clfds, int *maxclfd);