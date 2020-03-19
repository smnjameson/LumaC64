COMPLETION: {
	isCompletion:
		.byte $00
	level:
		.byte $00

	Start: {
			lda #$01
			sta isCompletion
			lda #$00
			sta level
			
			jsr CompleteHud
			jsr InitSprites

		NextLevel:
			lda #$00
			ldx #$09		//Force mc in every square
			jsr ClearScreen

			// jsr HUD.Init
			lda level
			jsr LEVEL.LoadLevel
			jsr LEVEL.DrawLevel	


		ScrollTime:
			lda FetchRowNow
			beq !skip+
			lda $d011
			bmi *-3
			lda #$80
			cmp $d012
			bcc *-3
			jsr FetchNewRow
		!skip:
			jmp ScrollTime		
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
			and #$01
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
			ldy RowTexts, x
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







		// 	lda #$06
		// 	sta ZP.complTemp
		// !loop:
		// 	ldx #$23
		// !:
		// 	ldy SpriteCharOffsets, x
		// 	stx ZP.complTemp2

		// 		lda #$7e
		// 		sta (ZP.complSpriteData), y

		// 	ldx ZP.complTemp2
		// 	dex
		// 	bpl !-

		// 	dec ZP.complTemp
		// 	beq !+


		// 	clc
		// 	lda ZP.complSpriteData + 0
		// 	adc #$40	
		// 	sta ZP.complSpriteData + 0	
		// 	lda ZP.complSpriteData + 1
		// 	adc #$00
		// 	sta ZP.complSpriteData + 1	
		// 	jmp !loop-
		// !:




		// dec $d020
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
		.text "ABCDEFGHIJKLMNOPQR"
		.text "STUVWXYZ0123456789"
}







