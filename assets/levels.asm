LevelPointerData:
    .word level_0
    .word level_1
    .word level_2
    .word level_3
    .word level_4
    .word level_5
    .word level_6
    .word level_7
    .word level_8
    .word level_9
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
    .word level_25
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
    .word level_60
    .word level_61
    .word level_62
    .word level_63
    .word level_64
    .word level_65
    .word level_66
    .word level_67
    .word level_68
    .word level_69
    .word level_70
    .word level_71
    .word level_72
    .word level_73
    .word level_74
    .word level_75
    .word level_76
    .word level_77
    .word level_78
    .word level_79
    .word level_80
    .word level_81
    .word level_82
    .word level_83
    .word level_84
    .word level_85
    .word level_86
    .word level_87
    .word level_88
    .word level_89
    .word level_90
    .word level_91
    .word level_92
    .word level_93
    .word level_94
    .word level_95
    .word level_96
    .word level_97
    .word level_98
    .word level_99
    .word level_100
    .word level_101
    .word level_102
    .word level_103
    .word level_104
    .word level_105
    .word level_106
    .word level_107
    .word level_108
    .word level_109

.align $100
LevelPassCodeData:
    .encoding "screencode_upper"
    .text "DFFA"
    .text "KUPJ"
    .text "JJRZ"
    .text "RPRF"
    .text "PGTX"
    .text "KXWV"
    .text "CSRD"
    .text "MGAY"
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
    .text "UNSF"
    .text "NSIO"
    .text "BWLC"
    .text "DXHQ"
    .text "BBXB"
    .text "PQHN"
    .text "GSKL"
    .text "FRSR"
    .text "UCVG"
    .text "XKGW"
    .text "IHFA"
    .text "COYL"
    .text "ECKZ"
    .text "HGWR"
    .text "HDOO"
    .text "WRBF"
    .text "SNNZ"
    .text "IOAI"
    .text "HHUE"
    .text "SQMK"
    .text "MGSR"
    .text "BGWZ"
    .text "WDEL"
    .text "HNDB"
    .text "JRLF"
    .text "IMVJ"
    .text "GVMR"
    .text "IAND"
    .text "YYBY"
    .text "AQCV"
    .text "CUQI"
    .text "SGOL"
    .text "AIZX"
    .text "CAOD"
    .text "LRKL"
    .text "XJLJ"
    .text "CTIO"
    .text "WHLX"
    .text "DMVS"
    .text "ANEU"
    .text "AXFW"
    .text "ZKVH"
    .text "MRPI"
    .text "UPRQ"
    .text "KYUB"
    .text "RUEE"
    .text "XAPD"
    .text "IFKE"
    .text "VJWL"
    .text "JRIL"
    .text "HNXU"
    .text "TGGY"
    .text "NOMW"
    .text "KLPW"
    .text "OPVR"
    .text "ASXA"
    .text "SZDO"
    .text "SGGV"
    .text "JDBE"
    .text "PPKL"
    .text "SDZB"
    .text "BGMV"
    .text "ARWG"
    .text "DMHR"
    .text "JHHO"
    .text "CCLE"
    .text "GXOL"
    .text "VGLS"
    .text "XPYP"
    .text "DYVC"
    .text "FLGS"
    .text "WUYW"
    .text "MBBF"
    .text "JEZQ"
    .text "WZVZ"
    .text "EJJV"
    .text "EAJK"
    .text "MHVH"
    .text "HBVA"
    .text "XVVD"
    .text "KHVR"
    .text "SMCP"
    .text "FKIJ"
    .text "SWTN"
    .text "QQMM"
    .text "IKBW"
    .text "VEJC"
    .text "LDCR"
    .text "TFQK"
    .text "QNXE"
    .text "EAXK"
    .text "UWLI"


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
    .byte 129,133,245,197,133,133,133,133,129,255    //Level wall data 
    .byte 19,65,18,129,11,130,6,35,2,51,18,99,17,131,17,20,22,6,18,70,2,118,21,134    //Level item data 
    .byte $ff  
    .text "CEBERUS"    //Author
    .byte $00
    .byte 3    //Moves

level_3:
    .byte 0,0,0,128,0,128,0,0,0,0    //Level wall data 
    .byte 19,0,2,16,18,32,19,80,19,96,2,128,18,144,18,129,4,145,2,34,2,66,19,146,19,19,3,35,15,67,3,99,2,4,18,20,5,52,17,68,10,84,19,116,2,132,18,5,20,53,16,69,3,101,3,117,22,6,18,23,21,135,2,151    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 4    //Moves

level_4:
    .byte 16,16,16,16,16,16,16,16,16,16    //Level wall data 
    .byte 22,0,18,144,9,113,17,145,17,2,6,34,18,3,21,147,4,5,4,37,4,53,4,69,4,101,19,117,3,133,18,149,4,6,4,38,4,54,4,70,18,86,4,102,4,118,3,134,4,150,4,7,3,23,18,39,19,55,4,71,4,103,4,119,4,151    //Level item data 
    .byte $ff  
    .text "CHISTUT2"    //Author
    .byte $00
    .byte 4    //Moves

level_5:
    .byte 3,1,1,0,0,0,0,128,128,192    //Level wall data 
    .byte 21,48,17,80,12,128,5,144,20,2,18,50,3,66,3,82,2,98,4,51,4,99,17,147,17,4,4,52,4,100,2,53,3,69,3,85,18,101,22,149,6,7,15,23,17,71,21,103    //Level item data 
    .byte $ff  
    .text "CHISTUT4"    //Author
    .byte $00
    .byte 4    //Moves

