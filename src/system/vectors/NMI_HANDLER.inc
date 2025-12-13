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

    LDA #$01

    JSR LoadPalettes
    JSR DrawScreen

    DEC sleeping

    BIT PPUSTATUS
    LDA #$00
    STA PPUSCROLL
    STA PPUSCROLL

    LDA PPUCTRL_MIRROR
    STA PPUCTRL
    LDA PPUMASK_MIRROR
    STA PPUMASK

    PLA
    TAY
    PLA
    TAX
    PLA
    RTI

    .INCLUDE "../PPUFrameCounter.asm"
.ENDPROC
.EXPORT NMI_HANDLER
