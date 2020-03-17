IRQ: {
	FrameFlag:
			.byte $00
	Timer:
			.byte $00

	Init: {
			sei

			lda #<MainIRQ
			sta $fffe
			lda #>MainIRQ
			sta $ffff

			lda #$ff
			sta $d012
			lda $d011
			and #$7f
			sta $d011

			lda #$01
			sta $d01a

			asl $d019
			cli
			rts
	}

	MainIRQ: {
		saveState()
			inc Timer

			lda #$01
			sta FrameFlag

			jsr $1003	//Do music


			lda MESSAGES.messageDisplayed
			bmi !+
			cmp #$02
			bcc !+
			lda #<SpriteSplit1
			sta $fffe
			lda #>SpriteSplit1
			sta $ffff
			lda MESSAGES.messageY
			clc
			adc #$15
			sta $d012
		!:

		restoreState()
		asl $d019
		rti
	}

	SpriteSplit1: {
		saveState()
			
			

			lda $d012
			clc
			adc #$02
			sta $d001
			sta $d009

			
			lda MESSAGES.messageArrowX
			sta $d000
			sta $d008

			lda #$57
			sta SPRITE_POINTER + 0
			lda #$56
			sta SPRITE_POINTER + 4

			lda #<MainIRQ
			sta $fffe
			lda #>MainIRQ
			sta $ffff
			lda #$ff
			sta $d012
		!:

		restoreState()
		asl $d019
		rti
	}

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


