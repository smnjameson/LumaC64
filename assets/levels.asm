LevelPointerData:
    .word level_0
    .word level_3
    .word level_9
    .word level_4
    .word level_25
    .word level_1
    .word level_2
    .word level_5
    .word level_6
    .word level_7
    .word level_8
    .word level_10
    .word level_11
    .word level_12
    .word level_13
    .word level_14
    .word level_15
    .word level_16
    .word level_17
    .word level_18
    .word level_19
    .word level_20
    .word level_21
    .word level_22
    .word level_23
    .word level_24
    .word level_26
    .word level_27
    .word level_28
    .word level_29
    .word level_30
    .word level_31
    .word level_32
    .word level_33
    .word level_34
    .word level_35
    .word level_36
    .word level_37
    .word level_38
    .word level_39
    .word level_40
    .word level_41
    .word level_42
    .word level_43
    .word level_44
    .word level_45
    .word level_46
    .word level_47
    .word level_48
    .word level_49
    .word level_50
    .word level_51
    .word level_52
    .word level_53
    .word level_54
    .word level_55
    .word level_56
    .word level_57
    .word level_58
    .word level_59

LevelPassCodeData:
    .encoding "screencode_upper"
    .text "DFFA"
    .text "KUPJ"
    .text "RPRF"
    .text "PGTX"
    .text "KXWV"
    .text "ITSF"
    .text "PNVJ"
    .text "ZLCA"
    .text "FEFN"
    .text "YHRO"
    .text "TMLF"
    .text "TMZH"
    .text "UPMB"
    .text "HYDF"
    .text "IDLS"
    .text "BWLC"
    .text "DXHQ"
    .text "BBXB"
    .text "PQHN"
    .text "UCVG"
    .text "IHFA"
    .text "COYL"
    .text "ECKZ"
    .text "WRBF"
    .text "SNNZ"
    .text "HHUE"
    .text "SQMK"
    .text "MGSR"
    .text "BGWZ"
    .text "JRLF"
    .text "AQCV"
    .text "CAOD"
    .text "XJLJ"
    .text "CTIO"
    .text "AXFW"
    .text "MRPI"
    .text "UPRQ"
    .text "IFKE"
    .text "VJWL"
    .text "JRIL"
    .text "HNXU"
    .text "NOMW"
    .text "KLPW"
    .text "JDBE"
    .text "BGMV"
    .text "ARWG"
    .text "JHHO"
    .text "CCLE"
    .text "VGLS"
    .text "DYVC"
    .text "WUYW"
    .text "JEZQ"
    .text "MHVH"
    .text "HBVA"
    .text "SMCP"
    .text "FKIJ"
    .text "SWTN"
    .text "IKBW"
    .text "LDCR"
    .text "EAXK"


level_0:
    .byte 8,8,8,8,8,8,8,8,8,8    //Level wall data 
    .byte 4,0,4,32,4,48,4,64,4,96,19,112,3,128,18,144,4,1,4,33,4,49,4,65,18,81,4,97,4,113,3,129,4,145,4,2,3,18,18,34,19,50,4,66,4,98,4,114,4,146,17,4,3,36,3,52,3,68,3,84,3,100,3,116,3,132,20,148,4,149,4,150,14,23,3,39,3,55,3,71,3,87,3,103,3,119,3,135,19,151    //Level item data 
    .byte $ff  
    .text "CHISTUT1"    //Author
    .byte $00
    .byte 1    //Moves

level_1:
    .byte 4,2,0,0,0,128,34,0,128,0    //Level wall data 
    .byte 19,0,21,32,2,112,18,128,20,49,3,65,4,145,19,98,18,114,2,19,18,51,18,131,18,147,19,4,3,84,2,132,19,148,18,5,18,21,9,37,4,69,19,133,17,38,14,54,19,150,5,39,18,55,22,119    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 3    //Moves

level_2:
    .byte 0,0,0,128,0,128,0,0,0,0    //Level wall data 
    .byte 19,0,2,16,18,32,19,80,19,96,2,128,18,144,18,129,4,145,2,34,2,66,19,146,19,19,3,35,15,67,3,99,2,4,18,20,5,52,17,68,10,84,19,116,2,132,18,5,20,53,16,69,3,101,3,117,22,6,18,23,21,135,2,151    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 4    //Moves

