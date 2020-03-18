KEYBOARD:{
	DebounceKeys1:
			.byte $00
	DebounceKeys2:
			.byte $00

	Update: {
			jsr CheckForReturn
			jsr CheckForSpace
			rts
	}			

	CheckForReturn: {
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
			sta DebounceKeys1

		!Exit:
			lda #%00000000	//Restore joy control
			sta $dc02
			rts

		!:
			ldx DebounceKeys1
			bne !Exit-
			inc DebounceKeys1

			and #$02
			bne !Exit-
			inc GAME.Settings.currentLevel
			jsr GAME.Start
			rts
	}

	CheckForSpace: {
			lda #%11111111	//Enable keyboard handling
			sta $dc02
			lda #%00000000	
			sta $dc03

			lda #%01111111  //SPACE Keys mask
			sta $dc00
			lda $dc01
			cmp #$ff
			bne !+

			lda #$00
			sta DebounceKeys2

		!Exit:
			lda #%00000000	//Restore joy control
			sta $dc02
			rts

		!:
			ldx DebounceKeys2
			bne !Exit-
			inc DebounceKeys2

			and #$10
			bne !Exit-
			jsr GAME.Start
			rts
	}
}