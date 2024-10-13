#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h> // For system 

int main(void) {
	pid_t pid;
	int status;

	if ((pid = fork()) < 0) return 1;
	if (pid == 0) {
		system("ls -al /usr/local");
	}
	else {
		waitpid(pid, &status, 0);
		return 0;
	}
}
