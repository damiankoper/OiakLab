#include <stdio.h>
#include <math.h>
extern float my_sin(float a);

int main(int argc, char *argv[])
{
  printf("%E", my_sin((float)(M_PI / 2)));
  return 0;
}