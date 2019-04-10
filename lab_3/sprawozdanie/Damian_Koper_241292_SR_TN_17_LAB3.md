<div style="display:flex;justify-content:space-between"><span>Damian Koper, 241292<br>SR-TN-17</span> Wrocław, 27.03.2019r. </div>

# Lab 2: 

## Cel ćwiczenia

## Śledzenie stosu po początkowycm wywołaniu
Ilość argumentów znajduje się na szczycie stosu:
```
(gdb) x /d $esp
```
Wskaźnik na argumenty programu:
```
(gdb) x /s *(char **)($esp+4)
```
Wskażnik na zmienne środowiskowe:
```
(gdb) x /s *(char **)($esp+16)
```


## Programy

## Wnioski

### Literatura
1. Wikibooks x86 Assembly - https://en.wikibooks.org/wiki/X86_Assembly
2. Laboratorium AK –ATT asembler (LINUX) - http://zak.ict.pwr.wroc.pl/materials/architektura/laboratorium%20AK2/Linux-AK2-lab-2018%20May.pdf
3. University of Virginia Computer Science - x86 Assembly Guide
http://www.cs.virginia.edu/~evans/cs216/guides/x86.html
4. Prezentacja do wykładu
5. Dokumentacja GDB - https://sourceware.org/gdb/current/onlinedocs/gdb/
6. `gdb help`
7. `man command`