level_6:
    .byte 0,0,0,16,0,0,8,0,0,0    //Level wall data 
    .byte 16,0,17,16,19,32,3,48,3,64,3,80,3,96,3,112,3,128,5,144,4,1,19,17,18,33,18,129,17,145,4,2,3,66,19,82,18,114,18,146,4,3,18,19,20,67,22,83,19,115,4,147,4,4,21,68,20,84,4,148,18,5,3,85,19,101,4,149,17,6,18,38,19,70,4,150,10,7,3,23,3,39,3,55,3,71,3,87,3,103,17,135,15,151    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 4    //Moves

level_7:
    .byte 255,131,137,137,143,227,169,173,129,239    //Level wall data 
    .byte 19,33,18,49,19,97,3,113,18,129,19,18,19,34,20,50,19,82,19,98,4,130,4,19,4,83,4,131,4,20,14,36,3,52,18,68,18,84,3,100,3,116,2,132,22,148,4,21,17,53,4,69,4,133,18,22,3,38,3,54,19,70,17,102,11,134    //Level item data 
    .byte $ff  
    .text "WIZARDNJ"    //Author
    .byte $00
    .byte 4    //Moves

level_8:
    .byte 0,0,124,68,68,68,68,68,124,0    //Level wall data 
    .byte 16,51,20,83,19,99,18,85,17,117    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 5    //Moves

level_9:
    .byte 0,80,0,0,0,0,2,0,0,32    //Level wall data 
    .byte 2,0,19,64,21,80,5,144,19,1,2,17,18,33,19,145,12,50,15,82,18,146,2,3,18,35,5,67,17,83,10,99,19,52,2,84,19,148,18,5,2,53,3,85,18,117,19,102,15,118,20,7,4,39,18,135,22,151    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 6    //Moves

level_10:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,0,18,16,19,32,18,112,19,128,18,144,19,49,18,97,19,66,5,146,13,147,18,68,20,5,18,69,19,101,18,54,19,118,18,7,19,23,18,39,17,87,19,135,21,151    //Level item data 
    .byte $ff  
    .text "MRG84722"    //Author
    .byte $00
    .byte 6    //Moves

level_11:
    .byte 2,0,0,0,0,1,0,0,2,0    //Level wall data 
    .byte 2,16,3,48,19,96,2,128,20,144,3,49,19,113,18,66,17,3,19,51,2,67,18,83,3,147,19,20,4,84,4,21,5,85,4,133,18,22,19,38,19,54,18,102,3,118,9,150,18,39,3,55,22,103,15,135,17,151    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 6    //Moves

level_12:
    .byte 8,8,8,40,40,40,8,8,8,8    //Level wall data 
    .byte 4,0,4,32,4,48,4,64,4,96,19,112,3,128,18,144,4,1,4,33,4,49,4,65,18,81,4,97,4,113,3,129,4,145,4,2,3,18,18,34,19,50,4,66,4,98,4,114,4,146,3,20,3,36,21,52,20,84,3,100,3,116,3,132,19,37,18,101,5,54,14,86,18,7,17,71,19,151    //Level item data 
    .byte $ff  
    .text "CHISTUT3"    //Author
    .byte $00
    .byte 6    //Moves

level_13:
    .byte 34,40,96,0,1,0,144,0,0,8    //Level wall data 
    .byte 17,0,12,80,10,2,22,82,20,98,13,146,17,101,17,6,15,87,17,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 7    //Moves

level_14:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,49,17,97,19,34,18,66,19,82,18,114,9,19,20,131,22,20,14,132,18,37,19,117,18,54,19,102,18,71,19,87    //Level item data 
    .byte $ff  
    .text "CHISWICK"    //Author
    .byte $00
    .byte 7    //Moves

level_15:
    .byte 0,128,0,1,0,0,0,4,128,2    //Level wall data 
    .byte 18,32,18,64,20,80,7,144,3,17,18,49,19,129,18,2,17,34,19,50,2,66,18,82,17,146,2,19,4,51,7,83,18,99,18,115,18,131,3,36,18,52,9,68,17,84,10,100,21,148,16,21,14,85,19,101,18,117,4,149,19,22,2,118,19,134,10,7,17,55,22,87,19,103    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 7    //Moves

level_16:
    .byte 16,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,32,18,112,18,144,19,1,2,33,3,65,3,81,2,113,20,66,4,82,18,114,19,146,2,3,4,19,4,20,18,68,2,84,19,116,4,85,19,101,3,117,18,6,2,38,18,70,18,86,2,118,13,150,18,39,19,135,17,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 8    //Moves

level_17:
    .byte 0,8,30,50,3,132,3,18,12,0    //Level wall data 
    .byte 17,32,2,48,17,112,14,17,2,81,5,129,2,18,20,50,18,66,19,98,21,114,4,83,2,20,4,84,2,132,2,37,4,85,2,117,2,54,4,70,4,102,2,55,19,71,18,103    //Level item data 
    .byte $ff  
    .text "SPRTHUND"    //Author
    .byte $00
    .byte 8    //Moves

level_18:
    .byte 16,136,68,162,145,136,4,130,65,32    //Level wall data 
    .byte 4,48,4,112,4,33,4,97,15,145,4,18,4,82,4,3,4,67,4,52,4,148,4,37,19,85,19,101,18,117,4,133,4,22,20,54,4,118,4,7,17,103    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 8    //Moves

