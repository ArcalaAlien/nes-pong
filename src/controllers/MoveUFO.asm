.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.SEGMENT "ZEROPAGE"
.IMPORTZP currentFrame, logoUFOPos, ufoTargetPos

.SEGMENT "CODE"
.PROC MoveUFO
    LDA logoState
    CMP #LOGOSTATE_MOVE_UFO
    BNE :+

    ;Check if we've hit the end of the
    ;movement list

    ;Check Y, then X
    CheckUFOY:
        LDA currentFrame
        AND #$01
        BNE CheckUFOX

        LDA logoUFOPos
        CMP ufoTargetPos
        BEQ CheckUFOYFinish
        BCS MoveUFOUp

        MoveUFODown:
            CLC
            ADC #$01
            JMP CheckUFOYFinish

        MoveUFOUp:
            SEC
            SBC #$01

        CheckUFOYFinish:
            TAX
            LDA ufoTargetPos
            CMP #$FF
            BEQ :+

        UpdateYPosition:
            TXA
            ; Update stuff here
            STA logoUFOPos
            STA SPRITE_0_Y
            STA SPRITE_1_Y

    CheckUFOX:
        LDA logoUFOPos+1
        CMP ufoTargetPos+1
        BEQ CheckUFOXFinish
        BCS MoveUFOLeft

        MoveUFORight:
            CLC
            ADC #$02
            JMP CheckUFOXFinish

        MoveUFOLeft:
            SEC
            SBC #$02

        CheckUFOXFinish:
            TAX
            LDA ufoTargetPos+1
            CMP #$FF
            BEQ :+
        UpdateXPosition:
            TXA
            ;Set Left Side
            STA SPRITE_0_X
            STA logoUFOPos+1

            CMP #$FF
            BNE SetRightUFOX

            STA SPRITE_1_X
            JMP :+

        SetRightUFOX:
            CLC
            ADC #$08
            STA SPRITE_1_X
    :
    RTS
.ENDPROC
.EXPORT MoveUFO