level_3:
    .byte 16,16,16,16,16,16,16,16,16,16    //Level wall data 
    .byte 22,0,18,144,9,113,17,145,17,2,6,34,18,3,21,147,4,5,4,37,4,53,4,69,4,101,19,117,3,133,18,149,4,6,4,38,4,54,4,70,18,86,4,102,4,118,3,134,4,150,4,7,3,23,18,39,19,55,4,71,4,103,4,119,4,151    //Level item data 
    .byte $ff  
    .text "CHISTUT2"    //Author
    .byte $00
    .byte 4    //Moves

level_4:
    .byte 3,1,1,0,0,0,0,128,128,192    //Level wall data 
    .byte 21,48,17,80,12,128,5,144,20,2,18,50,3,66,3,82,2,98,4,51,4,99,17,147,17,4,4,52,4,100,2,53,3,69,3,85,18,101,22,149,6,7,15,23,17,71,21,103    //Level item data 
    .byte $ff  
    .text "CHISTUT4"    //Author
    .byte $00
    .byte 4    //Moves

level_5:
    .byte 0,0,124,68,68,68,68,68,124,0    //Level wall data 
    .byte 16,51,20,83,19,99,18,85,17,117    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 5    //Moves

level_6:
    .byte 0,80,0,0,0,0,2,0,0,32    //Level wall data 
    .byte 2,0,19,64,21,80,5,144,19,1,2,17,18,33,19,145,12,50,15,82,18,146,2,3,18,35,5,67,17,83,10,99,19,52,2,84,19,148,18,5,2,53,3,85,18,117,19,102,15,118,20,7,4,39,18,135,22,151    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 6    //Moves

level_7:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,0,18,16,19,32,18,112,19,128,18,144,19,49,18,97,19,66,5,146,13,147,18,68,20,5,18,69,19,101,18,54,19,118,18,7,19,23,18,39,17,87,19,135,21,151    //Level item data 
    .byte $ff  
    .text "MRG84722"    //Author
    .byte $00
    .byte 6    //Moves

level_8:
    .byte 2,0,0,0,0,1,0,0,2,0    //Level wall data 
    .byte 2,16,3,48,19,96,2,128,20,144,3,49,19,113,18,66,17,3,19,51,2,67,18,83,3,147,19,20,4,84,4,21,5,85,4,133,18,22,19,38,19,54,18,102,3,118,9,150,18,39,3,55,22,103,15,135,17,151    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 6    //Moves

level_9:
    .byte 8,8,8,40,40,40,8,8,8,8    //Level wall data 
    .byte 4,0,4,32,4,48,4,64,4,96,19,112,3,128,18,144,4,1,4,33,4,49,4,65,18,81,4,97,4,113,3,129,4,145,4,2,3,18,18,34,19,50,4,66,4,98,4,114,4,146,3,20,3,36,21,52,20,84,3,100,3,116,3,132,19,37,18,101,5,54,14,86,18,7,17,71,19,151    //Level item data 
    .byte $ff  
    .text "CHISTUT3"    //Author
    .byte $00
    .byte 6    //Moves

level_10:
    .byte 34,40,96,0,1,0,144,0,0,8    //Level wall data 
    .byte 17,0,12,80,10,2,22,82,20,98,13,146,17,101,17,6,15,87,17,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 7    //Moves

level_11:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,49,17,97,19,34,18,66,19,82,18,114,9,19,20,131,22,20,14,132,18,37,19,117,18,54,19,102,18,71,19,87    //Level item data 
    .byte $ff  
    .text "CHISWICK"    //Author
    .byte $00
    .byte 7    //Moves

level_12:
    .byte 0,128,0,1,0,0,0,4,128,2    //Level wall data 
    .byte 18,32,18,64,20,80,7,144,3,17,18,49,19,129,18,2,17,34,19,50,2,66,18,82,17,146,2,19,4,51,7,83,18,99,18,115,18,131,3,36,18,52,9,68,17,84,10,100,21,148,16,21,14,85,19,101,18,117,4,149,19,22,2,118,19,134,10,7,17,55,22,87,19,103    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 7    //Moves

