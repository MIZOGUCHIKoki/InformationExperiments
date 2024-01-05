#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

// 定数の宣言
// 効率化を考えるなら 1KB とか 4KB とか，ある程度の大きさが必要だが，
// 動作確認のためには小さな値にしてみるとよい．
#define MyBufferSize 5

// ファイル構造体FILEに相当する構造体
// 本物のライブラリーで用意されている FILE を使ってはいけない．
struct my_file
{
    int fd;                    /* ファイルディスクリプター */
    int count;                 /* ファイルから読んだ文字数 */
    int index;                 /* 次に使う位置 */
    char buffer[MyBufferSize]; /* バッファー */
};

struct my_file *my_fopen(char *filename)
{
    int fd;
    fd = open(filename, O_RDONLY);
    if (fd != EOF)
    {
        struct my_file *fp;
        fp = (struct my_file *)malloc(sizeof(struct my_file));
        fp->fd = fd;
        // 必要な初期化を加筆する
        return fp;
    }
    else
    {
        return NULL; /* オープンできなかった場合 */
    }
}

int my_fclose(struct my_file *fp)
{
    int r;
    // OSに対してクローズ処理を要求
    // ファイル構造体用のメモリー領域を開放する
    return r;
}

int my_fgetc(struct my_file *fp)
{
    int c, size;
    // バッファーが空ならOSから read する
    // バッファーから1文字取って返す
    return c;
}

// デバッグ用にファイル構造体の中を出力する
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
        {
            break;
        }
        printf("c:%02x\n", c);
    }
    my_fclose(fp);
    return 0;
}
