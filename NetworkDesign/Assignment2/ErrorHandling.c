#include <stdio.h>
#include <stdlib.h>

void ErrorHandling(char *message)
{
    perror(message);
    exit(1);
}