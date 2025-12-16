
.IMPORT LoadPalettes
.PROC RESET_HANDLER
    SEI
    CLD
    LDX #40
    STX $4017 ; Disable APU Frame Counter
    LDX #$FF
    TXS ; Add terminator to stack
    INX ; Overflow to 0
    STX PPUCTRL
    STX PPUMASK
    STX $4010 ; Stop DMC IRQs

    JSR VBLANK_WAIT

    CLEAR_MEMORY:
        STA $0000,X
        STA $0100,X
        STA $0300,X
        STA $0400,X
        STA $0600,X
        STA $0700,X
        LDA #$FE
        STA $0200, X ;Why are we setting everything in OAM
        LDA #$00     ;to FE?
        INX
        BNE CLEAR_MEMORY

    JSR VBLANK_WAIT

    LDA #$02
    STA OAMDMA
    NOP     ; NOP to wait for a little bit?

    CLEAR_PALETTES:
        BIT PPUSTATUS
        LDA #$3F
        STA PPUADDR
        LDA #$00
        STA PPUADDR

        LDX #$18
        :
            LDA #$0F
            STA PPUDATA
            DEX
            BNE :-


    CLEAR_NAMETABLES:
        BIT PPUSTATUS
        LDA #$20
        STA PPUADDR
        LDA #$00
        STA PPUADDR

        ; Set all nametables to our empty
        ; block
        LDX #$08
        LDY #$00
        LDA #$26
        :
            STA PPUDATA
            DEY
            BNE :-
            DEX
            BNE :-

    ; Set up Pong Ball here
    LDA #BALL_START
    STA ballPos
    STA ballPos+1

    LDA #SPEED_SLOW_AMOUNT
    STA ballSpeed
    STA ballSpeed+1

    LDA ballState
    ORA #SIZE_FLAG_MEDIUM | COLOR_FLAG_PLT1
    STA ballState

    ; Set up paddles here
    LDA #PADDLE1_START_TOP_Y
    STA p1Paddle
    LDA #PADDLE2_START_TOP_Y
    STA p2Paddle

    LDA #SPEED_FLAG_MED | SIZE_FLAG_MEDIUM
    STA p1Paddle+1
    STA p2Paddle+1

    LDA #UFO_START_Y
    STA logoUFOPos
    LDA #UFO_START_X
    STA logoUFOPos+1
    LDA #UFO_DEFAULT_FLAGS
    STA logoUFOFlags

    BIT PPUSTATUS
    LDA #$00
    STA PPUSCROLL
    STA PPUSCROLL

    LDA #CTRL_NMI_ENABLE | CTRL_BG_TABLE
    STA PPUCTRL_MIRROR
    STA PPUCTRL

    LDA #ENABLE_BG | ENABLE_SPRITES
    STA PPUMASK_MIRROR
    STA PPUMASK

    LDA #STATE_LOGO
    STA programState
    JMP MAIN
.ENDPROC
.EXPORT RESET_HANDLER
