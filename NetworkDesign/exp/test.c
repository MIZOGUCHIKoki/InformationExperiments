#include <stdio.h>

struct Point {
	int x;
	int y;
};

int main(){
	struct Point p1 = {3, 5};
	struct Point *ptr = &p1;
	printf("%d, %d\n",p1.y,sizeof(p1));
	printf("%d\n", (*ptr).y);
	printf("%d\n", ptr->y);
	
	return 0;
}
