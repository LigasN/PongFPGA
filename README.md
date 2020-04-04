# PongFPGA
Opracowanie i uruchomienie gry typu "Pong" w układzie FPGA (Development and commissioning of a "Pong" game in FPGA). My engineer's thesis.

## Opis
Opracowanie sprzętowo-programowego systemu realizującego grę typu "Pong". Konstrukcja generatora sygnału VGA/HDMI wraz z pamięcią VRAM. Wyświetlanie wyników na obrazie lub wyświetlaczu 7SEG. Utworzenie systemu wbudowanego z soft-procesorem NIOS. Oprogramowanie algorytmu gry. Uruchomienie podsystemu na platformie FPGA MAXimator.1

## Założenia
* generator sygnału video w trybie 480p (480 x 640, 60Hz),
* pamięć VRAM o odpowiednio zmniejszonej rozdzielczości lub wyświetlanie nielicznych obiektów ad hoc,
* głębia kolorów: 1b (monochromatyczny),
* wyświetlanie wyników na obrazie lub wyświetlaczu 7SEG,
* zmiana parametrów (szybkość, rozmiar rakiety, kąt odbicia itp.)
* gra podstawowa + ew. dodatki (gra z automatem, gra w debla, squash itp.).
* ...
