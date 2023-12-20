#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
    pid_t pid1, pid2;
    printf("----処理開始----\n");
    pid1 = fork();
    if (pid1 == 0)
        printf("1子プロセス\n");
    else
        printf("2親プロセス\n");

    pid2 = fork();
    if (pid1 == 0 && pid2 == 0) // 子プロセスが作った子プロセス
        printf("3子プロセスが作った子プロセス\n");
    else if (pid1 != 0 && pid2 == 0) // 親プロセスが作った子プロセス
        printf("4親プロセスがさらに作った子プロセス\n");

    else if (pid1 == 0 && pid2 != 0) // 子プロセスがそのまま実行
        printf("5子プロセスがそのまま実行\n");
    else if (pid1 != 0 && pid2 != 0) // 親プロセスがそのまま実行
        printf("6親プロセスがそのまま実行\n");
    else
        printf("error\n");
    _exit(0);
}
