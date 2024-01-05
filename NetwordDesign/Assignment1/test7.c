#include <stdio.h>
#include <unistd.h>

int main(void)
{
    // Buffering test
    // output every 1 row.
    for (int i = 0; i < 20; i++)
    {
        putchar('X'); // output 'x' to standard output.
        if (i % 5 == 0)
            putchar('\n'); // bleak line ebvery 5 times.
        fflush(stdout);    // flush buffer.
        sleep(1);          // wait 1 second.
    }
}