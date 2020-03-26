IRQ: {
	.label SCROLLER_SPLIT = $f2
	FrameFlag:
			.byte $00
	Timer:
			.byte $00
	isSparks:
			.byte $00
	Init: {
			sei

			lda #<MainIRQ
			sta $fffe
			lda #>MainIRQ
			sta $ffff

			lda #<NMI
			sta $fffa
			lda #>NMI
			sta $fffb

			lda #SCROLLER_SPLIT
			sta $d012
			lda $d011
			and #$7f
			sta $d011

			lda #$01
			sta $d01a

			asl $d019
			cli
			rts

		NMI:
			rti
	}

	MainIRQ: {
		// .break
		saveState()
			lda $d012
			cmp $d012
			bne *-3

			nop
			nop
			nop
			nop
			nop
			nop
			
			lda $d016
			and #%11100000			
			ora GAMESCROLLER.hscroll
			sta $d016


			lda #$ff
			cmp $d012
			bne *-3

			lda $d016
			and #%11111000
			ora #%00011000
			sta $d016


			inc Timer
			lda #$01
			sta FrameFlag
			jsr $1003	//Do music

			//Do spark sounds
			lda GAME.Settings.musicOn
			bne !end+
			lda GAME.Settings.isCompleted
			bne !end+
				lda isSparks
				beq !off+
			!on:
				jsr Random.get
				sta $d407
				jsr Random.get
				and #$07
				ora #$c8
				sta $d408

				lda #$00 //AD
				sta $d40c
				lda #$22 //SR
				sta $d40d

				lda $d40b
				and #%00000001
				eor #%00000001
				ora #%10000000
				sta $d40b

				lda #$00
				sta $d415
				sta $d416
				lda #$82
				sta $d417
				lda #$7f
				sta $d418

				jmp !end+
			!off:
				lda #%00001000
				sta $d40b
			!end:


			lda #SCROLLER_SPLIT
			sta $d012



			lda COMPLETION.isCompletion
			beq !+
		!skip:
			jsr COMPLETION.StartSpriteSplitIRQ
		!:



			lda INTRO.isIntro
			beq !+
		!skip:
			jsr INTRO.Irq001
		!:
		// 	lda MESSAGES.messageDisplayed
		// 	bmi !+
		// 	cmp #$02
		// 	bcc !+
		// 	lda #<SpriteSplit1
		// 	sta $fffe
		// 	lda #>SpriteSplit1
		// 	sta $ffff
		// 	lda MESSAGES.messageY
		// 	clc
		// 	adc #$15
		// 	sta $d012
		// !:
			lda $d011
			and #$7f
			sta $d011

		restoreState()
		asl $d019
		rti
	}

	// SpriteSplit1: {
	// 	saveState()
			
			

	// 		lda $d012
	// 		clc
	// 		adc #$02
	// 		sta $d001
	// 		sta $d009

			
	// 		lda MESSAGES.messageArrowX
	// 		sta $d000
	// 		sta $d008

	// 		lda #$57
	// 		sta SPRITE_POINTER + 0
	// 		lda #$56
	// 		sta SPRITE_POINTER + 4

	// 		lda #<MainIRQ
	// 		sta $fffe
	// 		lda #>MainIRQ
	// 		sta $ffff
	// 		lda #SCROLLER_SPLIT
	// 		sta $d012
	// 	!:

	// 	restoreState()
	// 	asl $d019
	// 	rti
	// }

}


.macro saveState() {
		pha
		txa 
		pha
		tya 
		pha
}

.macro restoreState() {
		pla 
		tay 
		pla 
		tax 
		pla
}


