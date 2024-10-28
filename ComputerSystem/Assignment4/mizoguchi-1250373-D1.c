#include <stdio.h>
#include <string.h> // memset()
#include <unistd.h> // stdin
#include <pthread.h>

void *func(void *param);
int flag = 0;
char buf[256];

int main() {
	memset(buf, ' ', 256);

	pthread_t tid;
	pthread_create(&tid, NULL, func, NULL);

	printf("\nParents Process: > ");
	fgets(buf, 256, stdin);
	flag = 1;
	pthread_join(tid, NULL);
	return 0;
}

void *func(void *param) {
	while (flag == 0);
	printf("\nThread: > %s\n", buf);
	pthread_exit(0);
}
