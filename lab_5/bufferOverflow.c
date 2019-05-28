#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
int topSecret()
{
    printf("\nJak zdać OiAK!\n");
    printf("Super tajny przepis [KLIKNIJ]!\n");

    printf("No już nie tak super!\n\n");
    return 0;
}

int func()
{
    // Źle zabezpieczone indeksowanie tablicy
    char str[4];    
    int *secretAddr = &topSecret;
    memcpy((void*)str+20, &secretAddr, 4);

    // Dalsze, bezowocne próby z plikiem
    FILE *f = fopen("helloFromHello.out", "rb");
    if (f == NULL)
    {
        printf("Nie ma takiego pliku\n %d", errno);
    }
    else
    {
        fread(str, 1, 12, f);
        printf("%s\n", str);
    }
    printf("Wszystko super w funkcji\n");
    return 0;
}
int main(int argc, char **argv)
{
    func();
    printf("Wszystko super w mainie też\n");
    return 0;
}
// python -c 'print "a"*32 + "\x56\x55\x55\x98"' | ./bin/bufferOverflow.out
// python3 -c 'print("a" * 24 +"\x56\x55\x56\x0d",end="")' > helloFromHello.out
// 0x56555638