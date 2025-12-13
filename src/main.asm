.INCLUDE "system/segments/HEADER.inc"
.INCLUDE "system/segments/ZEROPAGE.inc"
.INCLUDE "system/segments/RODATA.inc"

.SEGMENT "CODE"
.INCLUDE "system/CONSTANTS.inc"

.PROC MAIN
    loop:
        LDA programState
        JSR MainJumpEngine

    INC sleeping
    sleep:
        LDA sleeping
        BPL sleep
        JMP loop

    MAIN_PROGRAM_STATE_TABLE:
        .WORD HandleLogo
        .WORD HandleTitle
        .WORD HandleGamemodeSelection
        .WORD HandleDifficultySelection
        .WORD Handle1PGame
        .WORD Handle2PGame
        .WORD HandleGameOver

    HandleLogo:
        RTS

    HandleTitle:
        RTS

    HandleGamemodeSelection:
        RTS

    HandleDifficultySelection:
        RTS

    Handle1PGame:
        RTS

    Handle2PGame:
        RTS

    HandleGameOver:
        RTS

    .INCLUDE "system/MainJumpEngine.asm"

.ENDPROC
.EXPORT MAIN

VBLANK_WAIT:
    BIT PPUSTATUS
    BPL VBLANK_WAIT
    RTS
.EXPORT VBLANK_WAIT

.INCLUDE "system/vectors/NMI_HANDLER.inc"
.INCLUDE "system/vectors/IRQ_HANDLER.inc"
.INCLUDE "system/vectors/RESET_HANDLER.inc"

.INCLUDE "system/segments/CHR.inc"
.INCLUDE "system/segments/VECTORS.inc"