level_13:
    .byte 16,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,32,18,112,18,144,19,1,2,33,3,65,3,81,2,113,20,66,4,82,18,114,19,146,2,3,4,19,4,20,18,68,2,84,19,116,4,85,19,101,3,117,18,6,2,38,18,70,18,86,2,118,13,150,18,39,19,135,17,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 8    //Moves

level_14:
    .byte 0,8,30,50,3,132,3,18,12,0    //Level wall data 
    .byte 17,32,2,48,17,112,14,17,2,81,5,129,2,18,20,50,18,66,19,98,21,114,4,83,2,20,4,84,2,132,2,37,4,85,2,117,2,54,4,70,4,102,2,55,19,71,18,103    //Level item data 
    .byte $ff  
    .text "SPRTHUND"    //Author
    .byte $00
    .byte 8    //Moves

level_15:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,0,18,16,19,32,18,48,19,80,18,96,19,128,18,144,18,1,18,17,19,33,19,65,19,81,19,113,19,129,19,145,19,2,19,18,19,34,19,50,19,66,19,82,19,98,19,114,19,130,18,146,18,3,18,19,18,35,18,51,18,67,18,83,18,99,18,115,19,131,19,147,19,4,19,20,19,36,19,52,19,68,19,84,19,100,19,116,19,132,18,148,18,5,18,21,18,37,18,53,18,69,18,85,18,101,18,117,19,133,19,149,19,6,19,22,17,118,13,134,18,150,18,7,18,55,19,71,18,103,19,119,20,135,19,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 10    //Moves

level_16:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 4,16,19,32,5,64,14,80,3,128,17,65,17,81,18,145,4,34,2,98,20,3,21,131,18,36,18,5,2,53,20,85,19,101,19,133,21,149,17,70,17,86,4,23,13,71,6,87,3,135    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 11    //Moves

level_17:
    .byte 0,0,102,0,0,0,0,36,0,0    //Level wall data 
    .byte 22,112,10,128,19,49,13,97,20,113,18,50,18,98,19,53,19,101,18,54,17,103    //Level item data 
    .byte $ff  
    .text "MRG84721"    //Author
    .byte $00
    .byte 11    //Moves

level_18:
    .byte 0,0,8,74,192,192,90,8,0,0    //Level wall data 
    .byte 16,0,17,33,17,113,19,2,3,18,2,34,20,50,20,98,2,114,3,130,19,146,12,67,12,83,17,52,4,68,4,84,19,37,3,53,19,69,18,85,3,101,18,117,15,22,4,38,4,118,22,39,22,119    //Level item data 
    .byte $ff  
    .text "SPRTHUND"    //Author
    .byte $00
    .byte 11    //Moves

level_19:
    .byte 23,21,29,0,58,0,62,34,28,0    //Level wall data 
    .byte 18,7,19,23,22,71,4,87,17,119,4,135,9,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 12    //Moves

level_20:
    .byte 8,0,128,2,250,0,1,0,0,0    //Level wall data 
    .byte 21,144,6,81,2,82,19,146,17,6,17,7,12,55,18,87,22,151    //Level item data 
    .byte $ff  
    .text "SPRTHUND"    //Author
    .byte $00
    .byte 13    //Moves

level_21:
    .byte 129,4,36,2,8,16,226,32,38,128    //Level wall data 
    .byte 21,145,19,146,17,6,6,118    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 14    //Moves

level_22:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 6,0,12,144,17,65,18,145,19,3,21,83,20,84,17,100,17,69,22,85,15,7,19,151    //Level item data 
    .byte $ff  
    .text "RICHMOND"    //Author
    .byte $00
    .byte 14    //Moves

level_23:
    .byte 0,4,42,17,1,1,17,42,4,0    //Level wall data 
    .byte 17,0,17,144,16,1,16,145,20,50,20,98,18,67,19,99,18,53,19,69,19,85,18,101,18,38,19,118    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 15    //Moves

