#include <stdio.h>      // printf(), fprintf()
#include <sys/socket.h> // socket(), connect(), send(), recv()
#include <netdb.h>      // struct addrinfo, getaddrinfo(), gai_strerror()
#include <arpa/inet.h>  // sockaddr_in, inet_addr()
#include <stdlib.h>     // atoi()
#include <string.h>     // memset()
#include <unistd.h>     // close()

#define RCVSIZE 32 // Size of receive buffer

void ErrorHandling(char *message);                 // Error handling function
char *HostName2IpAddr(char *hostName, char *port); // Convert host name to IP address

// bufの中には、送信したいデータが入っている
// lenは、送信したいデータの長さ
// sockfdは、ソケットのファイルディスクリプタ
// この関数は、送信したいデータの長さだけ送信する
// 送信したいデータの長さだけ送信するということは、
// 送信したいデータの長さだけ送信するまで、write()を繰り返し呼び出すということ

ssize_t send_all(int sockfd, const void *buf, size_t len)
{
    ssize_t total_sent = 0; // 送信したデータの長さ
    ssize_t sent;           // 送信したデータの長さが入る予定の変数

    while (total_sent < len) // 送信したデータの長さが、送信したいデータの長さよりも小さい間は、繰り返し
    {
        sent = write(sockfd, buf + total_sent, len - total_sent); // 送信したデータの長さがsendに格納される
        // write()は、第一引数にファイルディスクリプタ、第二引数に送信したいデータ、第三引数に送信したいデータの長さを指定する
        // write(ソケット, 送信したいデータ, 送信したいデータの長さ)
        // buf+total_sentは、送信したいデータの先頭アドレスから送信したいデータの長さだけずらしたアドレス
        // len-total_sentは、送信したいデータの長さから送信したデータの長さを引いた値
        // つまり、まだ送信していないデータの長さ
        if (sent == -1)
        {
            perror("write");
            return -1;
        }
        total_sent += sent; // 送信したデータの長さを更新
    }

    return total_sent;
}

