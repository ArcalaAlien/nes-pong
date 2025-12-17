.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"
.IMPORTZP jumpPointer, nextTable, currentScreen, nextScreen

; Writes a full 1KB nametable to PPU
; Store hibyte of screen in nextScreen
; Store hibyte of nametable in nextTable
DrawScreen:
    LDA #$00
    STA matches

    CheckScreenHi:
        LDA nextScreen+1
        CMP currentScreen+1
        BNE CheckScreenLo
        INC matches

    CheckScreenLo:
        STA currentScreen+1
        LDA nextScreen
        CMP currentScreen
        BNE CheckMatches
        INC matches

    CheckMatches:
        STA currentScreen
        LDA matches
        CMP #$02
        BEQ :+  ; Leave the function,
                ; as we've already drawn this
                ; screen

    ; Otherwise,
    ; Set up the PPU and nametable
    ; for writing
    SetUpPPU:
        BIT PPUSTATUS
        LDA nextTable
        STA PPUADDR
        LDA #$00
        STA PPUADDR

    ; Now we make our loop
    LDX #$00
    LDY #$00
    DrawScreenLoop:
        LDA (nextScreen),Y
        STA PPUDATA
        INY

        CPY #$00
        BNE DrawScreenLoop

        INX
        INC nextScreen+1
        CPX #$04
        BNE DrawScreenLoop
    :
        RTS
.EXPORT DrawScreen