level_24:
    .byte 8,8,40,42,0,0,0,0,0,0    //Level wall data 
    .byte 10,0,3,48,17,1,18,97,18,113,6,2,3,50,4,67,4,83,4,99,4,115,4,131,4,147,22,36,3,52,19,100,18,38,3,54,2,118,21,134,4,150,19,39,3,55,18,103    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 15    //Moves

level_25:
    .byte 129,0,40,108,0,0,108,40,0,129    //Level wall data 
    .byte 18,64,19,80,19,34,7,66,11,82,18,114,2,3,2,147,21,36,17,52,17,100,22,116,18,38,19,118,18,71,19,87    //Level item data 
    .byte $ff  
    .text "CHISTUT5"    //Author
    .byte $00
    .byte 16    //Moves

level_26:
    .byte 144,8,0,0,0,8,0,0,8,4    //Level wall data 
    .byte 2,0,16,16,2,32,19,48,2,64,21,144,17,1,2,49,17,97,10,113,18,129,22,145,2,50,20,3,2,147,2,52,2,132,18,148,2,37,18,53,2,69,2,133,19,149,2,54,19,86,2,118,5,134,17,150,2,119,2,135,2,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 17    //Moves

level_27:
    .byte 0,0,0,0,96,224,96,0,0,0    //Level wall data 
    .byte 2,0,3,64,2,80,3,96,12,128,4,81,4,82,4,83,22,4,4,84,19,54,19,71,18,103,18,119,19,135,17,151    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 17    //Moves

level_28:
    .byte 0,0,0,16,4,16,0,6,1,0    //Level wall data 
    .byte 8,144,18,129,19,130,21,68,17,22    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 18    //Moves

level_29:
    .byte 0,0,0,0,0,8,0,0,0,0    //Level wall data 
    .byte 17,64,3,17,4,65,22,81,3,129,19,34,4,131,4,20,19,68,19,5,19,53,20,69,4,85,19,149,3,22,4,54,16,70,3,134,10,23,17,39,18,135    //Level item data 
    .byte $ff  
    .text "CHISWICK"    //Author
    .byte $00
    .byte 19    //Moves

level_30:
    .byte 0,16,32,64,64,64,64,32,16,0    //Level wall data 
    .byte 20,50,22,98,9,21,14,133,17,22,18,38,19,118,17,134    //Level item data 
    .byte $ff  
    .text "VOID"    //Author
    .byte $00
    .byte 20    //Moves

level_31:
    .byte 0,0,8,0,0,8,0,8,0,0    //Level wall data 
    .byte 19,0,3,16,3,32,3,48,3,64,3,80,3,96,3,112,3,128,20,144,4,1,19,17,3,33,3,49,3,65,3,81,3,97,4,2,4,18,4,130,4,146,4,3,4,19,4,131,4,147,4,4,4,20,18,36,4,132,4,148,4,5,4,21,17,37,19,53,13,117,4,133,4,149,4,6,18,22,3,38,3,54,3,70,3,86,3,102,3,118,19,134,4,150,18,7,3,23,3,39,3,55,3,71,3,87,3,103,3,119,3,135,19,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 21    //Moves

level_32:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,33,22,81,19,18,19,34,17,114,10,83,22,147,14,85,20,149,18,22,18,38,17,70,17,134,18,39,9,87    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 22    //Moves

level_33:
    .byte 32,32,36,36,36,36,36,36,4,4    //Level wall data 
    .byte 19,64,18,80,20,144,19,65,18,81,22,145,3,35,19,67,18,83,2,147,3,36,19,68,18,84,10,22,3,118,17,7,14,23,17,87,3,119    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 22    //Moves

level_34:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 21,64,21,80,2,96,21,65,2,81,19,34,2,66,21,82,18,146,17,83,7,148,5,69,6,149,18,38,8,86,18,7,19,87,19,119,19,151    //Level item data 
    .byte $ff  
    .text "MRG84723"    //Author
    .byte $00
    .byte 23    //Moves

level_35:
    .byte 0,254,130,131,129,129,129,129,255,0    //Level wall data 
    .byte 16,65,12,82,21,51,17,52,20,53,19,54,22,70,5,118    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 25    //Moves

