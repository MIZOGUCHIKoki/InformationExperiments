#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#define MyBufferSize 5

bool isBlank = false;

struct my_file
{
    int fd;                    // file descriptor
    int count;                 // number of characters read from buffer
    int index;                 // index of next character to be read from buffer
    char buffer[MyBufferSize]; // buffer
};

struct my_file *my_fopen(char *filename)
{
    int fd;
    fd = open(filename, O_RDONLY); // Request OS to open file
    isBlank = false;
    if (fd != EOF)
    {
        struct my_file *fp;                                    // file structure's memory pointer.
        fp = (struct my_file *)malloc(sizeof(struct my_file)); // Allocate memory for file structure.
        (*fp).fd = fd;
        (*fp).count = 0;
        (*fp).index = 0;
        return fp;
    }
    else
    {
        return NULL; // When failed to open, return NULL.
    }
}

int my_fclose(struct my_file *fp)
{
    int r;
    r = close((*fp).fd); // Request OS to close file.
    free(fp);            // Free up memory allocalted by malloc for file structure.
    return r;            // When success to close file, return 0, otherwise return -1(EOF).
}

// Check if array is blank. (If array is blank, return ture.)
bool is_array_blank(char *array, int size)
{
    for (int i = 0; i < size; i++)
    {
        if (array[i] != '\0')
            return false;
    }
    return true;
}

int my_fgetc(struct my_file *fp)
{
    int c, size;
    // When count is 0 or buffer is blank, read file and store it in buffer.
    if ((*fp).index == (*fp).count || is_array_blank((*fp).buffer, MyBufferSize))
    {
        // {-1, numberOfBytes} = read(fileDescriptor, buffer, size);
        size = read((*fp).fd, (*fp).buffer, MyBufferSize);
        (*fp).index = 0; // initialize index
        (*fp).count = size;
        if (size <= 0) // When failed or end of the file, return EOF.
            return EOF;
    }
    if ((*fp).index == (*fp).count)
        return EOF;
    c = (*fp).buffer[(*fp).index]; // Get character from buffer[index]
    (*fp).index++;                 // increment index
    return c;
}

// FOR DEBUG (Auther: Prof. SHIKIDA)
void print_filestr(struct my_file *fp)
{
    int i;
    fprintf(stderr, "count:%d index:%d  |", fp->count, fp->index);
    for (i = 0; i < MyBufferSize; i++)
    {
        fprintf(stderr, " %02x", fp->buffer[i]);
    }
    fprintf(stderr, " |\n");
}

// (Auther: Prof. SHIKIDA)
int main(int argc, char *argv[])
{
    struct my_file *fp;
    if (argc != 2)
    {
        fprintf(stderr, "Usage: myfile filename\n");
        return 1;
    }
    fp = my_fopen(argv[1]);
    if (fp == NULL)
    {
        fprintf(stderr, "my_fopen: can't open %s\n", argv[1]);
        return 1;
    }
    print_filestr(fp);
    int c;
    for (;;)
    {
        c = my_fgetc(fp);
        print_filestr(fp);
        if (c == EOF)
            break;

        printf("c:%02x\n", c);
    }
    my_fclose(fp);
    return 0;
}
