.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.SEGMENT "ZEROPAGE"
.IMPORTZP logoUFOFlags, nextPalette, nextPaletteDest

.SEGMENT "RODATA"
.IMPORT LOGO_SPRITE_COLORS

.SEGMENT "CODE"
.PROC DrawUFO
    LDA logoState
    CMP #LOGOSTATE_LOAD_UFO
    BNE :+

    LDA #<LOGO_SPRITE_COLORS
    STA nextPalette
    LDA #>LOGO_SPRITE_COLORS
    STA nextPalette+1
    LDA #SPR_PALETTE_0
    STA nextPaletteDest

    ; Set up our UFO Y POS
    LDA #UFO_START_Y
    STA SPRITE_0_Y

    ;This is the ufo tile
    LDA #$09
    STA SPRITE_0_TILE

    ; Set attributes for left side of UFO
    SetUFOLayerLeft:
        LDA logoUFOFlags
        AND #$40
        LSR ; Shift bit 6 to bit 5
        TAX ; Store our result in X
        STA SPRITE_0_ATTRIB ; Save it temporarily

    SetUFOPaletteLeft:
        LDA logoUFOFlags
        AND #$0C ; Mask out the palette bits
        LSR
        LSR      ;Shift to mimic attribute flag
        ORA SPRITE_0_ATTRIB ; Combine with current flag

    ; Finished with left side ufo attrib
    STA SPRITE_0_ATTRIB

    LDA #UFO_START_X
    STA SPRITE_0_X
    STA SPRITE_1_X
    ; END OF LEFT SIDE UFO

    ; START RIGHT SIDE UFO
    ; Set up our UFO Y POS
    LDA #UFO_START_Y
    STA SPRITE_1_Y

    ;This is the ufo tile
    LDA #$09
    STA SPRITE_1_TILE

    ; Set attributes for right side of UFO
    SetUFOLayerRight:
        LDA logoUFOFlags
        AND #$40
        LSR ; Shift bit 6 to bit 5
        TAX ; Store our result in X
        STA SPRITE_1_ATTRIB ; Save it temporarily

    SetUFOPaletteRight:
        LDA logoUFOFlags
        AND #$0C ; Mask out the palette bits
        LSR
        LSR      ;Shift to mimic attribute flag
        ORA SPRITE_1_ATTRIB ; Combine with current flag

    ; Flip this sprite, cause it's the right
    ; side of the UFO
    ORA #$40
    ; Finished with right side ufo attrib
    STA SPRITE_1_ATTRIB

    ; Finished making the UFO!
    LDA #LOGOSTATE_MOVE_UFO
    STA logoState
    :
    RTS
.ENDPROC
.EXPORT DrawUFO
