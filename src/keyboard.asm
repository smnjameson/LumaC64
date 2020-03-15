KEYBOARD:{
	DebounceKeys:
			.byte $00
	Update: {
			lda #%11111111	//Enable keyboard handling
			sta $dc02
			lda #%00000000	
			sta $dc03

			lda #%11111110  //F Keys mask
			sta $dc00
			lda $dc01
			cmp #$ff
			bne !+

			lda #$00
			sta DebounceKeys

		!Exit:
			lda #%00000000	//Restore joy control
			sta $dc02
			rts

		!:
			lda DebounceKeys
			bne !Exit-
			
			inc DebounceKeys
			lsr
			lsr
			bcs !Exit-
			inc GAME.Settings.currentLevel
			jsr GAME.Start
			rts
	}
}