#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
int main(int argc, char **argv);

int topSecret()
{
    printf("\nJak zdać OiAK!\n");
    printf("Super tajny przepis [KLIKNIJ]!\n");

    printf("No już nie tak super!\n\n");
    return 0;
}

int func()
{
    // Źle zabezpieczone indeksowanie tablicy -> symulacja
    char str[4];    
    
    //printf("%p\n", (void*)&topSecret);
    //printf("%p\n", (str));
    /*int *secretAddr = &topSecret;
    memcpy((void*)str+20, &secretAddr, 4);*/
    /// ######

    // Nadpisanie adresu powrotu przez fread
    FILE *f = fopen("helloFromHello.out", "rb");
    if (f == NULL)
    {
        printf("Nie ma takiego pliku\n %d", errno);
    }
    else
    {
        //register int sp asm ("bp");
        //printf("%p\n", sp);
        fread(str, 1, 24, f);
    }
    /// ######
    //register int sp1  asm ("sp");
    //printf("%p\n", sp1);
    //printf("%p\n", *(int*)(0xffffce3c));
    //printf("%p\n", (void*)&main);

    printf("Wszystko super w funkcji\n");
    return 0;
}
int main(int argc, char **argv)
{
    func();
    printf("Wszystko super w mejnie też\n");
    return 0;
}
// python -c 'print "a"*32 + "\x56\x55\x55\x98"' | ./bin/bufferOverflow.out
// python3 -c 'print("a" * 24 +"\x56\x55\x56\x0d",end="")' > helloFromHello.out
// 0x56555638