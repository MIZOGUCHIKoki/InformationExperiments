/*
マルチプロセス処理
＜親プロセスA＞
    1. パイプを作成する
    2. 子プロセスBをforkシステムコールにより生成する．
    3. 標準入力により，メッセージ（255バイト以下）を受け取る．
    4. メッセージをパイプに書き込む．
    5. 子プロセスBの終了を待ち，終了する．
＜子プロセスB＞
    1. パイプからメッセージを読み出す．
    2. 読み出したメッセージを標準出力に出力する．
    3. 終了する．
*/

#include <stdio.h>
#include <unistd.h>

int main()
{
    pid_t pid;
    int pdf[2];
    char buff[256];
    int status;

    pipe(pdf);
    pid = fork();

    if (pid == 0) // 子プロセス
    {             // パイプから読み込み，標準出力へ出力
        read(pdf[0], buff, 256);
        printf("\n child process -> %s\n", buff);
    }
    else
    {
        printf("\n parent process : input message -> ");
        scanf("%s", buff);        // 標準入力から入力
        write(pdf[1], buff, 256); // パイプへ書き込み
    }
}