level_19:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 21,0,20,144,3,1,3,145,15,55,18,71,19,87,7,103,17,119    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 9    //Moves

level_20:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,0,18,16,19,32,18,48,19,80,18,96,19,128,18,144,18,1,18,17,19,33,19,65,19,81,19,113,19,129,19,145,19,2,19,18,19,34,19,50,19,66,19,82,19,98,19,114,19,130,18,146,18,3,18,19,18,35,18,51,18,67,18,83,18,99,18,115,19,131,19,147,19,4,19,20,19,36,19,52,19,68,19,84,19,100,19,116,19,132,18,148,18,5,18,21,18,37,18,53,18,69,18,85,18,101,18,117,19,133,19,149,19,6,19,22,17,118,13,134,18,150,18,7,18,55,19,71,18,103,19,119,20,135,19,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 10    //Moves

level_21:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 4,16,19,32,5,64,14,80,3,128,17,65,17,81,18,145,4,34,2,98,20,3,21,131,18,36,18,5,2,53,20,85,19,101,19,133,21,149,17,70,17,86,4,23,13,71,6,87,3,135    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 11    //Moves

level_22:
    .byte 0,0,102,0,0,0,0,36,0,0    //Level wall data 
    .byte 22,112,10,128,19,49,13,97,20,113,18,50,18,98,19,53,19,101,18,54,17,103    //Level item data 
    .byte $ff  
    .text "MRG84721"    //Author
    .byte $00
    .byte 11    //Moves

level_23:
    .byte 0,0,8,74,192,192,90,8,0,0    //Level wall data 
    .byte 16,0,17,33,17,113,19,2,3,18,2,34,20,50,20,98,2,114,3,130,19,146,12,67,12,83,17,52,4,68,4,84,19,37,3,53,19,69,18,85,3,101,18,117,15,22,4,38,4,118,22,39,22,119    //Level item data 
    .byte $ff  
    .text "SPRTHUND"    //Author
    .byte $00
    .byte 11    //Moves

level_24:
    .byte 0,64,64,68,196,0,51,34,2,0    //Level wall data 
    .byte 18,80,20,112,16,1,19,17,22,65,4,81,6,98,15,146,18,19,3,51,17,83,3,115,18,131,9,5,4,85,21,102,19,134,19,23,18,39,20,55,18,87,19,103,18,151    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 11    //Moves

level_25:
    .byte 0,0,0,0,0,0,6,2,0,0    //Level wall data 
    .byte 19,144,4,65,18,34,3,50,19,66,22,114,3,130,19,146,18,3,3,19,3,35,3,51,3,67,3,83,3,99,3,115,3,131,18,52,19,100,3,116,19,5,4,37,4,53,4,101,10,6,3,22,3,70,19,150,17,7,19,23,18,55,18,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 11    //Moves

level_26:
    .byte 23,21,29,0,58,0,62,34,28,0    //Level wall data 
    .byte 18,7,19,23,22,71,4,87,17,119,4,135,9,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 12    //Moves

level_27:
    .byte 0,249,0,0,0,0,0,0,1,0    //Level wall data 
    .byte 17,0,2,17,3,97,2,18,2,50,18,66,2,51,2,67,3,131,18,52,19,68,3,132,3,101,4,149,4,38,19,134,4,150,14,7,19,39,3,119,3,135,20,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 12    //Moves

level_28:
    .byte 8,0,128,2,250,0,1,0,0,0    //Level wall data 
    .byte 21,144,6,81,2,82,19,146,17,6,17,7,12,55,18,87,22,151    //Level item data 
    .byte $ff  
    .text "SPRTHUND"    //Author
    .byte $00
    .byte 13    //Moves

level_29:
    .byte 129,4,36,2,8,16,226,32,38,128    //Level wall data 
    .byte 21,145,19,146,17,6,6,118    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 14    //Moves

level_30:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 6,0,12,144,17,65,18,145,19,3,21,83,20,84,17,100,17,69,22,85,15,7,19,151    //Level item data 
    .byte $ff  
    .text "RICHMOND"    //Author
    .byte $00
    .byte 14    //Moves

level_31:
    .byte 14,17,17,101,133,129,105,35,38,60    //Level wall data 
    .byte 3,49,19,18,2,34,3,98,18,19,2,35,18,68,18,84,13,100,20,116,18,132,17,69,19,70,19,86    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 14    //Moves

level_32:
    .byte 0,64,64,64,64,64,64,64,64,0    //Level wall data 
    .byte 19,17,18,129,19,34,18,114,18,35,21,99,18,20,19,116,19,133,6,7,19,23,18,39,19,55,18,71,17,87    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 14    //Moves

level_33:
    .byte 0,4,42,17,1,1,17,42,4,0    //Level wall data 
    .byte 17,0,17,144,16,1,16,145,20,50,20,98,18,67,19,99,18,53,19,69,19,85,18,101,18,38,19,118    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 15    //Moves

level_34:
    .byte 8,8,40,42,0,0,0,0,0,0    //Level wall data 
    .byte 10,0,3,48,17,1,18,97,18,113,6,2,3,50,4,67,4,83,4,99,4,115,4,131,4,147,22,36,3,52,19,100,18,38,3,54,2,118,21,134,4,150,19,39,3,55,18,103    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 15    //Moves

level_35:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 3,32,3,48,11,144,2,18,3,66,3,51,22,67,4,83,3,68,18,116,2,5,4,117,4,118,17,7,2,39,19,119    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 15    //Moves

