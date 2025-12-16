.INCLUDE "system/segments/HEADER.inc"
.INCLUDE "system/segments/ZEROPAGE.inc"
.INCLUDE "system/segments/RODATA.inc"

.SEGMENT "CODE"
.INCLUDE "system/CONSTANTS.inc"
.INCLUDE "system/VARIABLES.inc"

.IMPORT FadeIn4Steps, FadeOut4Steps
.PROC MAIN
    loop:
        LDA programState
        JMP MainJumpEngine
    JumpEngineFinished:

    INC sleeping
    sleep:
        LDA sleeping
        BPL sleep
        JMP loop

    HandleLogo:
        ; First we'll set the next
        ; screen to be the logo
        LDA #<logoScreen
        STA nextScreen
        LDA #>logoScreen
        STA nextScreen+1
        LDA #$20
        STA nextTable

        LogoFadeIn:
            ; Check if we're fading in.
            LDA logoState
            CMP #LOGOSTATE_FADE_IN
            BNE LogoHandleUFO

            ; Check if we've finished fading
            LDA fadeState
            CMP #FADE_STEP_FINAL+1
            BEQ LogoHandleUFO

            LDA #<LOGO_FADE_STATE_TABLE_HI
            STA addrPointer
            LDA #>LOGO_FADE_STATE_TABLE_HI
            STA addrPointer+1
            LDA #<LOGO_FADE_STATE_TABLE_LO
            STA jumpPointer
            LDA #>LOGO_FADE_STATE_TABLE_LO
            STA jumpPointer+1
            JSR FadeIn4Steps
            JMP :+

        LogoHandleUFO:
            ;LDA #LOGOSTATE_SHOW_UFO
            ;STA logoState

            ;LDA currentFrame
            ;CMP #$30
            ;BNE :+

            LDA #LOGOSTATE_FADE_OUT
            STA logoState
        LogoFadeOut:
            ; Check if we're fading in.
            LDA logoState
            CMP #LOGOSTATE_FADE_OUT
            BNE :+

            ; Check if we've finished fading
            ;LDY fadeState
            ;CMP #$00
            ;BVS FadeOutFinished

            LDA #<LOGO_FADE_STATE_TABLE_HI
            STA addrPointer
            LDA #>LOGO_FADE_STATE_TABLE_HI
            STA addrPointer+1
            LDA #<LOGO_FADE_STATE_TABLE_LO
            STA jumpPointer
            LDA #>LOGO_FADE_STATE_TABLE_LO
            STA jumpPointer+1
            JSR FadeOut4Steps
            JMP :+

            FadeOutFinished:
                LDA #STATE_TITLE
                STA programState

                LDA #<titleScreen
                STA nextScreen
                LDA #>titleScreen
                STA nextScreen
        :
        JMP JumpEngineFinished

    HandleTitle:
        LDA programState
        CMP #STATE_TITLE
        BNE :+





        :
        JMP JumpEngineFinished

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

    ; -1 to each part of the address because
    ; the jump engine uses the RTS trick.
    MAIN_PROGRAM_STATE_TABLE_HI:
        .HIBYTES HandleLogo-1
        .HIBYTES HandleTitle-1
        .HIBYTES HandleGamemodeSelection-1
        .HIBYTES HandleDifficultySelection-1
        .HIBYTES Handle1PGame-1
        .HIBYTES Handle2PGame-1
        .HIBYTES HandleGameOver-1
    MAIN_PROGRAM_STATE_TABLE_LO:
        .LOBYTES HandleLogo-1
        .LOBYTES HandleTitle-1
        .LOBYTES HandleGamemodeSelection-1
        .LOBYTES HandleDifficultySelection-1
        .LOBYTES Handle1PGame-1
        .LOBYTES Handle2PGame-1
        .LOBYTES HandleGameOver-1

    LOGO_FADE_STATE_TABLE_HI:
        .HIBYTES LOGO_BG_FADE_0
        .HIBYTES LOGO_BG_FADE_1
        .HIBYTES LOGO_BG_FADE_2
        .HIBYTES LOGO_BG_FADE_FINAL
    LOGO_FADE_STATE_TABLE_LO:
        .LOBYTES LOGO_BG_FADE_0
        .LOBYTES LOGO_BG_FADE_1
        .LOBYTES LOGO_BG_FADE_2
        .LOBYTES LOGO_BG_FADE_FINAL

    TITLE_FADE_STATE_TABLE_HI:
        .HIBYTES TITLE_BG_FADE_0
        .HIBYTES TITLE_BG_FADE_1
        .HIBYTES TITLE_BG_FADE_2
        .HIBYTES TITLE_BG_FADE_FINAL
    TITLE_FADE_STATE_TABLE_LO:
        .LOBYTES TITLE_BG_FADE_0
        .LOBYTES TITLE_BG_FADE_1
        .LOBYTES TITLE_BG_FADE_2
        .LOBYTES TITLE_BG_FADE_FINAL

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

