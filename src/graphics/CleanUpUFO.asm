.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.SEGMENT "ZEROPAGE"
.IMPORTZP logoUFOFlags, logoUFOPos, ufoPathIndex

.SEGMENT "CODE"
.PROC CleanUpUFO
    LDA #$00
    STA logoUFOPos
    STA logoUFOPos+1
    STA logoUFOFlags
    STA ufoPathIndex
    STA ufoPathIndex+1

    LDA #$FE
    ; Left Side
    STA SPRITE_0_Y
    STA SPRITE_0_TILE
    STA SPRITE_0_ATTRIB
    STA SPRITE_0_X

    ; Right Side
    STA SPRITE_1_Y
    STA SPRITE_1_TILE
    STA SPRITE_1_ATTRIB
    STA SPRITE_1_X
    RTS
.ENDPROC
.EXPORT CleanUpUFO
