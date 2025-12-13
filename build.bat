ca65 %cd%\src\main.asm^
     -o %cd%\build\objects\main.o

ca65 %cd%\src\graphics\DrawScreen.asm^
     -o %cd%\build\objects\DrawScreen.o

ca65 %cd%\src\graphics\LoadPalettes.asm^
     -o %cd%\build\objects\LoadPalettes.o

ld65 -C %cd%\NES.cfg -o %cd%\build\NESPong.nes^
     %cd%\build\objects\main.o^
     %cd%\build\objects\DrawScreen.o^
     %cd%\build\objects\LoadPalettes.o^
