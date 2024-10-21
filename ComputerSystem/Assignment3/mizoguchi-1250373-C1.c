#include <stdio.h>
#include <unistd.h> // fork()
#include <stdlib.h> // malloc()
#include <time.h> // time_t, time()
#include <sys/resource.h> // set/getpriority()
#include <errno.h> // errno
#include <string.h> // strcpy(), strerror()

struct prop_process {
	int priority; // Process Priority
	pid_t pid; // Process ID
	char p_prop[10]; // ProcessName
};

void printStruct(struct prop_process *pp, char *msg) {
	printf("%-8s PID = %5d, PRIORITY = %3d [IN struct prop_process]\n", msg, pp->pid, pp->priority);
}

void printError(int commandReturn, int errNo, char msg[17]) {
	printf("%-17s RESULT = %3d, ERRNO = %2d, MSG = %s\n", msg, commandReturn, errNo, strerror(errNo));
}

void function(void) {
	unsigned long int i;
	for (i = 0; i < 10000000000; i++) {
	}
}


void printUsedTime(struct prop_process *pp, struct timespec *s_time) {
	struct timespec e_time;
	clock_gettime(CLOCK_REALTIME, &e_time);
	unsigned int sec;
	int n_sec;
	double result;
	sec = e_time.tv_sec - s_time->tv_sec;
	n_sec = e_time.tv_nsec - s_time->tv_nsec;
	result = (double)sec + (double)n_sec / (1000 * 1000 * 1000); // n = 10^-{3[m]+3[mu]+3[n]}
	printf("=== %8s ===\n\t%f s\n", pp->p_prop, result);
}

int main(void) {

	pid_t pid;
	

	struct prop_process *parentsProcess;
	parentsProcess = (struct prop_process *)malloc(sizeof(struct prop_process));
	struct prop_process *childProcess;
	childProcess = (struct prop_process *)malloc(sizeof(struct prop_process));

	parentsProcess->priority = -19;
	strcpy(parentsProcess->p_prop, "PARENTS");
	childProcess->priority = 19;
	strcpy(childProcess->p_prop, "CHILD");

	struct timespec s_time;
	clock_gettime(CLOCK_REALTIME, &s_time);

	pid = fork();
	errno = 0;

	if (pid != 0) { // Parents process
		parentsProcess->pid = getpid();
		printError(setpriority(PRIO_PROCESS, parentsProcess->pid, parentsProcess->priority), errno, "setpriority");
		printError(getpriority(PRIO_PROCESS, parentsProcess->pid), errno, "getpriority");
		printf("%-8s PID = %5d, PRIORITY = %3d\n", "PARENTS", getpid(), getpriority(PRIO_PROCESS, parentsProcess->pid));
		printStruct(parentsProcess, parentsProcess->p_prop);
		function();
		printUsedTime(parentsProcess, &s_time);
	} 

	else if (pid == 0) { // Child proces;
		childProcess->pid = getpid();
		printf("(Forked from PID:%5d Process)\n", getppid());
		printError(setpriority(PRIO_PROCESS, childProcess->pid, childProcess->priority), errno, "setpriority");
		printError(getpriority(PRIO_PROCESS, childProcess->pid), errno, "getpriority");
		printf("%-8s PID = %5d, PRIORITY = %3d\n", "CHILD", getpid(), getpriority(PRIO_PROCESS, childProcess->pid));
		printStruct(childProcess, childProcess->p_prop);
		function();
		printUsedTime(childProcess, &s_time);
	}

	return 0;
}