level_36:
    .byte 0,118,66,106,42,34,234,138,226,56    //Level wall data 
    .byte 9,83,18,84,19,100,18,116,19,132,22,86,17,118    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 25    //Moves

level_37:
    .byte 255,137,205,129,129,145,145,145,145,255    //Level wall data 
    .byte 18,49,3,113,18,129,21,18,19,66,4,130,18,69,19,117,17,22,18,70,19,118,7,134    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 27    //Moves

level_38:
    .byte 0,0,0,0,0,0,0,0,0,4    //Level wall data 
    .byte 18,0,19,16,12,96,18,144,21,81,18,97,6,2,19,18,19,50,20,66,4,82,22,67,2,83,4,84,18,7,15,23,17,71,17,87,17,103,18,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 27    //Moves

level_39:
    .byte 0,0,0,0,23,0,20,0,0,0    //Level wall data 
    .byte 20,0,16,144,17,49,17,81,3,113,18,2,4,50,4,82,19,146,18,3,2,51,19,67,3,99,19,147,19,4,4,52,4,84,18,148,19,5,2,85,18,149,11,7,3,103,22,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 27    //Moves

level_40:
    .byte 0,0,0,4,16,0,0,18,0,0    //Level wall data 
    .byte 7,16,17,112,21,97,17,34,9,82,19,146,20,149,22,6,4,22,2,102,3,150,19,7,15,103    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 27    //Moves

level_41:
    .byte 195,231,102,66,0,0,66,102,231,195    //Level wall data 
    .byte 17,32,16,64,20,80,4,65,4,81,17,2,17,50,17,98,3,19,3,131,9,147,6,4,3,20,3,132,18,53,19,101,17,149,4,70,4,86,21,71,22,87    //Level item data 
    .byte $ff  
    .text "ARENA"    //Author
    .byte $00
    .byte 28    //Moves

level_42:
    .byte 0,96,1,127,64,2,254,128,6,0    //Level wall data 
    .byte 4,17,4,65,19,113,4,18,18,34,18,114,4,19,19,35,11,83,22,131,21,20,8,68,17,84,4,132,18,37,19,117,4,133,19,38,4,86,18,118,4,134    //Level item data 
    .byte $ff  
    .text "PHAZE101"    //Author
    .byte $00
    .byte 28    //Moves

level_43:
    .byte 240,194,136,187,184,135,196,240,16,16    //Level wall data 
    .byte 18,0,17,64,21,97,19,146,6,3,18,83,19,99,19,115,19,147,18,36,19,84,18,21,18,38    //Level item data 
    .byte $ff  
    .text "AIRJURI"    //Author
    .byte $00
    .byte 31    //Moves

level_44:
    .byte 8,8,0,68,68,68,68,68,124,0    //Level wall data 
    .byte 17,65,16,97,17,34,2,35,20,115,7,147,19,100,19,69,19,85,18,101,21,117,4,6,4,22,4,38    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 36    //Moves

level_45:
    .byte 8,122,10,142,6,96,113,80,94,16    //Level wall data 
    .byte 19,0,19,16,19,32,18,48,18,1,4,145,19,2,18,18,20,34,11,146,17,147,17,4,16,5,22,117,18,133,19,149,4,6,18,150,18,103,19,119,19,135,19,151    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 36    //Moves

level_46:
    .byte 4,8,0,0,1,0,1,0,4,0    //Level wall data 
    .byte 21,80,6,1,6,81,4,82,20,146,13,3,3,36,19,116,17,148,13,149,4,70,18,86,2,150,17,7,2,135,19,151    //Level item data 
    .byte $ff  
    .text "MRG84724"    //Author
    .byte $00
    .byte 37    //Moves

level_47:
    .byte 0,0,0,128,129,130,2,0,128,0    //Level wall data 
    .byte 3,128,20,144,19,50,19,66,18,82,18,98,17,51,17,67,17,83,17,99,18,52,18,68,19,84,19,100,3,70,15,7    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 38    //Moves

