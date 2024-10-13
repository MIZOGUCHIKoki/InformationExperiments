#include <stdio.h>
#include <unistd.h> // FOR pid_t, getpid(), and other process processing
#include <sys/wait.h> // FOR waitipd

int main(void) {
	pid_t pid1;
	int status;

	if ((pid1 = fork()) < 0) return 1;
	if (pid1 == 0) {
		printf("child process, Process ID = %d\n", getpid());
	}
	else {
		waitpid(pid1, &status, 0);
		printf("parent process, Process ID = %d\n", getpid());
	}
	return 0;
}
