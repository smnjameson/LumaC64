LevelPointerData:
    .word level_0

LevelPassCodeData:
    .encoding "screencode_upper"
    .text "KUPJ"

level_0:
    .byte 255,129,159,129,193,131,129,249,129,255    //Level wall data 
    .byte 20,17,10,49,17,65,18,82,3,67,2,83,2,68,4,84,18,69,13,85,17,86,22,134    //Level item data 
    .text "TESTTEST"    //Author
    .byte $00
    .byte 31    //Moves

