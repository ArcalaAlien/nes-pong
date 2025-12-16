.SEGMENT "ZEROPAGE"
.IMPORTZP addrPointer, jumpPointer, nextPalette, nextPaletteDest, currentFrame

.SEGMENT "CODE"
.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.PROC FadeIn4Steps
    ; Check if we've finished fading
    LDA fadeState
    CMP #FADE_STEP_FINAL+1
    BEQ :+

    ;Check if we've hit frame 0, 15, 30, or 45.
    ;quarter second between each step
    LDA currentFrame
    CMP #$00
    BEQ LoadPaletteDestination
    CMP #$0F
    BEQ LoadPaletteDestination
    CMP #$1D
    BEQ LoadPaletteDestination
    CMP #$2D
    BEQ LoadPaletteDestination

    ;We're not on a fade-frame
    JMP :+

    ;Check if the next palette
    ;destination is the same as BG
    ;PAL 1, if it's already set
    ;we can just send the colors

    LoadPaletteDestination:
        LDA nextPaletteDest
        CMP #BG_PALETTE_1
        BEQ SendPalettes

        ;Otherwise, lets set the
        ;destination to BG Palette 1
        LDA #BG_PALETTE_1
        STA nextPaletteDest

    ; Grab the hi and lo bytes of the
    ; palettes needed
    SendPalettes:
        LDY fadeState
        LDA (jumpPointer), y
        STA nextPalette
        LDA (addrPointer), Y
        STA nextPalette+1
        INC fadeState
        JMP :+
    :
    RTS
.ENDPROC
.EXPORT FadeIn4Steps
