KEYBOARD:{
	DebounceKeys1:
			.byte $00
	DebounceKeys2:
			.byte $00
	DebounceKeys3:
			.byte $00
	DebounceKeys4:
			.byte $00

	Update: {
			lda GAME.Settings.gameMode
			beq !+
				jsr CheckForReturn
		!:
				jsr CheckForSpace
				jsr CheckForRUNSTOP

				jsr CheckForF1
			rts
	}			

	CheckForRUNSTOP: {
			lda #%11111111	//Enable keyboard handling
			sta $dc02
			lda #%00000000	
			sta $dc03

			lda #%01111111  //F Keys mask
			sta $dc00
			lda $dc01
			cmp #$ff
			bne !+

			lda #$00
			sta DebounceKeys3

		!Exit:
			lda #%00000000	//Restore joy control
			sta $dc02
			rts

		!:
			ldx DebounceKeys3
			bne !Exit-
			inc DebounceKeys3

			and #$80
			bne !Exit-
			jmp INTRO.Start
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

			jmp GAME.Start
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
			jmp GAME.Start

	}

	CheckForF1: {
			lda #%11111111	//Enable keyboard handling
			sta $dc02
			lda #%00000000	
			sta $dc03

			lda #%11111110  //SPACE Keys mask
			sta $dc00
			lda $dc01
			cmp #$ff
			bne !+

			lda #$00
			sta DebounceKeys4

		!Exit:
			lda #%00000000	//Restore joy control
			sta $dc02
			rts

		!:
			ldx DebounceKeys4
			bne !Exit-
			inc DebounceKeys4

			and #$10
			bne !Exit-
			lda GAME.Settings.musicOn
			eor #$01
			sta GAME.Settings.musicOn
			beq !MusicOff+
		!MusicOn:
			lda #$00
			jsr $1000
			jmp !Exit-
		!MusicOff:
			lda #$03
			jsr $1000
			jmp !Exit-
	}
}