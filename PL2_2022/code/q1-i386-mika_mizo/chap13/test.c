#include <stdio.h>              /* printf$B$N$?$a$KI,MW(B */

extern int add2(int a, int b);  /* extern$B@k8@(B */

int main()
{
  printf("%d\n", add2(32, 27));
  return 0;
}
