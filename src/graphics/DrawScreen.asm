.INCLUDE "../system/CONSTANTS.inc"
.IMPORTZP jumpPointer, nextTable, currentScreen, nextScreen

; Writes a full 1KB nametable to PPU
; Store hibyte of screen in nextScreen
; Store hibyte of nametable in nextTable
DrawScreen:
    LDA nextScreen
    CMP currentScreen
    BEQ :+
    STA currentScreen

    ; Set up the PPU and nametable
    ; for writing
    BIT PPUSTATUS
    LDA nextTable
    STA PPUADDR
    LDA #$00
    STA PPUADDR

    ; Now we make our loop
    CLC ; Clear carry because we use it to compare.
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

    LDA currentScreen+1
    STA nextScreen+1
    :
        RTS
.EXPORT DrawScreen
