# 13.09.2020
Dodany gitignore, poprawiona struktura folderów i plików w repozytorium, dodane pierwsze pliki projektu w Quartus.

# 04.04.2020
Założenie repozytorium

# 02.09.2020
Zakończenie przerabiania książki "Systemy embedded w FPGA" autorstwa dr. Piotra Rzeszuta, będącej zbiorem podstawowej wiedzy potrzebnej do rozpoczęcia pracy w środowisku Quartus na płytce MAXimator.

# 28.10.2020
Zrobiony sterownik HDMI ze sprzętowym, testowym generatorem obrazu.

![HDMIDriver&ImageGenerator](https://j.gifs.com/WL4rZn.gif)

# 06.11.2020
Dołączony VRAM, działający connector RAM-u i sterownika HDMI, poprawione adresowanie pikseli w sterowniku.

![ReadFromRAM](Assets/ReadFromRAM.jpg)

# 10.11.2020
Podmiana statycznego obrazu z inicjalizacji pamięci VRAM, obrazem statycznym ustawionym z "kodu".

![StaticImageFromSoft](https://j.gifs.com/vlV1qX.gif)

# 11.11.2020
Zaiplementowany licznik do likwidacji drgania styków i porty wejścia/ wyjścia na przyciski. W oprogramowaniu
dodana obsługa przerwań i wyświetlanie reagującego na nie kwadratu.

![Interrupts&MoveOnScreen](https://j.gifs.com/D145vK.gif)

# 18.11.2020
Gotowy silnik gry (zoptymalizowany po przesadzeniu z zajmowaną przez oprogramowanie pamięcią o jakieś 14kB). 
W pełni funkcjonalny z obsługą przerwań i interfejsem typu process input, update, render. Na wideo latająca 
piłka, na razie bez ograniczeń, sterowana przez przyciski. Przycisk "L" kieruje piłkę w lewy górny róg, "R" 
w prawy dolny, a "RES" zatrzymuje.

![GameEngine](https://j.gifs.com/k8q7DJ.gif)


# 20.11.2020
Implementacja renderowania obiektów przeniesiona do obiektu "Rectangle" należącego do silnika. Tym samym 
programista samej gry nie musi się zastanawiać jak wyrenderować swój obiekt. "Tosz to nie jego zmartwienie":wink:

Po drodze było dosyć ciekawie:
![Waste](Assets/Waste.jpg)

![RectangleRendering](https://j.gifs.com/p8y77X.gif)
