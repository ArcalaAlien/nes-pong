.SEGMENT "RODATA"

PALETTES:
    LOGO_PALETTE_COLORS:
        .BYTE $0F, $18, $28, $29, $FF ; Terminator

    MAIN_PALETTE_COLORS:
        .BYTE $0F, $00, $10, $20
        .BYTE $0F, $1C, $2C, $3C
        .BYTE $0F, $08, $18, $29
        .BYTE $0F, $0B, $1A, $29, $FF ; Terminator
.EXPORT PALETTES
.EXPORT LOGO_PALETTE_COLORS
.EXPORT MAIN_PALETTE_COLORS

SCREENS:
    .INCLUDE "graphics/screens/logoScreen.inc"
    .INCLUDE "graphics/screens/titleScreen.inc"
    ;.INCLUDE "graphics/screens/menus/chooseGamemodeScreen.inc"
    ;.INCLUDE "graphics/screens/menus/chooseDifficultyScreen.inc"
    ;.INCLUDE "graphics/screens/bars/classicStatusBar.inc"
    ;.INCLUDE "graphics/screens/bars/chooseEffectBar.inc"
    ;.INCLUDE "graphics/screens/backgrounds/backgroundScreenOne.inc"
.EXPORT SCREENS
.EXPORT logoScreen, titleScreen ;, chooseGamemodeScreen, chooseDifficultyScreen
;.EXPORT classicStatusBar, chooseEffectBar, backgroundScreenOne

