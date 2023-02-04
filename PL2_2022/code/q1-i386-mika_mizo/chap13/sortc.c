#include <stdio.h>

extern void sort(void *array, int n, int width);

/* 整列対象配列の一例 */
struct Table {
  int score;
  char *name;
};

struct Table table[] = {
  {9, "A"},
  {8, "B"},
  {7, "C"},
  {7, "D"},
  {1, "E"},
  {0, "F"}
};

/* 配列tableの要素数 */
#define N (sizeof(table) / sizeof(table[0]))

int main(){
  unsigned int i;
  /* 整列 */
  sort(table, N, sizeof(table[0]));

  /* 整列結果を出力 */
  for (i = 0; i < N; i++) {
    printf("%d, %s\n", table[i].score, table[i].name);
  }
  return 0;
}
