#include <stdio.h>
extern void stacktrace();

int  test(int stop){
    if(stop > 0)
        return test(--stop);
    stacktrace();
    return stop;
}

int main(int argc, char *argv[])
{
  test(5);
  return 0;
}