level_36:
    .byte 129,0,40,108,0,0,108,40,0,129    //Level wall data 
    .byte 18,64,19,80,19,34,7,66,11,82,18,114,2,3,2,147,21,36,17,52,17,100,22,116,18,38,19,118,18,71,19,87    //Level item data 
    .byte $ff  
    .text "CHISTUT5"    //Author
    .byte $00
    .byte 16    //Moves

level_37:
    .byte 144,8,0,0,0,8,0,0,8,4    //Level wall data 
    .byte 2,0,16,16,2,32,19,48,2,64,21,144,17,1,2,49,17,97,10,113,18,129,22,145,2,50,20,3,2,147,2,52,2,132,18,148,2,37,18,53,2,69,2,133,19,149,2,54,19,86,2,118,5,134,17,150,2,119,2,135,2,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 17    //Moves

level_38:
    .byte 0,0,0,0,96,224,96,0,0,0    //Level wall data 
    .byte 2,0,3,64,2,80,3,96,12,128,4,81,4,82,4,83,22,4,4,84,19,54,19,71,18,103,18,119,19,135,17,151    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 17    //Moves

level_39:
    .byte 0,0,0,16,4,16,0,6,1,0    //Level wall data 
    .byte 8,144,18,129,19,130,21,68,17,22    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 18    //Moves

level_40:
    .byte 0,8,4,2,1,0,0,0,0,0    //Level wall data 
    .byte 15,32,12,48,17,112,2,128,2,144,21,50,4,66,20,35,18,51,17,67,5,131,3,36,2,134,2,150,2,135,22,151    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 18    //Moves

level_41:
    .byte 79,7,2,0,0,0,0,1,23,0    //Level wall data 
    .byte 22,32,20,144,17,145,14,4,18,5,11,133,19,118    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 18    //Moves

level_42:
    .byte 0,0,0,0,0,8,0,0,0,0    //Level wall data 
    .byte 17,64,3,17,4,65,22,81,3,129,19,34,4,131,4,20,19,68,19,5,19,53,20,69,4,85,19,149,3,22,4,54,16,70,3,134,10,23,17,39,18,135    //Level item data 
    .byte $ff  
    .text "CHISWICK"    //Author
    .byte $00
    .byte 19    //Moves

level_43:
    .byte 128,224,16,0,0,0,0,16,224,128    //Level wall data 
    .byte 3,64,3,80,3,65,3,81,3,66,3,82,3,67,3,83,3,68,3,84,15,5,19,37,19,53,3,69,3,85,18,101,18,117,11,149,17,6,18,38,18,54,3,70,3,86,19,102,19,118,17,150,22,39,18,55,3,71,3,87,19,103,20,119    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 19    //Moves

level_44:
    .byte 120,143,193,135,132,132,135,193,143,120    //Level wall data 
    .byte 17,33,17,113,16,51,16,99,4,21,4,133,20,22,18,54,19,70,18,86,19,102,20,134    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 19    //Moves

level_45:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 18,0,19,112,18,17,19,97,5,35,10,67,18,36,16,52,19,68,19,37,2,53,18,69,21,39,20,55,22,71,17,151    //Level item data 
    .byte $ff  
    .text "MEOW"    //Author
    .byte $00
    .byte 19    //Moves

level_46:
    .byte 7,33,37,164,133,145,17,148,132,228    //Level wall data 
    .byte 18,48,18,112,22,17,2,132,18,5,19,85,18,6,2,70,11,134,17,7,19,103    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 19    //Moves

level_47:
    .byte 0,16,32,64,64,64,64,32,16,0    //Level wall data 
    .byte 20,50,22,98,9,21,14,133,17,22,18,38,19,118,17,134    //Level item data 
    .byte $ff  
    .text "VOID"    //Author
    .byte $00
    .byte 20    //Moves

level_48:
    .byte 0,0,0,0,0,0,0,0,0,2    //Level wall data 
    .byte 17,0,17,16,4,32,18,64,18,80,3,128,20,144,4,33,2,34,14,3,4,35,2,99,14,4,4,36,2,84,17,5,2,37,2,69,4,38,4,86,17,23,4,39,3,71,20,87,3,103,19,119,19,135,19,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 20    //Moves

level_49:
    .byte 0,0,0,0,0,0,0,0,0,131    //Level wall data 
    .byte 17,0,10,16,3,32,18,64,2,80,19,96,19,128,17,1,6,17,2,33,19,65,3,81,18,129,17,2,10,18,2,34,18,66,3,82,18,98,20,146,17,3,14,19,3,35,19,67,2,83,19,99,3,147,17,4,10,20,3,36,18,68,2,84,18,100,3,148,17,5,6,21,2,37,19,69,3,85,19,101,22,149,17,6,10,22,2,38,18,70,3,86,19,134,21,150,17,7,14,23,3,39,19,71,2,87,18,135    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 20    //Moves

level_50:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 16,32,18,17,19,33,19,49,11,34,19,52,3,68,3,84,3,100,3,116,17,37,3,53,3,69,3,85,3,101,3,117,3,22,3,38,3,54,3,70,3,86,3,102,3,118,3,134,18,23,20,39,22,119    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 20    //Moves

