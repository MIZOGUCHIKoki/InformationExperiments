#include <stdio.h>

extern int isprime(int n);

/* $BAG?tH=DjBP>]$NG[Ns$N0lIt(B */

int data[] = {0, 1, 2, 3, 4, 5, 6,7, 8, 9, 10, 1000001, 1000003, 100007};

#define N (sizeof(data) / sizeof(data[0]))

int main() {
  unsigned int i;

  /* $BG[Ns(Bdata$B$NMWAG$N$&$AAG?t$N$_=PNO(B*/
  for (i = 0; i < N; i++){
    if (isprime(data[i])) {
      printf("%d\n", data[i]);
    }
  }
  return 0;
}
