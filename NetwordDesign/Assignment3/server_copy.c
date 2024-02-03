#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h> // inet_addr()
#include <sys/socket.h>
#include <sys/select.h>
#include <fcntl.h>
#define MAX_BUFFER_SIZE 256

enum
{
    SEVER_PORT = 12345,
    NQUEUESIZE = 5, // listen()の第二引数に指定する、接続待ちのキューの最大長
    MAX_CLIENTS = 5,
};

typedef struct
{
    char name[20];
    int price;
    int stock;
} Product;

int clients[MAX_CLIENTS]; // クライアントのファイルディスクリプタを格納する配列
int num_clients = 0;      // クライアントの数
int in_coin[MAX_CLIENTS] = {};
int product[MAX_CLIENTS] = {};
fd_set readfds; // select()で用いるファイルディスクリプタの集合

// クライアントを削除する関数
void delete_client(int client_fd)
{
    int i;
    for (int i = 0; i < num_clients; i++) // クライアントの数だけ繰り返し
    {
        if (clients[i] == client_fd) // クライアントのファイルディスクリプタが、引数のファイルディスクリプタと一致した場合
        {
            // FD_CLR(clients[i], &readfds);//クライアントのファイルディスクリプタをクリア
            printf("Client disconnected. (Client FD: %d)\n", client_fd);
            clients[i] = clients[num_clients - 1]; // クライアントのファイルディスクリプタを、クライアントの数-1番目のファイルディスクリプタにする
            num_clients--;                         // クライアントの数をデクリメント
            // 格納しているデータを初期化
            // clients[i] = 0;//クライアントのファイルディスクリプタを0にする
            in_coin[i] = 0;
            product[i] = -1;
            shutdown(client_fd, SHUT_WR); // クライアントのファイルディスクリプタをシャットダウン
            close(client_fd);             // クライアントのファイルディスクリプタをクローズ
            break;
        }
    }
    printf("num_clients: %d\n", num_clients);
    return;
}

// これは購入ドリンクの金額に対して、足りているかを判定する関数
void check_payment(int payment, int client_fd, Product products[], int num_products, int selected_product, int num_clients)
{
    char buffer[MAX_BUFFER_SIZE];

    memset(buffer, 0, MAX_BUFFER_SIZE);
    ssize_t read_size = read(client_fd, buffer, MAX_BUFFER_SIZE);

    if (read_size < 0)
    {
        printf("read error,check_payment\n");
        delete_client(client_fd);
        return;
    }
    else if (read_size == 0)
    {
        delete_client(client_fd);
        return;
    }

    if (strcmp(buffer, "x") == 0 || strcmp(buffer, "X") == 0) // キャンセルの場合
    {
        write(client_fd, "Purchase canceled.\n", 19);
        return;
    }
    int amount = atoi(buffer);
    if (amount <= 0)
    {
        write(client_fd, "Invalid payment amount.\n", 24);
        return;
    }
    payment += amount;
    in_coin[num_clients] = payment;
    if (payment >= products[selected_product].price)
    {
        snprintf(buffer, MAX_BUFFER_SIZE, "Payment(%d): %d\n", payment, products[selected_product].price);
        write(client_fd, buffer, strlen(buffer));
        if (products[selected_product].stock <= 0)
        {
            write(client_fd, "\n\nSold out.\n\n\n", 15);
        }
        else
        {
            products[selected_product].stock--;
            snprintf(buffer, MAX_BUFFER_SIZE, "%s purchased! Change: %d\n", products[selected_product].name, payment - products[selected_product].price);
            write(client_fd, buffer, strlen(buffer));
        }

        in_coin[num_clients] = 0;
        product[num_clients] = -1;
        for (int i = 0; i < num_products; ++i)
        {
            snprintf(buffer, MAX_BUFFER_SIZE, "%s(%d(%d)) ", products[i].name, products[i].price, products[i].stock);
            write(client_fd, buffer, strlen(buffer));
        }
        write(client_fd, "\n", 1);
        write(client_fd, "select product", 15);
        return;
    }
    else
    {
        snprintf(buffer, MAX_BUFFER_SIZE, "Payment(%d): ", payment);
        write(client_fd, buffer, strlen(buffer));
        return;
    }
}