level_51:
    .byte 0,0,8,0,0,8,0,8,0,0    //Level wall data 
    .byte 19,0,3,16,3,32,3,48,3,64,3,80,3,96,3,112,3,128,20,144,4,1,19,17,3,33,3,49,3,65,3,81,3,97,4,2,4,18,4,130,4,146,4,3,4,19,4,131,4,147,4,4,4,20,18,36,4,132,4,148,4,5,4,21,17,37,19,53,13,117,4,133,4,149,4,6,18,22,3,38,3,54,3,70,3,86,3,102,3,118,19,134,4,150,18,7,3,23,3,39,3,55,3,71,3,87,3,103,3,119,3,135,19,151    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 21    //Moves

level_52:
    .byte 170,1,128,1,128,1,128,1,128,85    //Level wall data 
    .byte 17,32,17,64,17,96,17,128,19,17,13,129,17,145,21,2,19,51,5,131,17,147,20,4,19,85,9,133,17,149,22,6,15,22,7,54,11,86,19,102,19,118,19,134,17,23,17,55,17,87,17,119    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 21    //Moves

level_53:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,33,22,81,19,18,19,34,17,114,10,83,22,147,14,85,20,149,18,22,18,38,17,70,17,134,18,39,9,87    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 22    //Moves

level_54:
    .byte 32,32,36,36,36,36,36,36,4,4    //Level wall data 
    .byte 19,64,18,80,20,144,19,65,18,81,22,145,3,35,19,67,18,83,2,147,3,36,19,68,18,84,10,22,3,118,17,7,14,23,17,87,3,119    //Level item data 
    .byte $ff  
    .text "STEPZ"    //Author
    .byte $00
    .byte 22    //Moves

level_55:
    .byte 0,3,130,0,42,42,42,42,0,0    //Level wall data 
    .byte 17,0,22,32,3,128,18,144,12,1,4,145,19,66,18,82,19,98,18,114,4,146,4,147,18,68,18,84,19,100,19,116,4,148,4,149,4,150,3,71,3,87,3,103,3,119,3,135,19,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 22    //Moves

level_56:
    .byte 255,129,165,129,193,131,129,161,129,255    //Level wall data 
    .byte 17,129,8,50,18,66,17,82,21,35,18,20,22,116,19,69,11,101,19,54    //Level item data 
    .byte $ff  
    .text "ZOOPRDAN"    //Author
    .byte $00
    .byte 22    //Moves

level_57:
    .byte 0,130,0,0,0,0,0,0,0,130    //Level wall data 
    .byte 4,0,21,16,21,144,4,1,3,49,18,65,19,97,3,113,4,2,18,18,18,50,4,66,4,98,18,114,18,146,4,3,3,19,19,67,7,83,18,99,2,4,5,68,17,84,6,100,2,148,4,5,3,21,18,69,8,85,19,101,4,6,18,22,18,54,4,70,4,102,19,118,19,150,4,7,3,55,19,71,18,103,3,119,19,135    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 22    //Moves

level_58:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 21,64,21,80,2,96,21,65,2,81,19,34,2,66,21,82,18,146,17,83,7,148,5,69,6,149,18,38,8,86,18,7,19,87,19,119,19,151    //Level item data 
    .byte $ff  
    .text "MRG84723"    //Author
    .byte $00
    .byte 23    //Moves

level_59:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 18,16,17,96,19,112,18,33,8,49,19,97,18,50,6,66,19,82,4,67,4,68,4,69,4,70,21,39,3,55,19,71,3,87,21,103    //Level item data 
    .byte $ff  
    .text "MARTINI"    //Author
    .byte $00
    .byte 23    //Moves

level_60:
    .byte 0,254,130,131,129,129,129,129,255,0    //Level wall data 
    .byte 16,65,12,82,21,51,17,52,20,53,19,54,22,70,5,118    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 25    //Moves

level_61:
    .byte 0,118,66,106,42,34,234,138,226,56    //Level wall data 
    .byte 9,83,18,84,19,100,18,116,19,132,22,86,17,118    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 25    //Moves

level_62:
    .byte 0,0,0,64,0,8,0,64,0,0    //Level wall data 
    .byte 15,48,8,80,11,112,17,17,17,147,21,84,20,53,18,69,19,101,22,117,17,22,18,70,19,102,18,71,19,103    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 25    //Moves

level_63:
    .byte 130,0,0,0,0,0,0,0,0,130    //Level wall data 
    .byte 22,0,3,16,3,128,22,144,2,33,19,65,18,81,2,113,18,66,19,82,19,67,18,83,18,68,19,84,9,70,10,86,17,71,17,87    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 26    //Moves

level_64:
    .byte 255,130,131,250,3,2,251,130,131,254    //Level wall data 
    .byte 17,67,17,83,2,68,2,84,2,69,2,85,16,22,22,38,2,70,2,86,20,118,12,134,2,71,2,87    //Level item data 
    .byte $ff  
    .text "CASTLE"    //Author
    .byte $00
    .byte 26    //Moves

level_65:
    .byte 255,137,205,129,129,145,145,145,145,255    //Level wall data 
    .byte 18,49,3,113,18,129,21,18,19,66,4,130,18,69,19,117,17,22,18,70,19,118,7,134    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 27    //Moves

level_66:
    .byte 0,0,0,0,0,0,0,0,0,4    //Level wall data 
    .byte 18,0,19,16,12,96,18,144,21,81,18,97,6,2,19,18,19,50,20,66,4,82,22,67,2,83,4,84,18,7,15,23,17,71,17,87,17,103,18,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 27    //Moves

