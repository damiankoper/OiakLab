<div style="display:flex;justify-content:space-between"><span>Damian Koper, 241292<br>SR-TN-17</span> Wrocław, 10.04.2019r. </div>

# Lab 2: 

## Cel ćwiczenia
* Zapoznanie się z zawartością stosu w momencie uruchomienia programu.
* Wypisanie na ekran argumentów programu i zmiennych środowiskowych
* Zapoznanie się z podstawowymi instrukcjami arytmetycznymi
* Arytmetyka wielkich liczb - podstawowe działania
* Konwersja liczb z różnych reprezentacji do docelowej reprezentacji binarnej


## Śledzenie stosu po początkowym wywołaniu
Ilość argumentów `argc` znajduje się na szczycie stosu:
```
(gdb) x /d $esp
```
Wskaźniki na kolejne argumenty programu znajdują się w dalszej kolejności na stosie w ilości `argc`:
```
(gdb) x /s *(char **)($esp+4) # <- pierwszy argument to ścieżka wywołania
(gdb) x /s *(char **)($esp+8)
...
```
Następnie na stosie znajduje się wartość *0*, po której znajdują się wskaźniki na kolejne stringi ze zmiennymi środowiskowymi.
Nie podanej z góry ilości tych zmiennych, dlatego na końcu tego ciągu występuje również wartość *0*
```
(gdb) x /s *(char **)($esp+12) # <- +12 to najmniejszy możliwy offset dla zmiennych środowiskowych przy wywołaniu bez argumentów. [argc, arg1, 0, 1stENV, ...]
```

## Arytmetyka wielkich liczb
Operacje na liczbach większych niż największa możliwa długość słowa maszynowego wymagają zastosowania specjalnych algorytmów, które działają tylko na część liczby. Sprowadza się to do tego, że liczby te traktowane są jako liczby o rozmiarze będącym wielokrotnością największego słowa.

### Abstrakcja
Wszystkie przypadki można rozpatrywać jako operacje na liczbach (tak jak na kartce) interpretowanych jako liczba w systemie o podstawie $2^{n}$ gdzie *n* jest dozwoloną długością słowa.

### Dodawanie i odejmowanie
Dodawanie i odejmowanie są najprostrzymi operacjami do zaimplementowania dla wielkich liczb. Są również podstawą, na której opierają się bardziej skomplikowane operacje np. mnożenie i dzielenie. Dodając (odejmując) dwie liczby trzeba wykonać na kolejnych ich częściach podstawowe operacje dodawania (odejmowania), które uwzględniają przeniesienie (pożyczkę) wejściowe. Jeśli podczas tej operacji wystąpi *overflow*, zostanie ustawiona flaga *CF* - carry flag, która określa wartość przeniesienia (pożyczki) dla następnej operacji. Instrukcje, które wykorzystują flagę *CF* w tym przypadku to `adc` i `sbb`.

### Mnożenie
Mnożąc 2 liczby wykonujemy mnożenie każdego członu z każdym, następnie dodając do wyniku z odpowiednim przesunięciem. Przy mnożeniu 2 liczb o rozmiarze 4 słów wykonamy 16 mnożeń i w optymalnej wersji 7 dodawań. Dla implementacji wykorzystąjącej dwie zagnieżdżone pętle wykonamy 16 mnożeń i tyle samo dodawań.

### Dzielenie


## Programy

## Wnioski

### Literatura
1. Wikibooks x86 Assembly - https://en.wikibooks.org/wiki/X86_Assembly
2. Laboratorium AK –ATT asembler (LINUX) - http://zak.ict.pwr.wroc.pl/materials/architektura/laboratorium%20AK2/Linux-AK2-lab-2018%20May.pdf
3. University of Virginia Computer Science - x86 Assembly Guide
http://www.cs.virginia.edu/~evans/cs216/guides/x86.html
4. Prezentacja do wykładu
5. Intel Manual - https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf
6. Dokumentacja GDB - https://sourceware.org/gdb/current/onlinedocs/gdb/
7. Dokumentacja GDB/MI - https://sourceware.org/gdb/current/onlinedocs/gdb/GDB_002fMI.html
8. `gdb help`
9. `ld --help`
10. `man command`