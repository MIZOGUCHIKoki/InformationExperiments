#include <stdio.h>
#include <unistd.h>

enum
{
    BUFFER_SIZE = 32 * 1024 * 1024
};
int main(void)
{
    FILE *fp;
    int fd = open("test.txt");
    fp = fopen("test.txt", "+");
    char buf[BUFFER_SIZE];

    // Low level API(Write)
    fwrite(buf, sizeof(char), BUFFER_SIZE, fp);

    // High level API(Write)
    for (int i = 0; i < BUFFER_SIZE; i++)
    {
        fputc(buf[i], fp);
    }

    write(fd, buf, BUFFER_SIZE);

    for (int i = 0; i < BUFFER_SIZE; i++)
    {
        write(fd, buf[i], 1);
    }
    fclose(fp);
}