level_67:
    .byte 0,0,0,0,23,0,20,0,0,0    //Level wall data 
    .byte 20,0,16,144,17,49,17,81,3,113,18,2,4,50,4,82,19,146,18,3,2,51,19,67,3,99,19,147,19,4,4,52,4,84,18,148,19,5,2,85,18,149,11,7,3,103,22,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 27    //Moves

level_68:
    .byte 0,0,0,4,16,0,0,18,0,0    //Level wall data 
    .byte 7,16,17,112,21,97,17,34,9,82,19,146,20,149,22,6,4,22,2,102,3,150,19,7,15,103    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 27    //Moves

level_69:
    .byte 5,16,248,134,128,128,134,248,2,16    //Level wall data 
    .byte 18,16,2,32,18,64,19,80,2,112,18,144,18,1,19,33,19,113,2,145,19,34,18,19,20,51,22,99,18,52,19,68,18,84,19,100,19,21,17,53,17,69,17,85,17,101,18,133,3,22,17,54,17,70,17,86,17,102,3,134,15,7,17,23,17,135,11,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 27    //Moves

level_70:
    .byte 195,231,102,66,0,0,66,102,231,195    //Level wall data 
    .byte 17,32,16,64,20,80,4,65,4,81,17,2,17,50,17,98,3,19,3,131,9,147,6,4,3,20,3,132,18,53,19,101,17,149,4,70,4,86,21,71,22,87    //Level item data 
    .byte $ff  
    .text "ARENA"    //Author
    .byte $00
    .byte 28    //Moves

level_71:
    .byte 0,96,1,127,64,2,254,128,6,0    //Level wall data 
    .byte 4,17,4,65,19,113,4,18,18,34,18,114,4,19,19,35,11,83,22,131,21,20,8,68,17,84,4,132,18,37,19,117,4,133,19,38,4,86,18,118,4,134    //Level item data 
    .byte $ff  
    .text "PHAZE101"    //Author
    .byte $00
    .byte 28    //Moves

level_72:
    .byte 0,33,0,0,64,0,0,64,2,64    //Level wall data 
    .byte 11,0,18,32,17,80,18,96,19,112,19,49,18,113,22,2,19,66,18,146,4,35,4,67,4,83,4,99,4,115,20,4,2,36,2,52,19,68,15,100,4,116,7,85,21,6,2,38,19,54,16,102,4,134,18,23,18,71,3,87,19,135    //Level item data 
    .byte $ff  
    .text "OSKCODER"    //Author
    .byte $00
    .byte 28    //Moves

level_73:
    .byte 4,4,244,4,4,221,16,16,80,16    //Level wall data 
    .byte 17,0,19,32,19,96,18,112,19,128,18,144,18,1,9,65,3,81,3,35,18,67,22,99,19,69,3,85,10,101,17,133,18,102,19,118,22,7,19,23,18,71,19,103,18,119    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 29    //Moves

level_74:
    .byte 16,208,128,128,128,128,0,0,0,0    //Level wall data 
    .byte 18,32,18,80,4,33,4,81,4,34,4,82,16,3,4,35,4,83,4,36,4,84,19,100,16,148,20,5,3,21,3,101,3,117,3,133,2,149,17,38,17,86,20,102    //Level item data 
    .byte $ff  
    .text "PIRATES"    //Author
    .byte $00
    .byte 30    //Moves

level_75:
    .byte 128,224,240,24,0,0,24,240,224,128    //Level wall data 
    .byte 17,35,17,115,18,20,19,132,19,5,18,149,20,6,2,70,2,86,20,150,15,71,15,87    //Level item data 
    .byte $ff  
    .text "VOLCANO"    //Author
    .byte $00
    .byte 30    //Moves

level_76:
    .byte 240,194,136,187,184,135,196,240,16,16    //Level wall data 
    .byte 18,0,17,64,21,97,19,146,6,3,18,83,19,99,19,115,19,147,18,36,19,84,18,21,18,38    //Level item data 
    .byte $ff  
    .text "AIRJURI"    //Author
    .byte $00
    .byte 31    //Moves

level_77:
    .byte 0,0,0,16,8,16,0,0,0,0    //Level wall data 
    .byte 19,0,3,16,16,80,3,128,18,144,4,1,4,145,20,68,4,69,4,6,4,150,18,7,3,23,17,39,19,71,18,119,3,135,19,151    //Level item data 
    .byte $ff  
    .text "TARGET"    //Author
    .byte $00
    .byte 31    //Moves

level_78:
    .byte 32,60,0,128,195,66,66,64,12,4    //Level wall data 
    .byte 21,80,17,33,17,49,6,34,20,147,22,4,9,116,17,85,9,117,15,54,19,7,18,23,19,39,22,87    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 35    //Moves

level_79:
    .byte 8,8,0,68,68,68,68,68,124,0    //Level wall data 
    .byte 17,65,16,97,17,34,2,35,20,115,7,147,19,100,19,69,19,85,18,101,21,117,4,6,4,22,4,38    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 36    //Moves

level_80:
    .byte 8,122,10,142,6,96,113,80,94,16    //Level wall data 
    .byte 19,0,19,16,19,32,18,48,18,1,4,145,19,2,18,18,20,34,11,146,17,147,17,4,16,5,22,117,18,133,19,149,4,6,18,150,18,103,19,119,19,135,19,151    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 36    //Moves

level_81:
    .byte 128,192,224,240,248,248,0,0,0,0    //Level wall data 
    .byte 2,64,2,80,17,1,2,113,2,129,2,34,2,98,13,146,2,35,4,99,4,100,4,101,19,6,4,102,18,103,3,119,3,135,20,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 36    //Moves

