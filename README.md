![ReadMe](Documents/Assets/ReadMe.jpg)
# PongFPGA
Opracowanie i uruchomienie gry typu "Pong" w układzie FPGA (Development and commissioning of a "Pong" game in FPGA). My engineer's thesis.

## Opis
Opracowanie sprzętowo-programowego systemu realizującego grę typu "Pong". Konstrukcja generatora sygnału VGA/HDMI wraz z pamięcią VRAM. Wyświetlanie wyników na obrazie lub wyświetlaczu 7SEG. Utworzenie systemu wbudowanego z soft-procesorem NIOS. Oprogramowanie algorytmu gry. Uruchomienie podsystemu na platformie FPGA MAXimator.

## Założenia
* generator sygnału video w trybie 480p (480 x 640, 60Hz),
* pamięć VRAM o odpowiednio zmniejszonej rozdzielczości lub wyświetlanie nielicznych obiektów ad hoc,
* głębia kolorów: 1b (monochromatyczny),
* wyświetlanie wyników na obrazie lub wyświetlaczu 7SEG,
* zmiana parametrów (szybkość, rozmiar rakiety, kąt odbicia itp.)
* gra podstawowa + ew. dodatki (gra z automatem, gra w debla, squash itp.).
* ...

[![Original Atari PONG(1972)](https://img.youtube.com/vi/fiShX2pTz9A/0.jpg)](https://www.youtube.com/watch?v=fiShX2pTz9A)

## Dokumentacja
* specyfikacja projektu, plik formatu markdown- [Specifications](Documents/Specifications.md "Specifications")
* szybka instrukcja rozgrywki, plik formatu markdown- [HowToPlay](Documents/HowToPlay.md "HowToPlay")
* wykonanej pracy, lista dat z komentarzami- [LogWork](Documents/LogWork.md "LogWork")

## Rezultat
![Rezultat](https://user-images.githubusercontent.com/48071430/211208714-7b4eed6b-6be7-47b7-bf15-d804d68d0305.gif "PongFPGA.gif")

## Linki
* [hardware sources](Source/Hardware/ "hardware sources")
* [software sources](Source/Software/PongFPGA/source "software sources")
* [testbenches](Source/Hardware/simulation/Testbenches/ "testbenches")
* [top level entity](Source/Hardware/PongFPGA/synthesis/PongFPGA.vhd "top level entity")
* [RAM initialisation file](Source/Hardware/simulation/simulationFiles/StaticImage.mif "RAM initialisation file")
* [ready board configuration](Source/Hardware/output_files/ "ready board configuration")
* [elf file](Source/Software/PongFPGA/PongFPGA.elf "elf file")
