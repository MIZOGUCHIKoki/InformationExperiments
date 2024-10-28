#include <stdio.h>
#include <pthread.h>

int count = 0;

void *func1(void *param) {
	int i;
	for (i = 0; i < 100000; i++) {
		count++;
	}
	pthread_exit(0);
}
void *func2(void *param) {
	int i;
	for (i = 0; i < 100000; i++) {
		count++;
	}
	pthread_exit(0);
}

int main () {
	pthread_t tid1, tid2;
	pthread_create(&tid1, NULL, func1, NULL);
	pthread_create(&tid2, NULL, func2, NULL);
	pthread_join(tid1, NULL);
	pthread_join(tid2, NULL);

	printf("\ncoun = %d\n\n", count);
	return 0;
}
