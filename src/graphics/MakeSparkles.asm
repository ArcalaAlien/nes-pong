.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.SEGMENT "ZEROPAGE"
.IMPORTZP currentFrame, logoUFOPos, ufoTargetPos
.IMPORTZP sparkleFlags, sparkleX, sparkleY

.SEGMENT "CODE"
.PROC MakeSparkles
    LDA logoState
    CMP #LOGOSTATE_MOVE_UFO
    BNE :+

    LDA #$00
    STA matches

    LDA currentFrame
    CMP #$00
    BNE :+
    CMP #$0F
    BNE :+
    CMP #$1D
    BNE :+
    CMP #$2D
    BNE :+

    AND #$01            ; Even or odd frame will
                        ; determine what sparkle
                        ; check for
    BNE HandleSparkle2  ; Sparkle 2 gets odd frames.

    HandleSparkle1:
        CheckSparkle1Y:
            LDA SPRITE_2_Y
            CMP #$FE
            BEQ CheckSparkle1X

            ; SPRITE_2 probably has an object
            ; in it.
            INC matches

        CheckSparkle1X:
            LDA SPRITE_2_X
            CMP #$FE
            BEQ CheckIfSparkle1Filled

            ; SPRITE_2 DEFINITELY has an
            ; object in it.
            INC matches

        CheckIfSparkle1Filled:
            LDA matches
            CMP #$02
            BEQ MoveSparkle1    ;If there's already an object
                                ;in that spot we don't want
                                ;to overwrite it.

        CreateSparkle1:

    JMP :+
    HandleSparkle2:
        CheckSparkle2Y:
            LDA SPRITE_2_Y
            CMP #$FE
            BEQ CheckSparkle2X

            ; SPRITE_2 probably has an object
            ; in it.
            INC matches

        CheckSparkle2X:
            LDA SPRITE_2_X
            CMP #$FE
            BEQ CheckIfSparkle2Filled

            ; SPRITE_2 DEFINITELY has an
            ; object in it.
            INC matches

        CheckIfSparkle2Filled:
            LDA matches
            CMP #$02
            BEQ :+              ;If there's already an object
                                ;in that spot we don't want
                                ;to overwrite it.

        CreateSparkle2:
    :RTS
.ENDPROC
.EXPORT MakeSparkles