void return_payment(int client_fd, Product products[], int num_products, int num_clients)
{
    char buffer[MAX_BUFFER_SIZE];
    ssize_t read_size = read(client_fd, buffer, MAX_BUFFER_SIZE);
    if (read_size < 0)
    {
        printf("read error,return_payment\n");
        perror("read");
        // exit(1);
        return;
    }
    else if (read_size == 0)
    { // クライアントがdisconnectを送信した場合の処理
        delete_client(client_fd);
        return;
    }
    // 支払金額を待機
    int selected_product = -1;
    for (int i = 0; i < num_products; ++i)
    {
        if (strncmp(buffer, products[i].name, strlen(products[i].name)) == 0)
        {
            selected_product = i;
            product[num_clients] = i;
            break;
        }
    }

    if (selected_product == -1) // 商品がない
    {
        // write(client_fd, "disconnected\n", 13); // ここで切断する
        delete_client(client_fd);
        return;
    }

    // in_coin[client_fd] = atoi(buffer);

    snprintf(buffer, MAX_BUFFER_SIZE, "Price: %d\nEnter payment amount: ", products[selected_product].price);
    write(client_fd, buffer, strlen(buffer));
    // int payment;
    // payment = atoi(buffer) + in_coin[client_fd];
    // check_payment(atoi(buffer), client_fd, products, num_products, selected_product);
}

void sorry(int client_fd)
{
    char *massage = "Sorry, this server is full.\n";
    write(client_fd, massage, strlen(massage));
}

int main(void)
{
    int s, soval;
    struct sockaddr_in sa;

    Product products[] = {
        {"apple", 70, 10},
        {"coffee", 100, 1},
        {"milk", 40, 8},
        {"orange", 80, 12},
        {"tea", 50, 15},
    };

    int num_products = sizeof(products) / sizeof(Product);

    // ソケットの生成
    if ((s = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        perror("socket");
        exit(1);
    }
    soval = 1; // ソケットオプションの値を1に設定
    // ソケットオプションの設定
    if (setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &soval, sizeof(soval)) < 0)
    {
        perror("setsockopt");
        exit(1);
    }
    // ソケットアドレスの設定
    memset(&sa, 0, sizeof(sa));
    sa.sin_len = sizeof(sa);
    sa.sin_family = AF_INET;
    sa.sin_port = htons(SEVER_PORT);
    sa.sin_addr.s_addr = htonl(INADDR_ANY);
    // ソケットにアドレスを指定
    if (bind(s, (struct sockaddr *)&sa, sizeof(sa)) < 0)
    {
        perror("bind");
        exit(1);
    }
    // 接続待ちの設定
    if (listen(s, NQUEUESIZE) < 0)
    {
        perror("listen");
        exit(1);
    }
    // クライアントの接続を受け付ける
    fprintf(stderr, "[Waiting for connection...]\n");
    for (;;)
    {
        int i, maxfd;
        FD_ZERO(&readfds);
        FD_SET(s, &readfds);
        maxfd = s;
        for (i = 0; i < num_clients; i++)
        {
            FD_SET(clients[i], &readfds);
            if (clients[i] > maxfd)
            {
                maxfd = clients[i];
            }
        }

        if (select(maxfd + 1, &readfds, NULL, NULL, NULL) < 0)
        {
            perror("select");
            exit(1);
        }

        // 新しい接続か
        if (FD_ISSET(s, &readfds))
        {
            struct sockaddr_in ca;
            socklen_t ca_len = sizeof(ca);
            int c = accept(s, (struct sockaddr *)&ca, &ca_len);
            if (c < 0)
            {
                perror("accept");
                exit(1);
            }
            if (num_clients >= MAX_CLIENTS)
            {
                sorry(c);
                shutdown(c, SHUT_WR);
                close(c);
                fprintf(stderr, "[Client refused. (Client FD: %d)]\n", c);
            }
            else
            {
                // クライアント側にラインナップを送る
                write(c, "Available Products:\n", 20);
                char buffer[MAX_BUFFER_SIZE];
                for (int i = 0; i < num_products; ++i)
                {
                    snprintf(buffer, MAX_BUFFER_SIZE, "%s(%d(%d)) ", products[i].name, products[i].price, products[i].stock);
                    write(c, buffer, strlen(buffer));
                }
                write(c, "\n", 1);
                write(c, "select product", 15);
                in_coin[num_clients] = 0;
                product[num_clients] = -1;
                clients[num_clients] = c;
                num_clients++;
                fprintf(stderr, "[Client connected. (Client FD: %d)]\n", c);
            }
        }

        for (i = 0; i < num_clients; i++)
        {

            if (FD_ISSET(clients[i], &readfds))
            {
                printf("clients[%d]: %d\n", i, clients[i]);
                if (product[i] == -1) // お金を入れていない場合
                {
                    printf("now return_payment\n");
                    return_payment(clients[i], products, num_products, i);
                }
                else
                {
                    check_payment(in_coin[i], clients[i], products, num_products, product[i], i);
                }
                break;
            }
        }
    }
}