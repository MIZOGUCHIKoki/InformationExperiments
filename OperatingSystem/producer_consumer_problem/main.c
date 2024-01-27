#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#define BUFFER_SIZE 10

int B[BUFFER_SIZE];
int InPtr = 0, OutPtr = 0;

sem_t Elements, Spaces;

void *Producer(void *arg);
void *Consumer(void *arg);

int Produce();
void Consume(int i);

int main()
{
    // Initialize semaphores
    sem_init(&Elements, 0, 0);         // Elementsの初期セマフォア値を0に設定
    sem_init(&Spaces, 0, BUFFER_SIZE); // Spacesの初期セマフォア値をBUFFER_SIZEに設定

    // Create threads
    pthread_t producerT, consumerT;
    pthread_create(&producerT, NULL, Producer, NULL);
    pthread_create(&consumerT, NULL, Consumer, NULL);

    // Join threads
    pthread_join(producerT, NULL);
    pthread_join(consumerT, NULL);

    // Destroy semaphores
    sem_destroy(&Elements);
    sem_destroy(&Spaces);

    return 0;
}

void *Producer(void *arg)
{
    int data;
    for (;;)
    {
        data = Produce(); // データを生成
        printf("Produce %d\n", data);
        sem_wait(&Spaces);                 // Spacesのセマフォア値をデクリメント
        B[InPtr] = data;                   // バッファにデータを格納
        InPtr = (InPtr + 1) % BUFFER_SIZE; // バッファのインデックスを更新
        printf("Store %d\n", data);
        sem_post(&Elements); // Elementsのセマフォア値をインクリメント
    }
}

void *Consumer(void *arg)
{
    int data;
    for (;;)
    {
        sem_wait(&Elements); // Elementsのセマフォア値をデクリメント
        data = B[OutPtr];    // バッファからデータを取得
        OutPtr = (OutPtr + 1) % BUFFER_SIZE;
        sem_post(&Spaces); // Spacesのセマフォア値をインクリメント
        Consume(data);     // データを消費
    }
}

int Produce()
{
    static int i = 0;
    return i++;
}

void Consume(int i)
{
    printf("Consume %d\n", i);
}