int main(int argc, char *argv[])
{
    printf(">> executed client ------ \n");
    int sock;                       // socket descriptor
    struct sockaddr_in server_addr; // server address structure
    char *serverHostFromArgs;       // server host from command line
    // char *serverIpAddr;             // server IP address
    char *serverPort;              // server port
    char *sendString;              // string to send to server
    unsigned int sendStringLen;    // length of sendString
    char Buffer[RCVSIZE];          // Buffer for received string
    unsigned int BufferLen;        // length of Buffer
    int bytesRcvd, totalBytesRcvd; // bytes read in single recv() and total bytes read

    if (argc != 3) // Test for correct number of arguments
    {
        fprintf(stderr, "Usage: %s <Server Host name> <Server Port>\n", argv[0]); // argv[0] is in executable file name
        exit(1);
    }
    printf("Host Name   : %s\n", argv[1]);
    printf("Port number : %s\n", argv[2]);

    serverHostFromArgs = argv[1]; // First arg: server host name
    serverPort = argv[2];         // Third arg: server port

    // Convert host name to IP address

    if ((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) // Create a reliable, stream socket using TCP
    {
        ErrorHandling("socket() failed");
    }

    /* some functions description:
    inet_addr() converts [the Internet host address from IPv4 numbers-and-dots notation] into [binary data in network byte order].
    htons() converts [number from host byte order] to [number in network byte order].
    atoi() converts [string] to [integer].
    inet_ntop() converts [the network byte ordered 32-bit IPv4 address] to [dotted-decimal format].

    - connetct(socket descriptor, server address structure, size of server address structure);
        if success, return 0, else return -1.
    - send(socket descriptor, string to send, length of string to send, flag);
        if success, return number of bytes sent, else return -1.
    - inet_ntop(address family, pointer to binary data, pointer to string to store result, length of string to store result)
        if success, return pointer to string, else return NULL.
    */

    // Construct the server address structure
    memset(&server_addr, 0, sizeof(server_addr)); // Zero out structure
    server_addr.sin_family = AF_INET;             // Internet address family
    char *serverIpAddr = HostName2IpAddr(serverHostFromArgs, serverPort);
    printf("serverIpAddr: %s\n", serverIpAddr);
    server_addr.sin_addr.s_addr = inet_addr(serverIpAddr);
    server_addr.sin_port = htons(atoi(serverPort)); // Server port
    // sendString = "Hello, world!";                   // String to send
    // sendStringLen = strlen(sendString);

    // Establish the connection to the server
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) // server_addr is a pointer to [struct sockaddr_in]
    {
        close(sock);
        ErrorHandling("connect() failed");
    }

    /*select関数はFDの集合を監視(ここでブロッキングが発生)、
    集合内の要素にアクション(変化)があった場合にブロッキングを解いて動作を終了する...というような動作をする関数
    例えば、FDの集合にソケットを数個入れた状態でselect関数を実行すると、
    いずれかのソケットに対してwrite関数等でデータ受信が発生するまで待機(ブロッキング)する...という動作ができるということです。
    */
    fd_set read_fds; // ファイルディスクリプタの集合
    // fd_setは、ファイルディスクリプタの集合を表すデータ型
    int max_fd; // ファイルディスクリプタの最大値
    while (1)
    {
        FD_ZERO(&read_fds);              // ファイルディスクリプタの集合を空にする.つまり、初期化を行う
        FD_SET(STDIN_FILENO, &read_fds); // 標準入力を監視するように設定。STDIN_FILENOは、標準入力のファイルディスクリプタ
        // 標準入力をselect()で監視する集合に追加するということ
        FD_SET(sock, &read_fds); // ソケットを監視するように設定。sockは、ソケットのファイルディスクリプタ
        // FD_SET(STDOUT_FILENO, &read_fds)ではない理由は、クライアントからの標準出力は監視しないから
        // 受信に関するのはsock
        // サーバー側からのデータを受信するために、ソケットをselect()で監視する集合に追加するということ
        //  FD_ISSET()は、ファイルディスクリプタが監視対象の集合に含まれているかどうかを調べる
        // 監視対象とは、select()の第二引数に指定した集合のことで
        // 何か変更があった場合にselect()の戻り値が0より大きくなる
        max_fd = (sock > STDIN_FILENO) ? sock : STDIN_FILENO; // ファイルディスクリプタの最大値を計算

        // select()は、ファイルディスクリプタの監視を行う
        // 引数の意味は、
        // 第一引数にファイルディスクリプタの最大値+1、
        // 第二引数に監視対象の集合、
        // 第三引数に書き込み可能かどうかを調べるかどうかを指定する集合、
        // 第四引数に例外状態を調べるかどうかを指定する集合、
        // 第五引数にタイムアウト時間を指定する
        if (select(max_fd + 1, &read_fds, NULL, NULL, NULL) == -1) // ファイルディスクリプタの監視
        {
            perror("select");
            exit(EXIT_FAILURE);
        }

        // FD_ISSET()は、ファイルディスクリプタが監視対象の集合に含まれているかどうかを調べる
        // 具体的には、第一引数にファイルディスクリプタ、第二引数に監視対象の集合を指定する
        if (FD_ISSET(STDIN_FILENO, &read_fds)) // 標準入力からデータを読み込んでサーバーに送信
        {
            // 標準入力からデータを読み込んでサーバーに送信
            char buffer[RCVSIZE]; // バッファ
            // ssize_tは符号付き整数型で、read()やwrite()のようなシステムコールの戻り値の型として使われる
            ssize_t bytes_read = read(STDIN_FILENO, buffer, sizeof(buffer)); // 標準入力から読み込む
            // bytes_readは、read()が返す値で、読み込んだバイト数を表す
            // この値をサーバーに転送する関数に引数として渡すことで、読み込んだバイト数だけサーバーに転送することができる

            if (bytes_read == 0)
            {          // ファイルの終わりなら0を返すため
                break; // bytes_readが0の場合はEOFなので終了
            }
            else if (bytes_read == -1) //-1はエラー
            {                          // エラーが発生したら終了
                perror("read");        // perror()は、errnoに設定されているエラー番号に対応するエラーメッセージを出力する
                exit(EXIT_FAILURE);    // exit()は、プロセスを終了する
            }

            if (send_all(sock, buffer, bytes_read) == -1) // send_all()は、送信したいデータの長さだけ送信する関数
            {
                // エラーが発生したら終了
                break;
            }
        }

        if (FD_ISSET(sock, &read_fds)) // ソケットからデータを受信
        {
            // サーバーからデータを受信して標準出力に出力
            char buffer[RCVSIZE];
            ssize_t bytes_received = read(sock, buffer, sizeof(buffer)); // bufferから読み込んだバイト数をbytes_receivedに格納する
            if (bytes_received == 0)
            {
                // サーバーが切断した場合
                break;
            }
            else if (bytes_received == -1)
            {
                perror("read");
                exit(EXIT_FAILURE);
            }

            write(STDOUT_FILENO, buffer, bytes_received); // 読み込んだものを標準出力に出力する
        }
    }

    close(sock);
    return 0;
}

char *HostName2IpAddr(char *hostName, char *port)
{
    struct addrinfo moreInfo, *response;    // More info about host
    memset(&moreInfo, 0, sizeof(moreInfo)); // Zero out structure
    moreInfo.ai_family = AF_INET;           // IPv4 only
    moreInfo.ai_socktype = SOCK_STREAM;     // Only TCP

    char *ra = (char *)malloc(INET_ADDRSTRLEN);

    if (getaddrinfo(hostName, port, &moreInfo, &response) != 0)
    {
        ErrorHandling("getaddrinfo() failed");
    }

    // inet_ntoa() is a legacy function that converts the network byte ordered 32-bit IPv4 address to dotted-decimal format
    // inet_ntop() converts the network byte ordered 32-bit IPv4 address to dotted-decimal format
    if (inet_ntop(AF_INET, &((struct sockaddr_in *)response->ai_addr)->sin_addr, ra, INET_ADDRSTRLEN) == NULL)
    {
        ErrorHandling("inet_ntop() failed");
    }
    printf("IP address of %s is %s\n", hostName, ra);
    freeaddrinfo(response); // Free address structure
    return ra;
}
