#include <stdio.h>
#include <unistd.h> // sleep()
#include <stdlib.h> // rand()
#include <pthread.h>

#include <semaphore.h>
#include <fcntl.h> // For O_* constants

void *func1(void *param);
void *func2(void *param);
int counter = 0;
const char* semName = "/sem";
sem_t *sem;

int main(void) {
	sem = sem_open(semName, O_CREAT, 0666, 1);
	pthread_t tid1, tid2;

	pthread_create(&tid1, NULL, func1, NULL);
	pthread_create(&tid2, NULL, func2, NULL);

	pthread_join(tid1, NULL);
	pthread_join(tid2, NULL);
	return 0;
}

void *func1(void *param) {
	int i, tmp;
	for (i = 0; i < 10; i++) {
		sem_wait(sem);
		tmp = counter;
		sleep(rand() % 4);
		tmp += 3;
		counter = tmp;
		sem_post(sem);
		printf("\ni = %d counter = %d", i, counter);
	}
	pthread_exit(0);
}

void *func2(void *param) {
	int k, tmp;
	for (k = 0; k < 10; k++) {
		sem_wait(sem);
		tmp = counter;
		sleep(rand() % 4);
		tmp += 5;
		counter = tmp;
		sem_post(sem);
		printf("\nk = %d counter = %d", k, counter);
	}
	pthread_exit(0);
}
