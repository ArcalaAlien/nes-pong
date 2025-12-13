;Program States
STATE_LOGO                  = $10
STATE_TITLE                 = $11
STATE_CHOOSE_GAMEMODE       = $12
STATE_CHOOSE_DIFFICULTY     = $13
STATE_PLAYING_1P            = $14
STATE_PLAYING_2P            = $15
STATE_GAME_OVER             = $16

;Game States
GAMESTATE_PLAYING           = $21
GAMESTATE_MATCH_OVER        = $22
GAMESTATE_ROUND_OVER        = $23
GAMESTATE_CHOOSE_MODIFIER   = $24

;Buttons
BUTTON_RIGHT                = (1 << 0)
BUTTON_LEFT                 = (1 << 1)
BUTTON_DOWN                 = (1 << 2)
BUTTON_UP                   = (1 << 3)
BUTTON_SELECT               = (1 << 4)
BUTTON_START                = (1 << 5)
BUTTON_B                    = (1 << 6)
BUTTON_A                    = (1 << 7)

;Addresses
;PPU
PPUCTRL                     = $2000
PPUMASK                     = $2001
PPUSTATUS                   = $2002
OAMADDR                     = $2003
OAMDATA                     = $2004
PPUSCROLL                   = $2005
PPUADDR                     = $2006
PPUDATA                     = $2007
OAMDMA                      = $4014

;APU


;Graphics Stuff
;PPUCTRL Flags
CTRL_NAMETABLE_0    = (1 << 0)
CTRL_NAMETABLE_1    = (1 << 1)
CTRL_VRAM_INC       = (1 << 2)
CTRL_SPRITE_TABLE   = (1 << 3)
CTRL_BG_TABLE       = (1 << 4)
CTRL_SPRITE_SIZE    = (1 << 5)
CTRL_EXTPIN_SWITCH  = (1 << 6)
CTRL_NMI_ENABLE     = (1 << 7)

;PPUMASK Flags
MASK_GREYSCALE      = (1 << 0)
MASK_LEFT_BG        = (1 << 1)
MASK_LEFT_SPRITES   = (1 << 2)
ENABLE_BG           = (1 << 3)
ENABLE_SPRITES      = (1 << 4)
EMPHASIZE_RED       = (1 << 5)
EMPHASIZE_GREEN     = (1 << 6)
EMPHASIZE_BLUE      = (1 << 7)

SCREEN_TOP                  = $00
SCREEN_BOTTOM               = $FF
SCREEN_LEFT                 = $00
SCREEN_RIGHT                = $FF
SCREEN_CENTER               = $80

BG_PALETTE_0                = $00
BG_PALETTE_1                = $04
BG_PALETTE_2                = $08
BG_PALETTE_3                = $0C

SPR_PALETTE_0               = $10
SPR_PALETTE_1               = $14
SPR_PALETTE_2               = $18
SPR_PALETTE_3               = $1C

;Defaults
PADDLE1_X                   = $18
PADDLE2_X                   = $DF
PADDLE1_START_TOP_Y         = $18
PADDLE2_START_TOP_Y         = $D8

BALL_START                  = SCREEN_CENTER
BALL_SPEED_X                = SPEED_SLOW_AMOUNT
BALL_SPEED_Y                = SPEED_SLOW_AMOUNT

;Speed Flags
SPEED_FLAG_SLOW             = $00
SPEED_FLAG_MED              = $01
SPEED_FLAG_MED_FAST         = $02
SPEED_FLAG_FAST             = $03

;Speed Amounts
SPEED_SLOW_AMOUNT           = $01
SPEED_MED_AMOUNT            = $02
SPEED_MED_FAST_AMOUNT       = $03
SPEED_FAST_AMOUNT           = $04

;Size Flags
SIZE_FLAG_SMALL             = %00000000
SIZE_FLAG_MEDIUM            = %00000100
SIZE_FLAG_MED_LARGE         = %00001000
SIZE_FLAG_LARGE             = %00001100

;Offsets
SIZE_OFFSET_SMALL           = $02
SIZE_OFFSET_MEDIUM          = $04
SIZE_OFFSET_MED_LARGE       = $06
SIZE_OFFSET_LARGE           = $08

; Color Flags
COLOR_FLAG_PLT1             = %00000000
COLOR_FLAG_PLT2             = %00010000
COLOR_FLAG_PLT3             = %00100000
COLOR_FLAG_PLT4             = %00110000
