#include <stdio.h>
#include <stdlib.h>

#define FILENAME "test1.c"
#define OUT_FILENAME "out.txt"
const int buffsize = 1024;

void process_row(void);
void write_file(void);

int main(void)
{
    process_row();
    // write_file();
    return 0;
}

void process_row()
{
    FILE *fp;
    char buf[buffsize];
    int n = 0;
    if ((fp = fopen(FILENAME, "r")) == NULL)
    {
        perror("fopen");
        exit(1);
    }
    while (fgets(buf, buffsize, fp) != NULL)
    {
        n++;
        printf("%3d: %s", n, buf);
    }
    printf("\n");
    if (fclose(fp) == EOF)
    {
        perror("fclose");
        exit(1);
    }
}

void write_file(void)
{
    FILE *fp_in;
    FILE *fp_out;
    char buf[buffsize];
    int c;
    char r;

    fp_in = fopen(FILENAME, "r");
    if (fp_in == NULL)
    {
        perror("fopen");
        exit(1);
    }
    fp_out = fopen(OUT_FILENAME, "w");
    if (fp_out == NULL)
    {
        perror("fopen");
        exit(1);
    }
    for (;;)
    {
        r = fgets(buf, buffsize, fp_in);
        if (r == NULL)
            break;
    }
}