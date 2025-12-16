MainJumpEngine:
    AND #%00001111 ;Strip Identifiers
    ASL ; Shift to get index
    TAX
    LDA MAIN_PROGRAM_STATE_TABLE_HI, X
    PHA
    LDA MAIN_PROGRAM_STATE_TABLE_LO, X
    PHA
    RTS
.EXPORT MainJumpEngine
