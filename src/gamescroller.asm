GAMESCROLLER: {

		hscroll:
			.byte $07
		colorIndex:
			.byte $00

		scrollerColorsIntro:
			.byte $0b,$0c,$0f
			.fill 33, $01
			.byte $0f,$0c,$0b, $00

		scrollerColorsPractice:
			.byte $02,$0a,$0f
			.fill 33, $01
			.byte $0f,$0a,$02, $00

		scrollerColors:
			.byte $06,$0e,$03
			.fill 33, $01
			.byte $03,$0e,$06, $00

			.byte $01,$03,$0e,$06,$00,$06,$0e,$03
			.fill 8, $01
			.byte $01,$0d,$05,$0b,$00,$0b,$05,$0d 
			.fill 8, $01
			.byte $01,$0f,$0a,$02,$00,$02,$0a,$0f
			.fill 8, $01
			.byte $01,$07,$08,$09,$00,$09,$08,$07
			.fill 8, $01

		scrollTextNormal:
			.encoding "screencode_upper"
			.text "NORMAL MODE"
			.text " --- "
			.text "PRESS SPACE TO RESTART LEVEL"
			.text " --- "
			.text "PRESS RUNSTOP TO QUIT TO MENU"
			.text " --- "
			.byte $00

		scrollTextPractice:
			.encoding "screencode_upper"
			.text "PRACTICE MODE"
			.text " --- "
			.text "PRESS SPACE TO RESTART LEVEL"
			.text " --- "
			.text "PRESS RETURN TO SKIP LEVEL"
			.text " --- "
			.text "PRESS RUNSTOP TO QUIT TO MENU"
			.text " --- "
			.byte $00

		scrollTextIntro:
			.encoding "screencode_upper"
			.text "LUMA --- A PUZZLE GAME FOR THE C64 WRITTEN FOR A CHARITY GAME DEV"
			.text "STREAM ON TWITCH FOR THE EXTRA LIFE CHARITY --- CONCEPT AND CODE BY SHALLAN --- GRAPHICS BY HELPCOMPUTER, SHALLAN "
			.text "--- MUSIC BY RICHMONDMIKE --- SOUND BY STEPZ --- @2020 SHALLAN"
			.text " --- "
			.byte $00

		Init: {
				jsr clearScrollArea

				lda #$07
				sta hscroll


			RESET:
				lda INTRO.isIntro
				bne !Intro+
				lda GAME.Settings.gameMode
				cmp #GAME.MODE_NORMAL
				bne !Practice+

			!Normal:
				lda #<scrollTextNormal
				sta ZP.gameScrollPointer + 0
				lda #>scrollTextNormal
				sta ZP.gameScrollPointer + 1
				rts

			!Practice:
				lda #<scrollTextPractice
				sta ZP.gameScrollPointer + 0
				lda #>scrollTextPractice
				sta ZP.gameScrollPointer + 1
				rts

			!Intro:
				lda #<scrollTextIntro
				sta ZP.gameScrollPointer + 0
				lda #>scrollTextIntro
				sta ZP.gameScrollPointer + 1
				rts				
		}

		clearScrollArea: {
			// rts
				ldx #$00
			!:
				lda #$00
				sta SCREEN_RAM + $18 * $28, x

				lda INTRO.isIntro
				bne !Intro+
				lda GAME.Settings.gameMode
				beq !Normal+
				lda scrollerColorsPractice, x
				jmp !Set+
			!Intro:
				lda scrollerColorsIntro, x
				jmp !Set+
			!Normal:
				lda scrollerColors, x
			!Set:
				sta COLOR_RAM + $18 * $28, x				
				inx
				cpx #$28
				bne !-
				rts
		}

		scrollTextArea: {
				ldx #$00
			!:
				lda SCREEN_RAM + $18 * $28 + 1, x
				sta SCREEN_RAM + $18 * $28, x
				inx
				cpx #$27
				bne !-

			!:
				ldy #$00
				lda (ZP.gameScrollPointer), y
				bne !+
				jsr Init.RESET
				jmp !-
			!:
				clc
				adc #$70
				sta SCREEN_RAM + $18 * $28 + $27

				lda ZP.gameScrollPointer + 0
				clc 
				adc #$01
				sta ZP.gameScrollPointer + 0
				lda ZP.gameScrollPointer + 1
				adc #$00
				sta ZP.gameScrollPointer + 1

				rts	
		}	

		colorScroll: {
			// 	lda IRQ.Timer
			// 	and #$03
			// 	beq !+
			// 	rts
			// !:
				dec colorIndex
				
				ldx #$00
				ldy colorIndex
			!:
				tya
				and #$3f
				tay 
				lda scrollerColors, y
				sta COLOR_RAM + $18 * $28 + $14, x
				iny
				inx
				cpx #$14
				bne !-

				ldx #$13
				ldy colorIndex
			!:
				tya
				and #$3f
				tay 
				lda scrollerColors, y
				sta COLOR_RAM + $18 * $28, x
				iny
				dex
				bpl !-


				rts
		}

		Update: {
			// 	lda IRQ.Timer
			// 	and #$01
			// 	beq !+
			// 	rts
			// !:			
				ldx hscroll
				dex
				bpl !+

					jsr scrollTextArea

				ldx #$07
			!:
				stx hscroll

				lda INTRO.isIntro
				beq !+
				jsr colorScroll
			!:
				rts
		}
}