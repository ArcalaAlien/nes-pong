.SEGMENT "RODATA"

PALETTES:
    LOGO_BG_FADE_0:
        .BYTE $0F, $0F, $0F, $0F, $FF
    LOGO_BG_FADE_1:
        .BYTE $0F, $07, $08, $17, $FF
    LOGO_BG_FADE_2:
        .BYTE $0F, $17, $18, $19, $FF
    LOGO_BG_FADE_FINAL:
        .BYTE $0F, $18, $28, $29, $FF ; Terminator
    LOGO_SPRITE_COLORS:
        .BYTE $0F, $19, $2B, $3C
        .BYTE $0F, $1C, $2C, $3C
        .BYTE $0F, $0B, $1B, $2B
        .BYTE $0F, $0C, $12, $22, $FF ; Terminator

    TITLE_BG_FADE_0:
        .BYTE $0F, $0F, $0F, $0F ; Pal 0
        .BYTE $0F, $0F, $0F, $0F ; Pal 1
        .BYTE $0F, $0F, $0F, $0F ; Pal 2
        .BYTE $0F, $0F, $0F, $0F, $FF ; Pal 3
    TITLE_BG_FADE_1:
        .BYTE $0F, $00, $00, $00 ; Pal 0
        .BYTE $0F, $0C, $0C, $0C ; Pal 1
        .BYTE $0F, $04, $04, $04 ; Pal 2
        .BYTE $0F, $0B, $0B, $0B, $FF ; Pal 3
    TITLE_BG_FADE_2:
        .BYTE $0F, $00, $10, $10 ; Pal 0
        .BYTE $0F, $0C, $2C, $2C ; Pal 1
        .BYTE $0F, $04, $15, $15 ; Pal 2
        .BYTE $0F, $0B, $1A, $1A, $FF ; Pal 3
    TITLE_BG_FADE_FINAL:
        .BYTE $0F, $00, $10, $20 ; Pal 0
        .BYTE $0F, $0C, $2C, $3C ; Pal 1
        .BYTE $0F, $04, $15, $24 ; Pal 2
        .BYTE $0F, $0B, $1A, $29, $FF ; Pal 3
.EXPORT PALETTES
.EXPORT LOGO_BG_FADE_0, LOGO_BG_FADE_1, LOGO_BG_FADE_2, LOGO_BG_FADE_FINAL, LOGO_SPRITE_COLORS
.EXPORT TITLE_BG_FADE_0, TITLE_BG_FADE_1, TITLE_BG_FADE_2, TITLE_BG_FADE_FINAL

SCREENS:
    .INCLUDE "graphics/screens/logoScreen.inc"
    .INCLUDE "graphics/screens/titleScreen.inc"
    ;.INCLUDE "graphics/screens/menus/chooseGamemodeScreen.inc"
    ;.INCLUDE "graphics/screens/menus/chooseDifficultyScreen.inc"
    ;.INCLUDE "graphics/screens/bars/classicStatusBar.inc"
    ;.INCLUDE "graphics/screens/bars/chooseEffectBar.inc"
    ;.INCLUDE "graphics/screens/backgrounds/backgroundScreenOne.inc"
.EXPORT SCREENS
.EXPORT logoScreen, titleScreen;, chooseGamemodeScreen, chooseDifficultyScreen
;.EXPORT classicStatusBar, chooseEffectBar, backgroundScreenOne

; $FF is a terminator
UFO_MOVEMENT_PATH_X:
    .BYTE $00, $FF
UFO_MOVEMENT_PATH_Y:
    .BYTE $28, $FF
.EXPORT UFO_MOVEMENT_PATH_X, UFO_MOVEMENT_PATH_Y
