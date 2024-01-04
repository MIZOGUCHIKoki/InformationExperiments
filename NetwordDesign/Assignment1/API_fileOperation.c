#include <stdio.h>
#include <stdlib.h>

#define FILENAME "test1.c"
#define OUT_FILENAME "out.txt"

void fileOperation(void);
void IOby1Char(FILE *fp, FILE *fp_out);
void IObyRow(FILE *fp);

int main(void)
{
    fileOperation();
    FILE *fp;
    FILE *fp_out;
    if ((fp = fopen(FILENAME, "r")) == NULL || (fp_out = fopen(OUT_FILENAME, "w")) == NULL)
    {
        perror("fopen");
        exit(1);
    }
    IOby1Char(fp, fp_out);
    IObyRow(fp);
    if (fclose(fp) == EOF || fclose(fp_out) == EOF)
    {
        perror("fclose");
        exit(1);
    }
    return 0;
}

/*
-- OPEN / CLOSE FILE --
FILE *fopen(const char *filename, const char *mode);
    >> If failed, return NULL.
int *fclose(FILE *stream);
    >> If failed, return EOF. (EOF is -1, so the type of *fclose is int.)
[mode]
r: read only
w: write only
a: append
+: read and write
b: binary (No distinction in UNIX)
*/
void fileOperation(void)
{
    printf("-----fileOperation-----\n");
    FILE *fpp;                   // file descriptor
    printf(" fpp = %p\n", fpp);  // contents of fpp
    printf("&fpp = %p\n", &fpp); // address of fpp
    int r;
    fpp = fopen(FILENAME, "r"); // open file
    // *fpp points to the address of the opened file.
    printf("--oepn file--\n");
    printf(" fpp = %p\n", fpp);  // contents of fpp
    printf("&fpp = %p\n", &fpp); // address of fpp
    if (fpp == NULL)
    {
        perror("fopen");
        exit(1);
    }
    r = fclose(fpp); // close file
    if (r == EOF)
    {
        perror("fclose");
        exit(1);
    }
}

/*
-- OUTPUT and INPUT by 1 character --
int getc(FILE *stream);     // macro(or function)
int fgetc(FILE *stream);    // function
int getchar(void);          // same as getc(stdin). "stdin" is a standard input.
--
int putc (int c, FILE *stream); // macro(or function)
int fputc(int c, FILE *stream); // function
int putchar(int c); // same as putc(c, stdout). "stdout" is a standard output.
*/
void IOby1Char(FILE *fp, FILE *fp_out)
{
    char c;
    if ((c = fgetc(fp)) == EOF) // read 1 char from fp.
    {
        perror("fgetc");
        exit(1);
    }
    if (fputc(c, fp_out) == EOF)
    {
        perror("fputc");
        exit(1);
    }
    printf("c = %c\n", c);

    if ((c = fgetc(fp)) == EOF) // read next 1 char from fp.
    {
        perror("fgetc");
        exit(1);
    }
    if (fputc(c, fp_out) == EOF)
    {
        perror("fputc");
        exit(1);
    }
    printf("c = %c\n", c);
}

/*
-- OUTPUT and INPUT by row --
char *fgets(char *s, int size, FILE *stream);
char *gets(char *s); // deprecated!
    >> If success return buf, else return NULL.
    >> gets deletes '\n', but fgets doesn't.
    >> Both of them add '\0'(null char) at the end of the line.
--
int fputs (const char *str, FILE *fp);
int puts (const char *str);
    >> If success, return non-negative value, else return EOF.
    >> puts adds '\n' at the end of the line, but fputs doesn't.
*/
void IObyRow(FILE *fp)
{
    int buffsize = 7; // 6 + '\0'
    char buf[buffsize];
    char *r;
    r = fgets(buf, buffsize, fp);
    if (r == NULL)
    {
        perror("fgets");
        exit(1);
    }
    printf("buf = %s\n", buf);
    printf("r = %s\n", r);
    fgets(buf, buffsize, stdin); // from standard input.
    printf("buf = %s\n", buf);

    if (fputs(buf, stdout) == EOF)
    {
        perror("fputs");
        exit(1);
    }
    printf("\n");
}