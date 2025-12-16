.IMPORT DrawScreen, LoadPalettes
.PROC NMI_HANDLER
    PHA
    TXA
    PHA
    TYA
    PHA

    JSR PPUFrameCounter

    LDA #$00
    STA PPUCTRL
    STA PPUMASK

    JSR LoadPalettes
    JSR DrawScreen
    JSR SendSprites

    BIT PPUSTATUS
    LDA #$00
    STA PPUSCROLL
    STA PPUSCROLL

    LDA PPUCTRL_MIRROR
    STA PPUCTRL
    LDA PPUMASK_MIRROR
    STA PPUMASK

    DEC sleeping

    PLA
    TAY
    PLA
    TAX
    PLA
    RTI

    SendSprites:
        LDA #$00
        STA OAMADDR
        LDA #$02
        STA OAMDMA
        RTS

    .INCLUDE "../PPUFrameCounter.asm"
.ENDPROC
.EXPORT NMI_HANDLER
