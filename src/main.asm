.INCLUDE "system/segments/HEADER.inc"
.INCLUDE "system/segments/ZEROPAGE.inc"
.INCLUDE "system/segments/RODATA.inc"

.SEGMENT "CODE"
.INCLUDE "system/CONSTANTS.inc"
.INCLUDE "system/VARIABLES.inc"

.IMPORT FadeIn4Steps, FadeOut4Steps
.IMPORT DrawUFO, SetUFOTarget, MoveUFO, CleanUpUFO
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
            BEQ FadeInFinished

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

            FadeInFinished:
                LDA #LOGOSTATE_LOAD_UFO
                STA logoState
                JMP:+

        LogoHandleUFO:
            ;Don't want to start handling this
            ;Until three seconds after, to give
            ;ample delay for the logo.
            LDA currentSecond
            CMP #$03
            BCC :+

            ;Now we draw the UFO
            JSR DrawUFO

            ; Set the logo state to move
            ; the UFO, so we don't keep
            ; updating the UFO sprite.
            LDA logoState
            CMP #LOGOSTATE_MOVE_UFO
            BNE LogoFadeOut

            ; Move the UFO!
            JSR SetUFOTarget
            JSR MoveUFO

            ;Has the UFO Y hit the
            ;end of its target list?
            LDA ufoTargetPos
            CMP #$FF
            BNE :+

            ;If so, has the UFO X hit
            ;the end of ITS target list?
            LDA ufoTargetPos+1
            CMP #$FF
            BNE :+

            ;If so, we can get rid of the
            ;UFO.
            JSR CleanUpUFO

            ;Then we can start fading out.
            LDA #LOGOSTATE_FADE_OUT
            STA logoState
            JMP :+

        LogoFadeOut:
            ; Check if we're fading out
            LDA logoState
            CMP #LOGOSTATE_FADE_OUT
            BNE :+

            ; Check if we've finished fading
            LDY fadeState
            BEQ FadeOutFinished

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
    :
    JMP JumpEngineFinished ; End of LOGO
    HandleTitle:
        LDA programState
        CMP #STATE_TITLE
        BNE :+

        LDA #<titleScreen
        STA nextScreen
        LDA #>titleScreen
        STA nextScreen+1
        LDA #$20
        STA nextTable

        LDA #TITLESTATE_FADE_IN
        STA titleState
        LDA #BG_PALETTE_0
        STA nextPaletteDest
        TitleFadeIn:
            LDA titleState
            CMP #TITLESTATE_FADE_IN
            BNE TitleWaitForPress

            ; hi bytes of fade tables
            LDA #<TITLE_FADE_STATE_TABLE_HI
            STA addrPointer
            LDA #>TITLE_FADE_STATE_TABLE_HI
            STA addrPointer+1

            ; lo bytes of fade tables
            LDA #<TITLE_FADE_STATE_TABLE_LO
            STA jumpPointer
            LDA #>TITLE_FADE_STATE_TABLE_LO
            STA jumpPointer+1
            JSR FadeIn4Steps

        TitleWaitForPress:
            LDA titleState
            CMP #TITLESTATE_WAIT_FOR_BUTTON
            BNE TitleFadeToDemo

        TitleFadeToDemo:
            LDA titleState
            CMP #TITLESTATE_FADE_TO_DEMO
            BNE TitleFadeToTitle

        TitleFadeToTitle:
            LDA titleState
            CMP #TITLESTATE_FADE_TO_TITLE
            BNE TitleFadeOut

        TitleFadeOut:
            LDA titleState
            CMP #TITLESTATE_FADE_OUT
            BNE :+
    :
    JMP JumpEngineFinished ; END OF TITLE
    HandleGamemodeSelection:
        LDA programState
        CMP #STATE_CHOOSE_GAMEMODE
        BNE :+

    :
    JMP JumpEngineFinished ; END OF GAMEMODE MENU
    HandleDifficultySelection:
        LDA programState
        CMP #STATE_CHOOSE_DIFFICULTY
        BNE :+

    :
    JMP JumpEngineFinished; ; END OF DIFFICULTY MENU
    Handle1PGame:
        LDA programState
        CMP #STATE_PLAYING_1P
        BNE :+
    :
    JMP JumpEngineFinished  ; END OF 1P GAME
    Handle2PGame:
        LDA programState
        CMP #STATE_PLAYING_2P
        BNE :+

    :
    JMP JumpEngineFinished ; END OF 2P GAME
    HandleGameOver:
        LDA programState
        CMP #STATE_GAME_OVER
        BNE :+
    :
    JMP JumpEngineFinished ; END OF GAME OVER

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

