.SEGMENT "ZEROPAGE"
addrPointer: .RES 2
jumpPointer: .RES 2
currentFrame: .RES 1
currentSecond: .RES 2
sleeping: .RES 1
programState: .RES 1
gameState: .RES 1

; Graphics stuff
PPUCTRL_MIRROR: .RES 1
PPUMASK_MIRROR: .RES 1
nextScreen: .RES 2
currentScreen: .RES 1
nextTable: .RES 1
lastPaletteDest: .RES 1
nextPaletteDest: .RES 1
nextPalette: .RES 2
currentPalette: .RES 2

; UFO Stuff (Y, then X)
logoUFOPos: .RES 2
ufoTargetPos: .RES 2
ufoPathIndex: .RES 2

; 0000 0000
; bit 7 - enabled
; bit 6 - bg/fg
; bits 0-1 speed
; bits 2-3 palette
logoUFOFlags: .RES 1

sparkleX: .RES 3
sparkleY: .RES 3

;Controller Stuff
buttons: .RES 2

;Ball
;y then x
ballPos: .RES 2
ballSpeed: .RES 2

; bit 0 - Left / Right
; bit 1 - Up / Down
; bit 2 & 3 - size
; bit 4 & 5 - color
ballState: .RES 1

;Players
;lo Ypos, Hi:
;
; 76543210
; bits 0-1: speed
; bits 2-3: size
; bits 4-5: color
p1Paddle: .RES 2
p2Paddle: .RES 2

.EXPORTZP addrPointer, jumpPointer
.EXPORTZP currentFrame, currentSecond, sleeping, programState, gameState
.EXPORTZP PPUCTRL_MIRROR, PPUMASK_MIRROR, nextScreen
.EXPORTZP currentScreen, nextTable, currentPalette, nextPalette, lastPaletteDest, nextPaletteDest
.EXPORTZP buttons, ballPos, ballSpeed, ballState
.EXPORTZP p1Paddle, p2Paddle
.EXPORTZP logoUFOPos, logoUFOFlags, ufoPathIndex, ufoTargetPos
