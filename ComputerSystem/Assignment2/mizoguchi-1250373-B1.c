#include <stdio.h> // FOR standard IO
#include <unistd.h> // FOR pipe(), fork()
#include <string.h> // FOR memset()
#include <sys/wait.h> // FOR wait()

#define BUF_SIZE 256


/*
	more informations about wait() and macros of waiting are following:
	https://www.c-lang.net/wait/index.html
*/
int main(void) {
	int pipefd[2];
	int pid;
	char buffer[BUF_SIZE];
	int status;
	memset(buffer, '\0', BUF_SIZE); // initialize the buffer

	pipe(pipefd);
	pid = fork();

	if (pid == 0) { // Child Process
		read(pipefd[0], buffer, BUF_SIZE);
		//printf("strlen(buffer) = %lu\n", strlen(buffer));
		buffer[strlen(buffer) - 1] = ' ';
		char msg[21] = "from child process.";
		char *rst = strcat(buffer, msg);
	  //printf("CP: %s\n", rst);
		write(pipefd[1], rst, BUF_SIZE + 21);
	} else { // Parents Process
		fgets(buffer, BUF_SIZE, stdin);
		write(pipefd[1], buffer, BUF_SIZE);
		wait(&status); // wait child process
		read(pipefd[0], buffer, BUF_SIZE);
		printf("%s\n", buffer);
	}
	// Close pipe file discripter
	close(pipefd[0]);
	close(pipefd[1]);
	return 0;
}
