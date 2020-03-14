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


