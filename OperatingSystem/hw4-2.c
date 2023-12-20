/*
マルチスレッド処理
＜親プロセスA＞
    1. 書き込みが終了したことを示す大域変数flagを0に初期化する．
    2. 子スレッドBをpthred_create関数により生成する．
    3. 標準入力により，メッセージ（255バイト以下）を受け取る．
    4. メッセージを大域変数buffに書き込む．
    5. 書き込みを終了したことを示す大域変数flagを1に変更する．
    6. 子スレッドBの終了を待ち，終了する．
＜子スレッドB＞
    1. 書き込みが終了したことを示すflagが1になるまで無限ループを実行する．
    2. 大域変数flagが1になると，大域変数buffからメッセージを読み標準出力に表示する．
    3. 終了する．
*/
#include <stdio.h>
#include <pthread.h>
int flag = 0;
char buff[256];
void *func(void *param)
{
    while (flag == 0)
        ;

    printf("\n Thread -> %s\n", buff);
    pthread_exit(0);
}

int main()
{
    pthread_t tid;

    pthread_create(&tid, NULL, func, NULL);
    printf("\n parent process : input message -> ");
    scanf("%s", buff);
    flag = 1;
    pthread_join(tid, NULL);
    return 0;
}