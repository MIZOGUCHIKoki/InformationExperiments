#include <stdio.h>

extern int isprime(int n);

/* 素数判定対象の配列の一部 */

int data[] = {0, 1, 2, 3, 4, 5, 6,7, 8, 9, 10, 1000001, 1000003, 100007};

#define N (sizeof(data) / sizeof(data[0]))

int main() {
  unsigned int i;

  /* 配列dataの要素のうち素数のみ出力*/
  for (i = 0; i < N; i++){
    if (isprime(data[i])) {
      printf("%d\n", data[i]);
    }
  }
  return 0;
}
