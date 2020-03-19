COMPLETION: {
	isCompletion:
		.byte $00
	level:
		.byte $00
	blankRows:
		.byte $09
	transitionColorList:
		.byte $0a,$0d,$0e
	transitionColorIndex:
		.byte $00
	Start: {
			lda #$01
			sta isCompletion
			jsr Random.get
			and #$7f
			sta level
				
			lda #<RowTexts
			sta FetchNewRow.ROWTEXTLOOKUP + 1
			lda #>RowTexts
			sta FetchNewRow.ROWTEXTLOOKUP + 2
			lda #$09
			sta blankRows
			
			jsr InitSprites

			lda #$01
			sta transitionColorIndex
			lda #$0a
			sta TransitionColor
			lda #$01
			sta TransitionTimer
			jsr ColorTransitionInit

			

		NextLevel:
			lda #$00
			ldx #$09		//Force mc in every square
			jsr ClearScreen
			jsr CompleteHud

			// jsr HUD.Init
			lda level
			jsr LEVEL.LoadLevel
			jsr LEVEL.DrawLevel	


		ScrollTime:
			//WAIT FOR SAME LINE
			lda $d011
			bmi *-3
			lda #$80
			cmp $d012
			bcc *-3

			lda FetchRowNow
			beq !skipfetch+
			jsr FetchNewRow
		!skipfetch:

			// lda IRQ.Timer
			// and #$01
			// bne !skipcolorupdate+
			jsr ColorTransitionOnUpdate
		!skipcolorupdate:

			lda $d011
			bpl *-3

			lda blankRows
			bne !skip+
			lda isTransitioning
			bne !skip+
			lda TransitionColor
			beq !skip+
			jmp Exit 
		!skip:


		CheckForRunStop: {
				lda #%11111111	//Enable keyboard handling
				sta $dc02
				lda #%00000000	
				sta $dc03

				lda #%01111111  //ROW mask
				sta $dc00
				lda $dc01
				cmp #$ff
				bne !+

				lda #$00
				sta DebounceKeys1
				jmp !ExitKeys+

			!:
				ldx DebounceKeys1
				bne !ExitKeys+
				inc DebounceKeys1

				and #$80
				bne !ExitKeys+
				jmp Exit


			!ExitKeys:
				lda #%00000000	//Restore joy control
				sta $dc02
		}


			jmp ScrollTime		
	}
	DebounceKeys1:
		.byte $00

	Exit: {
			lda #$1b
			sta $d011
			lda #$00
			sta isCompletion
			jmp INTRO.Start
	}
			
	InitSprites: {
			lda #$ff
			sta $d015
			lda #$00
			sta $d01c
			.for(var i=0; i<6; i++) {
				lda #$01
				sta $d027 + i
				lda #[$48 + i * $18]
				sta $d000 + i * 2
			}	

			lda #$00
			ldx #$00
		!:
			sta $f000, x
			sta $f100, x
			sta $f200, x
			sta $f300, x
			sta $f400, x
			sta $f500, x
			sta $f600, x
			sta $f700, x
			sta $f800, x
			sta $f900, x
			sta $fa00, x
			sta $fb00, x
			sta $fc00, x
			sta $fd00, x
			dex
			bne !-

			rts
	}
	SpriteYpos:
		.byte $30, $30
	RowCounter:
		.byte $00
	SpriteSplitIndex:
		.byte $00, $00
	SpriteRowIndexes:
		.byte $c0, $c6, $cc, $d2, $d8, $de, $e4, $ea, $f0
	FetchRowNow:
		.byte $00



	StartSpriteSplitIRQ: {
			lda #<SpriteSplitIRQ
			sta $fffe
			lda #>SpriteSplitIRQ
			sta $ffff

			lda SpriteYpos
			sta $d012

			lda $d011
			and #%11110111
			sta $d011

			lda #$09
			sta RowCounter
			rts
	}

	SpriteSplitIRQ: {
		saveState()

			// .break
			ldx SpriteSplitIndex
			ldy SpriteRowIndexes, x
			lda SpriteYpos
			clc
			adc #$03

			sta $d001
			sta $d003
			sta $d005
			sta $d007
			sta $d009
			sta $d00b

			sty SPRITE_POINTER + 0
			iny
			sty SPRITE_POINTER + 1
			iny
			sty SPRITE_POINTER + 2
			iny
			sty SPRITE_POINTER + 3
			iny
			sty SPRITE_POINTER + 4
			iny
			sty SPRITE_POINTER + 5

			ldx SpriteSplitIndex + 0
			inx
			cpx #$09
			bne !+
			ldx #$00
		!:
			stx SpriteSplitIndex + 0 
			dec RowCounter
			beq !End+


			lda SpriteYpos
			clc 
			adc #$18
			sta SpriteYpos
			sta $d012


		!skip:
			jmp !Exit+



		!End:
			lda IRQ.Timer
			and #$03
			bne !+
			dec SpriteYpos + 1
		!:
			lda SpriteYpos + 1
			cmp #$18
			bne !skip+

			ldx SpriteSplitIndex + 1
			inx
			cpx #$09
			bne !+
			ldx #$00
		!:
			stx SpriteSplitIndex + 1


			inc FetchRowNow

			lda #$30
		!skip:
			sta SpriteYpos + 1
			sta SpriteYpos + 0



			ldx SpriteSplitIndex + 1
			stx SpriteSplitIndex + 0

			lda #<IRQ.MainIRQ
			sta $fffe
			lda #>IRQ.MainIRQ
			sta $ffff



			lda #$fc
			sta $d012

		!Exit:
			restoreState()
			asl $d019
			rti			
	}

	CompleteHud: {
			lda #$08
			ldx #$00
		!:	
			sta $d800, x
			sta $d900, x
			sta $da00, x
			sta $db00, x
			inx
			bne !-



			lda #<[SCREEN_RAM + 30]
			sta HudMod + 1
			lda #>[SCREEN_RAM + 30]
			sta HudMod + 2
			lda #<[COLOR_RAM + 30]
			sta ColMod + 1
			lda #>[COLOR_RAM + 30]
			sta ColMod + 2



			ldx #$00
			ldy #$00
		!loop:	
			lda COMP_HUD_MAP, x
		HudMod:
			sta $BEEF, y
			stx ZP.HudCharTemp
			tax
			lda CHAR_COLORS, x
			ldx ZP.HudCharTemp
		ColMod:
			sta $BEEF, y

			iny
			cpy #$0a
			bne !+

			ldy #$00
			lda HudMod + 1
			clc
			adc #$28
			sta HudMod + 1
			sta ColMod + 1
			lda HudMod + 2
			adc #$00
			sta HudMod + 2
			clc
			adc #>[COLOR_RAM - SCREEN_RAM]
			sta ColMod + 2
		!:
			inx
			cpx #$f0
			bne !loop-

	
			rts
	}


	SpriteMemLSB:
		.fill 9, <[$f000 + 64 * 6 * i]
	SpriteMemMSB:
		.fill 9, >[$f000 + 64 * 6 * i]

	SpriteCharOffsets:
		.byte $09,$0c,$0f,$12,$15,$18
		.byte $0a,$0d,$10,$13,$16,$19
		.byte $0b,$0e,$11,$14,$17,$1a

		.byte $09,$0c,$0f,$12,$15,$18
		.byte $0a,$0d,$10,$13,$16,$19
		.byte $0b,$0e,$11,$14,$17,$1a

		.byte $2d,$30,$33,$36,$39,$3c
		.byte $2e,$31,$34,$37,$3a,$3d
		.byte $2f,$32,$35,$38,$3b,$3e

		.byte $2d,$30,$33,$36,$39,$3c
		.byte $2e,$31,$34,$37,$3a,$3d
		.byte $2f,$32,$35,$38,$3b,$3e

		.byte $ff

	FetchNewRow: {
		// inc $d020

			lda #$00
			sta FetchRowNow

			lda SpriteSplitIndex + 1
			clc
			adc #$08
			cmp #$09
			bcc !+
			sbc #$09
		!:
			
			tay
			lda SpriteMemLSB, y
			sta ZP.complSpriteData + 0
			lda SpriteMemMSB, y
			sta ZP.complSpriteData + 1

			
			// rts

			//TESTING
			ldx #$00
		!LOOP:
		ROWTEXTLOOKUP:
			ldy RowTexts, x
			bmi !Finished+

			lda CharLookupsLSB, y
			sta ZP.complFontData + 0
			lda CharLookupsMSB, y
			sta ZP.complFontData + 1

			stx ZP.complTemp
			
			lda Offsets, x
			tax
			ldy #$01
		!:
			lda (ZP.complFontData), y
			sty ZP.complTemp2
			ldy SpriteCharOffsets, x
			sta (ZP.complSpriteData), y
			inx
			ldy ZP.complTemp2
			iny
			cpy #$07
			bne !-


			ldx ZP.complTemp
			inx
			lda AdvanceSprite, x
			beq !+
			cmp #$02
			bne !Normal+
			// .break
			sec
			lda ZP.complSpriteData + 0
			sbc #$40	
			sta ZP.complSpriteData + 0	
			lda ZP.complSpriteData + 1
			sbc #$01
			sta ZP.complSpriteData + 1			
			jmp !+
		!Normal:
			clc
			lda ZP.complSpriteData + 0
			adc #$40	
			sta ZP.complSpriteData + 0	
			lda ZP.complSpriteData + 1
			adc #$00
			sta ZP.complSpriteData + 1			
		!:
			cpx #$24
			bne !LOOP-



			lda ROWTEXTLOOKUP + 1
			clc
			adc #$24
			sta ROWTEXTLOOKUP + 1
			lda ROWTEXTLOOKUP + 2
			adc #$00
			sta ROWTEXTLOOKUP + 2
			rts



		!Finished:
			ldx blankRows
			dex
			bpl !+
			ldx #$00
		!:
			stx blankRows
			ldx #$06
		!Loop:
			lda #$00
			ldy #$3e
		!:
			sta (ZP.complSpriteData), y
			dey
			bpl !-
			dex
			beq !+

			clc
			lda ZP.complSpriteData + 0
			adc #$40	
			sta ZP.complSpriteData + 0	
			lda ZP.complSpriteData + 1
			adc #$00
			sta ZP.complSpriteData + 1	
			jmp !Loop-	

		!:
			rts
	}


	ColTransition1Start:
		.byte $f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff
		.byte $ff,$fe,$fd,$fc,$fb,$fa,$f9,$f8,$f7,$f6,$f5,$f4
	ColTransition2Start:
		.byte $29,$28,$27,$26,$25,$24,$23,$22,$21,$20,$1f,$1e
		.byte $1e,$1f,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29
	ColTransitionIndexes:
		.fill 24,0	
	isTransitioning:
		.byte $00
	TransitionColor:
			.byte $08
	TransitionTimer:
			.byte $ff

	ColorTransitionInit: {
			ldx TransitionColor
			beq !Backwards+

		!Forwards:
			ldx #$17
		!:
			lda ColTransition1Start, x
			sta ColTransitionIndexes, x
			dex
			bpl !-

			rts

		!Backwards:
			ldx #$17
		!:
			lda ColTransition2Start, x
			sta ColTransitionIndexes, x
			dex
			bpl !-

			rts
	}


	ColorTransitionOnUpdate: {


			lda isTransitioning
			bne !DoTransition+
				ldx TransitionTimer
				beq !DoTransition+
				dex
				stx TransitionTimer
				bne !+
				jsr ColorTransitionInit
			!:
				rts

		!DoTransition:
			lda #$01
			sta isTransitioning


			ldx #$17
		!:
			lda TransitionColor
			beq !Back+
		!Fwd:
			ldy ColTransitionIndexes, x
			iny
			tya
			sta ColTransitionIndexes, x
			bmi !skip+
			cpy #$1e
			bcs !skip+
			jmp !Done+
		!Back:
			ldy ColTransitionIndexes, x
			dey
			tya
			sta ColTransitionIndexes, x
			bmi !skip+
			cpy #$1e
			bcs !skip+
		!Done:


			lda TABLES.ScreenLSB, x
			sta ZP.colTransition + 0
			lda TABLES.ColorMSB, x
			sta ZP.colTransition + 1

			lda TransitionColor
			sta (ZP.colTransition), y

		!skip:
			dex
			bpl !-

			lda TransitionColor
			beq !Back+
		!Fwd:
			cpy #$1e
			bne !end+
			jmp !Done+
		!Back:
			cpy #$ff
			bne !end+



			jsr Random.get
			and #$7f
			sta level
			lda level
			jsr LEVEL.LoadLevel
			jsr LEVEL.DrawLevel	
		!Done:



			lda #$00
			sta isTransitioning
			ldx #$05
			lda TransitionColor
			beq !Set+
		!clear:
			lda #$00
			jmp !+
		!Set:
			ldy transitionColorIndex
			iny 
			cpy #$03
			bne !noreset+
			ldy #$00
		!noreset:
			sty transitionColorIndex
			lda transitionColorList, y
		!:
			sta TransitionColor
		

			bne !skip+
			ldx #$80
		!skip:
			stx TransitionTimer
		!end:
			rts	
	}


	Offsets:
		.byte 0,6,12,18,24,30
		.byte 0,6,12,18,24,30
		.byte 0,6,12,18,24,30
		.byte 36,42,48,54,60,66
		.byte 36,42,48,54,60,66
		.byte 36,42,48,54,60,66
	AdvanceSprite:
		.byte 0,0,0,1,0,0,1,0,0
		.byte 1,0,0,1,0,0,1,0,0
		.byte 2,0,0,1,0,0,1,0,0
		.byte 1,0,0,1,0,0,1,0,0

		.byte 2,0,0,1,0,0,1,0,0
		.byte 1,0,0,1,0,0,1,0,0
		.byte 2,0,0,1,0,0,1,0,0
		.byte 1,0,0,1,0,0,1,0,0

	CharLookupsLSB:
		.fill 64, <[$cb80 + i * 8]
	CharLookupsMSB:
		.fill 64, >[$cb80 + i * 8]


	RowTexts:
		.encoding "screencode_upper"
		.text "CONGRATULATIONS!!!"
		.text "                  "
		.text " YOU HAVE MANAGED "
		.text " TO SOLVE ALL THE "
		.text " PUZZLES FOUND IN "
		.text " LUMA...          "
		.text "                  "
		.text "WE KNEW YOU COULD!"
		.text "                  "
		.text "                  "
		.text "LUMA WAS MADE ON A"
		.text "TWITCH STREAM FOR "
		.text "THE MOST EXCELLENT"
		.text "EXTRA LIFE CHARITY"
		.text "WHO HELP SUPPORT  "
		.text "KIDS IN HOSPITALS "
		.text "ACROSS THE U.S.A. "
		.text "                  "
		.text "APPROXIMATELY 3/4 "
		.text "OF THE GAME WAS   "
		.text "MADE ON STREAM AND"
		.text "THE REMAINDER WAS "
		.text "COMPLETED DURING  "
		.text "THE NEXT WEEK.    "
		.text "GRAPHICS, MUSIC   "
		.text "AND LEVEL DESIGN  "
		.text "WERE ALSO DONE BY "
		.text "VIEWERS OF THE    "
		.text "STREAM.           "
		.text "                  "
		.text "IN TOTAL, VIEWERS "
		.text "DONATED $1220.69  "
		.text "IN THE 16 HOURS!  "
		.text "                  "
		.text "AMAZING WORK GUYS!"
		.text "                  "
		.text "ALL TWITCH REVENUE"
		.text "FROM THE STREAM   "
		.text "AND UP TO THE NEXT"
		.text "PAYOUT WILL ALSO  "
		.text "BE DONATED, AND   "
		.text "ALL PROCEEDS FROM "
		.text "ITCH.IO WILL GO TO"
		.text "EXTRA LIFE ALSO.  "
		.text "                  "
		.text "                  "
		.text "                  "
		.text "                  "
		.text "AND NOW, CREDITS: "
		.text "                  "
		.text "                  "
		.text "CONCEPT AND CODE  "
		.text "  SHALLAN         "
		.text "                  "
		.text "GRAPHICS          "
		.text "  HELPCOMPUTER    "
		.text "  SHALLAN         "
		.text "                  "
		.text "MUSIC             "
		.text "  RICHMONDMIKE    "
		.text "                  "
		.text "SOUND             "
		.text "  STEPZ           "
		.text "                  "
		.text "TESTING           "
		.text "  CHISWICKED      "
		.text "  COLT45RPM       "
		.text "  MRG8472         "
		.text "  STEPZ           "
		.text "                  "
		.text "LEVEL DESIGN      "
		.text "  AIRJURI         "
		.text "  AKMAFIN         "
		.text "  AMOK            "
		.text "  CHISWICKED      "
		.text "  ELDRITCH        "
		.text "  FURROY          "
		.text "  MRG8472         "
		.text "  OLDSKOOLCODER   "
		.text "  PHAZE101        "
		.text "  RICHMONDMIKE    "
		.text "  SHALLAN         "
		.text "  SPIRITHOUND     "
		.text "  STEPZ           "
		.text "  VOID            "
		.text "  WAULOK          "
		.text "  WIZARDNJ        "
		.text "  ZOOPERDAN       "
		.text "                  "
		.text "DONATORS          "
		.text "  WAULOK          "
		.text "  JAMES           "
		.text "  COLT45RPM       "
		.text "  WIZARDNJ        "
		.text "  JAMES           "
		.text "  ELDRITCH        "
		.text "  ANDYMAGICKNIGHT "
		.text "  CHISWICKED      "
		.text "  HAYESMAKER      "
		.text "  STOKER          "
		.text "  OLDSKOOLCODER   "
		.text "  BAGOFPOTATOES   "
		.text "  FURROY          "
		.text "  JOST            "
		.text "  MRKOLA          "
		.text "  STACBATS        "
		.text "  ZOOPERDAN       "
		.text "  AMOK            "
		.text "  RICHMONDMIKE    "
		.text "  STEPZ           "
		.text "  SEUCK           "
		.text "  CARLOS          "
		.text "  PODULATOR       "
		.text "  MITSOYAMA       "
		.text "  ZENDARICK       "
		.text "  YOSI TAGURI     "
		.text "  DRAGAN          "
		.text "                  "
		.text "                  "
		.text "                  "
		.text "                  "
		.text "A HUGE THANK YOU  "
		.text "TO EVERYONE WHO   "
		.text "DONATED OR HELPED "
		.text "BY CONTRIBUTING   "
		.text "ASSETS, LEVELS OR "
		.text "TIME, TO HELP MAKE"
		.text "THIS GAME!        "
		.text "                  "
		.text "I HOPE YOU ENJOYED"
		.text "IT, AND AM LOOKING"
		.text "FORWARD TO THE    "
		.text "NEXT GAME!!!      "
		.text "                  "
		.text "                  "
		.text "                  "
		.text "UNTIL NEXT TIME..."
		.text "                  "
		.text "SHALLAN           "
		.text "                  "

		.byte $FF
}







