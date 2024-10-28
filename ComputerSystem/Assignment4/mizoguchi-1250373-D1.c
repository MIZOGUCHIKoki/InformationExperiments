#include <stdio.h>
#include <string.h> // memset()
#include <unistd.h> // stdin
#include <pthread.h>
#include <semaphore.h>
#include <fcntl.h> // For O_* constants

void *func(void *param);
char buf[256];
const char* semName = "/sem";
sem_t *sem;

int main() {
	memset(buf, ' ', 256);
	pthread_t tid;
	pthread_create(&tid, NULL, func, NULL);

	sem  = sem_open(semName, O_CREAT, 0666 , 1);
	sem_wait(sem); // wait()
	printf("\nParents Process: > ");
	fgets(buf, 256, stdin);
	sem_post(sem); // Signal()
	pthread_join(tid, NULL);
	sem_close(sem);
	return 0;
}

void *func(void *param) {
	sem_wait(sem); // wait()
	printf("\nThread: > %s\n", buf);
	sem_post(sem); // Signal()
	pthread_exit(0);
}
