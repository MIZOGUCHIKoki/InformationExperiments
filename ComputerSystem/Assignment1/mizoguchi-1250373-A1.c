#include <stdio.h> // FOR STANDARD IO
#include <stdlib.h> // FOR OPEN, CLOSE
#include <fcntl.h> // FOR arges of open/close
#include <unistd.h> // FOR READ / WRITE
#include <string.h> // FOR memset

// DEFINE name and age as global variables.
char name[] = "MIZOGUCHI Koki";
unsigned short age = 22;

// define file path to refer.
char* file_input = "./inputfile.txt";

struct file {
	int fd; // file descriptor
	// This time, index and counter are not necessary..
};

int main(int argc, char *argv[]) {
	int i = 0, j = 0; // general variables
	
	if (argc != 2) return 1;

	struct file *file_out;
	file_out = (struct file *)malloc(sizeof(struct file));
	file_out->fd = open(argv[1], O_WRONLY, O_TRUNC);
	int fd_out = file_out->fd;
	//int fd_out = 1;

	char *breakLine = "\n";

	char buf_age[4];
	if ((i = age / 100) != 0) buf_age[0] = (char)(age / 100 + 0x30);
	else buf_age[0] = ' ';
	buf_age[1] = (char)((age - (age / 100) * 100 - age % 10) / 10 + 0x30);
	buf_age[2] = (char)(age % 10 + 0x30);
	
	if (write(fd_out, name, sizeof(name)) == EOF) return 1;
	if (write(fd_out, breakLine, sizeof(char)) == EOF) return 1;
	if (write(fd_out, buf_age, sizeof(buf_age)) == EOF) return 1;
	if (write(fd_out, breakLine, sizeof(char)) == EOF) return 1;

	char buf[2];
	memset(buf, 0, sizeof(buf));

	struct file *file_in;
	file_in = (struct file *)malloc(sizeof(struct file));
	
	file_in->fd = open(file_input, O_RDONLY);
	if (file_in->fd == EOF) return 1;

	for (;;) {
		j = read(file_in->fd, buf, 1);
		if (j == 0 || j == EOF) break;
		write(fd_out, buf, 1);
	}
	return 0;
}
