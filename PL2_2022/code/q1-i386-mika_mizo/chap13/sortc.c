#include <stdio.h>

extern void sort(void *array, int n, int width);

/* $B@0NsBP>]G[Ns$N0lNc(B */
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

/* $BG[Ns(Btable$B$NMWAG?t(B */
#define N (sizeof(table) / sizeof(table[0]))

int main(){
  unsigned int i;
  /* $B@0Ns(B */
  sort(table, N, sizeof(table[0]));

  /* $B@0Ns7k2L$r=PNO(B */
  for (i = 0; i < N; i++) {
    printf("%d, %s\n", table[i].score, table[i].name);
  }
  return 0;
}