level_48:
    .byte 0,24,240,19,0,0,22,0,86,0    //Level wall data 
    .byte 19,0,8,32,21,64,20,80,19,144,17,65,17,81,18,147,2,84,18,7,14,55,18,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 40    //Moves

level_49:
    .byte 0,0,60,36,32,32,36,60,0,128    //Level wall data 
    .byte 19,0,3,48,3,64,3,80,3,96,3,112,16,128,18,144,4,1,4,145,4,2,4,146,4,3,4,131,4,147,4,4,19,52,4,148,4,5,18,133,4,149,4,6,17,134,20,150,10,23,3,39,3,55,3,71,3,87,3,103,3,119,22,135    //Level item data 
    .byte $ff  
    .text "TRAPPED"    //Author
    .byte $00
    .byte 41    //Moves

level_50:
    .byte 255,132,144,145,181,128,246,132,132,144    //Level wall data 
    .byte 18,16,18,32,11,82,3,51,20,67,17,83,22,99,3,115,16,84,19,149,19,118,19,134,19,150    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 43    //Moves

level_51:
    .byte 64,126,0,0,8,16,0,0,126,2    //Level wall data 
    .byte 18,0,3,128,21,144,19,1,19,2,18,146,19,3,17,83,8,147,19,4,17,68,18,148,11,5,19,149,19,150,22,7    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 44    //Moves

level_52:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,0,17,16,17,32,17,48,16,80,20,96,12,128,22,144,19,17,18,33,6,3,18,147,21,4,19,148,15,23,20,39,18,87,19,103,18,135,19,151    //Level item data 
    .byte $ff  
    .text "FURROY"    //Author
    .byte $00
    .byte 50    //Moves

level_53:
    .byte 0,0,0,0,0,0,0,64,0,136    //Level wall data 
    .byte 19,0,19,112,18,128,19,17,18,97,19,34,18,82,19,51,22,67,20,83,21,99,22,115,18,52,13,68,2,132,18,37,10,53,19,133,18,22,5,38,18,7,9,23,2,71,17,135    //Level item data 
    .byte $ff  
    .text "AMOK"    //Author
    .byte $00
    .byte 50    //Moves

level_54:
    .byte 255,1,189,133,181,181,165,189,129,255    //Level wall data 
    .byte 15,129,19,51,18,67,18,83,19,99,18,52,20,100,19,53,17,134    //Level item data 
    .byte $ff  
    .text "PEWPEW"    //Author
    .byte $00
    .byte 54    //Moves

level_55:
    .byte 17,85,85,69,85,69,85,20,85,69    //Level wall data 
    .byte 22,112,18,1,18,145,19,3,19,147,17,52,17,84,18,5,18,149,19,7,19,103,3,119,9,135,17,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 62    //Moves

level_56:
    .byte 0,12,18,129,129,129,18,12,0,0    //Level wall data 
    .byte 17,0,19,32,18,96,19,144,12,50,16,82,4,53,4,85,18,6,19,150,20,7,22,151    //Level item data 
    .byte $ff  
    .text "SKULL"    //Author
    .byte $00
    .byte 67    //Moves

level_57:
    .byte 0,16,16,16,16,56,16,0,0,0    //Level wall data 
    .byte 6,64,9,80,18,49,18,65,18,81,18,97,18,113,19,66,19,82,19,98,20,67,22,99,4,116,4,132,17,53,21,69,20,101,17,117,15,71,15,87    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 70    //Moves

level_58:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,0,17,16,22,32,14,64,9,128,20,144,17,1,17,17,19,50,18,98,2,67,2,83,2,68,2,84,18,53,19,101,7,7,21,39,21,119,7,151    //Level item data 
    .byte $ff  
    .text "FML"    //Author
    .byte $00
    .byte 74    //Moves

level_59:
    .byte 64,0,64,0,0,0,0,0,0,2    //Level wall data 
    .byte 2,64,17,97,12,2,22,146,21,3,2,19,19,35,4,51,3,67,2,83,4,115,3,131,2,147,19,4,19,20,18,132,19,148,18,5,4,21,5,37,2,53,5,69,4,85,3,101,2,117,4,149,20,22,4,118,18,7,13,103,3,135,17,151    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 154    //Moves

