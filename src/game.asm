GAME: {
	Settings: {
		currentLevel: .byte $00
	}
	
	Start: {
		lda #$82
		ldx #$07
		jsr ClearScreen
		inc $d020
		jmp *-3
	}
}