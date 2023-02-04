#include <stdio.h>              /* printfのために必要 */

extern int add2(int a, int b);  /* extern宣言 */

int main()
{
  printf("%d\n", add2(32, 27));
  return 0;
}
