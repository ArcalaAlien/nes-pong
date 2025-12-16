.INCLUDE "../system/CONSTANTS.inc"
.INCLUDE "../system/VARIABLES.inc"

.SEGMENT "ZEROPAGE"
.IMPORTZP addrPointer, currentFrame, logoUFOPos, ufoTargetPos
.IMPORTZP ufoPathIndex

.SEGMENT "RODATA"
.IMPORT UFO_MOVEMENT_PATH_X, UFO_MOVEMENT_PATH_Y

.SEGMENT "CODE"
.PROC SetUFOTarget
    LDA logoState
    CMP #LOGOSTATE_MOVE_UFO
    BNE :+

    LoadYPathTable:
        LDA #<UFO_MOVEMENT_PATH_Y
        STA addrPointer
        LDA #>UFO_MOVEMENT_PATH_Y
        STA addrPointer+1

    CheckIfEndOfY:
        LDY ufoPathIndex
        LDA (addrPointer), Y
        CMP #$FF
        BEQ LoadXPathTable

    CheckIfHitYTarget:
        CMP logoUFOPos
        BNE LoadXPathTable
        INY
        STY ufoPathIndex
        LDA (addrPointer), Y

    LoadXPathTable:
        STA ufoTargetPos
        LDA #<UFO_MOVEMENT_PATH_X
        STA addrPointer
        LDA #>UFO_MOVEMENT_PATH_X
        STA addrPointer+1

    CheckIfHitEndOfX:
        LDY ufoPathIndex+1
        LDA (addrPointer), Y
        CMP #$FF
        BEQ CheckXFinish

    CheckIfHitXTarget:
        CMP logoUFOPos+1
        BNE CheckXFinish
        INY
        STY ufoPathIndex+1
        LDA (addrPointer), Y

    CheckXFinish:
        STA ufoTargetPos+1
    :
    RTS
.ENDPROC
.EXPORT SetUFOTarget
