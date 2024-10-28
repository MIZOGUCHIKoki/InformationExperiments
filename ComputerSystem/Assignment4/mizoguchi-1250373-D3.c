#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h> // malloc()
#include <fcntl.h> // For O_* constatns

#define BUF_SIZE 5

void *producer(void *param);
void *consumer(void *param);

struct params {
	sem_t *semE;
	sem_t *semS;
	int inP;
	int outP;
	char buf[BUF_SIZE];
};
int main(void) {
	const char* semName_E = "/Elements";
	const char* semName_S = "/Spaces";
	sem_t *semE, *semS;
	semE = sem_open(semName_E, O_CREAT, 0666, 1);
	semS = sem_open(semName_S, O_CREAT, 0666, BUF_SIZE);

	struct params *params;
	params = (struct params *)malloc(sizeof(struct params));
	pthread_t pro, cons1, cons2;
	params->semE = semE;
	params->semS = semS;
	params->inP = 0;
	params->outP = 0;
	pthread_create(&pro, NULL, producer, params);
	pthread_create(&cons1, NULL, consumer, params);
	pthread_create(&cons2, NULL, consumer, params);

	pthread_join(pro, NULL);
	pthread_join(cons1, NULL);
	pthread_join(cons2, NULL);

	return 0;
}

void *producer(void *params) {
	int i;
	struct params *arg = (struct params *)params;
	while(1) {
		i = rand() % 10;
		sem_wait(arg->semS); // Gets 1 space
		arg->buf[arg->inP] = i; 
		arg->inP = (arg->inP + 1) % BUF_SIZE;
		sem_post(arg->semE); // Notice producing.
	}

	pthread_exit(0);
}
void *consumer(void *params) {
	int i;
	struct params *arg = (struct params *)params;
	printf("%d\n", arg->outP);
	while(1) {
		sem_wait(arg->semE); // Gets 1 element

		i = arg->buf[arg->outP];
		arg->outP = (arg->outP + 1) % BUF_SIZE;
		sem_post(arg->semS); // Notice cousuming
		printf("data = %d\n", i);
	}
	pthread_exit(0);
}