level_82:
    .byte 4,8,0,0,1,0,1,0,4,0    //Level wall data 
    .byte 21,80,6,1,6,81,4,82,20,146,13,3,3,36,19,116,17,148,13,149,4,70,18,86,2,150,17,7,2,135,19,151    //Level item data 
    .byte $ff  
    .text "MRG84724"    //Author
    .byte $00
    .byte 37    //Moves

level_83:
    .byte 0,0,0,128,129,130,2,0,128,0    //Level wall data 
    .byte 3,128,20,144,19,50,19,66,18,82,18,98,17,51,17,67,17,83,17,99,18,52,18,68,19,84,19,100,3,70,15,7    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 38    //Moves

level_84:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,0,19,16,20,48,17,64,18,128,18,144,16,65,21,3,2,67,22,147,17,4,6,20,2,52,18,68,19,84,2,100,19,116,9,132,17,148,2,85,15,86,20,71,17,87    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 39    //Moves

level_85:
    .byte 0,24,240,19,0,0,22,0,86,0    //Level wall data 
    .byte 19,0,8,32,21,64,20,80,19,144,17,65,17,81,18,147,2,84,18,7,14,55,18,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 40    //Moves

level_86:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 10,0,18,64,19,80,18,144,19,33,18,113,4,145,19,18,18,130,22,67,17,83,17,68,21,84,18,21,18,69,17,85,20,101,19,117,18,38,13,134,4,150,6,7,19,151    //Level item data 
    .byte $ff  
    .text "AMOK"    //Author
    .byte $00
    .byte 40    //Moves

level_87:
    .byte 0,0,60,36,32,32,36,60,0,128    //Level wall data 
    .byte 19,0,3,48,3,64,3,80,3,96,3,112,16,128,18,144,4,1,4,145,4,2,4,146,4,3,4,131,4,147,4,4,19,52,4,148,4,5,18,133,4,149,4,6,17,134,20,150,10,23,3,39,3,55,3,71,3,87,3,103,3,119,22,135    //Level item data 
    .byte $ff  
    .text "TRAPPED"    //Author
    .byte $00
    .byte 41    //Moves

level_88:
    .byte 0,126,66,102,66,66,102,66,126,0    //Level wall data 
    .byte 17,34,7,66,18,82,11,114,18,35,19,83,17,115,19,116,21,37,22,117    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 42    //Moves

level_89:
    .byte 255,132,144,145,181,128,246,132,132,144    //Level wall data 
    .byte 18,16,18,32,11,82,3,51,20,67,17,83,22,99,3,115,16,84,19,149,19,118,19,134,19,150    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 43    //Moves

level_90:
    .byte 0,0,15,8,8,8,24,8,8,104    //Level wall data 
    .byte 17,0,17,16,19,48,19,64,19,112,19,128,4,144,16,1,12,17,4,49,19,97,18,113,3,129,4,145,18,50,18,66,18,98,19,114,4,146,19,84,18,116,3,132,20,148,19,53,2,69,18,133,2,54,19,70,2,102,18,134,18,7,18,23,2,55,19,71,19,87,4,103,18,119,3,135,22,151    //Level item data 
    .byte $ff  
    .text "ELDRITCH"    //Author
    .byte $00
    .byte 43    //Moves

level_91:
    .byte 64,126,0,0,8,16,0,0,126,2    //Level wall data 
    .byte 18,0,3,128,21,144,19,1,19,2,18,146,19,3,17,83,8,147,19,4,17,68,18,148,11,5,19,149,19,150,22,7    //Level item data 
    .byte $ff  
    .text "WAULOK"    //Author
    .byte $00
    .byte 44    //Moves

level_92:
    .byte 200,8,0,252,28,30,4,32,9,9    //Level wall data 
    .byte 19,16,18,64,19,129,10,2,5,18,22,114,16,115,18,20,21,37,18,69,19,101,17,86,20,118,18,134,19,150,17,23,17,39,19,71,18,103    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 44    //Moves

level_93:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,96,17,112,17,128,17,144,16,17,16,49,16,81,16,113,16,145,16,2,16,34,16,66,16,98,16,130,21,19,21,51,21,83,21,115,21,147,20,4,20,36,20,68,20,100,20,132,7,21,7,53,7,85,7,117,7,149,7,6,7,38,7,70,7,102,7,134,17,7,17,23,17,39,17,55    //Level item data 
    .byte $ff  
    .text "CHECKERS"    //Author
    .byte $00
    .byte 45    //Moves

level_94:
    .byte 0,56,68,130,130,130,174,68,0,0    //Level wall data 
    .byte 2,84,19,6,19,22,17,70,16,86,18,102,18,7,18,23,20,39    //Level item data 
    .byte $ff  
    .text "PACMAN"    //Author
    .byte $00
    .byte 49    //Moves

level_95:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,0,17,16,17,32,17,48,16,80,20,96,12,128,22,144,19,17,18,33,6,3,18,147,21,4,19,148,15,23,20,39,18,87,19,103,18,135,19,151    //Level item data 
    .byte $ff  
    .text "FURROY"    //Author
    .byte $00
    .byte 50    //Moves

