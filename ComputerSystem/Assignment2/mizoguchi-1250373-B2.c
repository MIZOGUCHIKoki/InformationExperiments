#include <stdio.h>
#include <pthread.h>
#include <strings.h>

#define BUF_SIZE 32

void *funcB(void *args);
void *funcC(void *args);

char bufB[BUF_SIZE];
char bufC[BUF_SIZE];

int main(void) {
	
	memset(bufB, '\0', BUF_SIZE);
	memset(bufC, '\0', BUF_SIZE);
	
	int statusB, statusC;

	pthread_t b, c;

	pthread_create(&b, NULL, funcB, NULL);
	pthread_create(&c, NULL, funcC, NULL);

	if (!pthread_join(b, NULL) && !pthread_join(c, NULL)) 
		printf("bufB[] = %s\nbufC[] = %s\n", bufB, bufC);

	return 0;
}

void *funcB(void *args) {
	char *msg = "funcB is called...";
	strcpy(bufB, msg);
	pthread_exit(0);
}

void *funcC(void *args) {
	char *msg = "funcC is called...";
	strcpy(bufC, msg);
	pthread_exit(0);
}
