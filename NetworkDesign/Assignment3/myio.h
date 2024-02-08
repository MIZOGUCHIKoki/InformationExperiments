void writing(int descriptor, char *buf, size_t bufferLen);
int reading(int descriptor, char *buf, size_t bufferLen);

// Error handling and exiting functions
void EOP(int descriptor, char *message);
void exiting(int status);
void ErrorHandling(char *message);