ca65 %cd%\src\main.asm -g^
     -o %cd%\build\objects\main.o

ca65 %cd%\src\graphics\DrawScreen.asm -g^
     -o %cd%\build\objects\DrawScreen.o

ca65 %cd%\src\graphics\LoadPalettes.asm -g^
     -o %cd%\build\objects\LoadPalettes.o

ca65 %cd%\src\graphics\FadeIn4Steps.asm -g^
     -o %cd%\build\objects\FadeIn4Steps.o

ca65 %cd%\src\graphics\FadeOut4Steps.asm -g^
     -o %cd%\build\objects\FadeOut4Steps.o

ld65 -C %cd%\NES.cfg -o %cd%\build\NESPong.nes --dbgfile %cd%\build\NESPong.nes.dbg^
     %cd%\build\objects\main.o^
     %cd%\build\objects\DrawScreen.o^
     %cd%\build\objects\LoadPalettes.o^
     %cd%\build\objects\FadeIn4Steps.o^
     %cd%\build\objects\FadeOut4Steps.o
