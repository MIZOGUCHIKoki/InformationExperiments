void ErrorHandling(char *message);
void EOP(int descriptor, char *message);
void serverProcessing(int svSock, int *connected, int *clientsSet);
int AcceptClient(int svSock);
void writing(int descriptor, char *message, size_t bufferLen);
void reading(int descriptor, char *message, size_t bufferLen);
void closingClSock(int *clientsSet);