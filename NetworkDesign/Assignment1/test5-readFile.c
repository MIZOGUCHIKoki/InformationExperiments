#include <stdio.h>
#include <stdlib.h>
#define FILENAME "test1.c"

int main(void)
{
    FILE *fp;
    int c;     // 読んだ文字
    int n = 0; // 文字数
    int r;

    fp = fopen(FILENAME, "r"); // fpにはファイルの先頭アドレスが入る
    // FILE *fopen(const char *filename, const char *mode)

    if (fp == NULL)
    {
        fprintf(stderr, "ファイルがオープンできません（%s）\n", FILENAME);
        exit(1);
    }
    for (;;)
    {
        c = fgetc(fp);
        if (c == EOF)
            break;
        n++;
    }
    r = fclose(fp);
    if (r == EOF)
    {
        perror("fclose");
        exit(1);
    }
    printf("%sの文字数は%dです\n", FILENAME, n);

    return 0;
}