level_96:
    .byte 0,0,0,0,0,0,0,64,0,136    //Level wall data 
    .byte 19,0,19,112,18,128,19,17,18,97,19,34,18,82,19,51,22,67,20,83,21,99,22,115,18,52,13,68,2,132,18,37,10,53,19,133,18,22,5,38,18,7,9,23,2,71,17,135    //Level item data 
    .byte $ff  
    .text "AMOK"    //Author
    .byte $00
    .byte 50    //Moves

level_97:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 2,16,19,96,2,112,20,144,19,17,3,33,2,65,3,81,2,97,2,129,2,66,18,98,3,114,4,146,22,3,2,19,4,35,2,99,4,115,19,147,2,4,3,20,2,36,2,68,19,100,2,116,2,148,2,69,3,85,2,101,2,22,17,54,4,70,3,134,18,150,15,7,2,55,3,71,17,87,2,119,9,151    //Level item data 
    .byte $ff  
    .text "JUMBLE"    //Author
    .byte $00
    .byte 50    //Moves

level_98:
    .byte 126,0,0,0,0,0,0,0,0,126    //Level wall data 
    .byte 16,0,17,64,17,80,20,144,18,17,19,129,18,34,19,114,18,51,19,99,18,68,19,84,11,7,22,151    //Level item data 
    .byte $ff  
    .text "BOING"    //Author
    .byte $00
    .byte 53    //Moves

level_99:
    .byte 255,1,189,133,181,181,165,189,129,255    //Level wall data 
    .byte 15,129,19,51,18,67,18,83,19,99,18,52,20,100,19,53,17,134    //Level item data 
    .byte $ff  
    .text "PEWPEW"    //Author
    .byte $00
    .byte 54    //Moves

level_100:
    .byte 17,85,85,69,85,69,85,20,85,69    //Level wall data 
    .byte 22,112,18,1,18,145,19,3,19,147,17,52,17,84,18,5,18,149,19,7,19,103,3,119,9,135,17,151    //Level item data 
    .byte $ff  
    .text "AKMAFIN"    //Author
    .byte $00
    .byte 62    //Moves

level_101:
    .byte 0,12,18,129,129,129,18,12,0,0    //Level wall data 
    .byte 17,0,19,32,18,96,19,144,12,50,16,82,4,53,4,85,18,6,19,150,20,7,22,151    //Level item data 
    .byte $ff  
    .text "SKULL"    //Author
    .byte $00
    .byte 67    //Moves

level_102:
    .byte 0,0,0,128,0,0,0,0,0,8    //Level wall data 
    .byte 3,132,20,148,4,70,21,71,17,87,6,103,16,119,18,135,17,151    //Level item data 
    .byte $ff  
    .text "BRUTAL"    //Author
    .byte $00
    .byte 69    //Moves

level_103:
    .byte 0,16,16,16,16,56,16,0,0,0    //Level wall data 
    .byte 6,64,9,80,18,49,18,65,18,81,18,97,18,113,19,66,19,82,19,98,20,67,22,99,4,116,4,132,17,53,21,69,20,101,17,117,15,71,15,87    //Level item data 
    .byte $ff  
    .text "SHALLAN"    //Author
    .byte $00
    .byte 70    //Moves

level_104:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 8,32,16,48,21,128,20,113,17,129,4,34,17,114,4,130,22,19,4,51,4,115,4,20,18,52,3,84,19,116,18,37,19,133,18,22,3,86,9,102,17,7    //Level item data 
    .byte $ff  
    .text "AMOK"    //Author
    .byte $00
    .byte 70    //Moves

level_105:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 17,0,17,16,22,32,14,64,9,128,20,144,17,1,17,17,19,50,18,98,2,67,2,83,2,68,2,84,18,53,19,101,7,7,21,39,21,119,7,151    //Level item data 
    .byte $ff  
    .text "FML"    //Author
    .byte $00
    .byte 74    //Moves

level_106:
    .byte 0,0,0,0,231,231,0,0,0,0    //Level wall data 
    .byte 19,0,22,48,12,96,18,144,17,67,3,83,3,68,17,84,18,7,15,55,20,103,19,151    //Level item data 
    .byte $ff  
    .text "CRISCROS"    //Author
    .byte $00
    .byte 83    //Moves

level_107:
    .byte 0,0,0,0,0,0,0,0,0,129    //Level wall data 
    .byte 12,0,8,16,16,32,8,48,16,64,12,80,8,96,12,112,16,128,17,22,17,70,17,118,20,7,22,23,21,39,22,55,20,71,21,87,22,103,20,119,21,135    //Level item data 
    .byte $ff  
    .text "TEARS"    //Author
    .byte $00
    .byte 135    //Moves

level_108:
    .byte 64,0,64,0,0,0,0,0,0,2    //Level wall data 
    .byte 2,64,17,97,12,2,22,146,21,3,2,19,19,35,4,51,3,67,2,83,4,115,3,131,2,147,19,4,19,20,18,132,19,148,18,5,4,21,5,37,2,53,5,69,4,85,3,101,2,117,4,149,20,22,4,118,18,7,13,103,3,135,17,151    //Level item data 
    .byte $ff  
    .text "MRG8472"    //Author
    .byte $00
    .byte 154    //Moves

level_109:
    .byte 0,0,0,0,0,0,0,0,0,0    //Level wall data 
    .byte 19,33,13,97,12,129,19,50,17,82,18,98,2,51,21,67,2,83,22,99,2,115,19,84,19,132,20,37,8,101,11,54,22,86,17,102,18,71,19,103,17,119    //Level item data 
    .byte $ff  
    .text "AMOK"    //Author
    .byte $00
    .byte 168    //Moves

