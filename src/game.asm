GAME: {
	Settings: {
		currentLevel: .byte $00
		isCompleted: .byte $00
	}

	Start: {
		lda #$7b
		sta $d011

		lda Settings.currentLevel
		bne !+
			lda #$00
			ldx #$09		//Force mc in every square
			jsr ClearScreen
			jsr HUD.Init
	!:
		jsr CONTROL.Init
		jsr LASERS.Init
		jsr MESSAGES.Init



		lda #$00
		sta Settings.isCompleted

		lda Settings.currentLevel
		jsr LEVEL.LoadLevel
		jsr LEVEL.DrawLevel



				lda Settings.currentLevel
			!Level1:
				bne !Level2+
				lda #$02
				sta MESSAGES.messageDisplayed
				lda #$00
				sta MESSAGES.messageYOffset
				jmp !DoneMessages+

			!Level2:
				cmp #$01
				bne !Level3+
				lda #$06
				sta MESSAGES.messageDisplayed
				lda #$00
				sta MESSAGES.messageYOffset
				jmp !DoneMessages+

			!Level3:
				cmp #$02
				bne !Level4+
				lda #$07
				sta MESSAGES.messageDisplayed
				lda #$00
				sta MESSAGES.messageYOffset
				jmp !DoneMessages+

			!Level4:
				cmp #$03
				bne !Level5+
				lda #$08
				sta MESSAGES.messageDisplayed
				lda #$00
				sta MESSAGES.messageYOffset
				jmp !DoneMessages+

			!Level5:

			!DoneMessages:


				//Level testing debug code
				// lda #$10
				// bit $dc00
				// bne *-3
				// bit $dc00
				// beq *-3

				// inc Settings.currentLevel
				// jmp Start

		lda #$1b
		sta $d011

	!Loop:
		lda IRQ.FrameFlag
		beq !Loop-
		lda #$00
		sta IRQ.FrameFlag

			jsr CONTROL.Update
			jsr LEVEL.Update
			jsr LASERS.Update
			jsr HUD.Update

			jsr KEYBOARD.Update

			jsr MESSAGES.Update
			// lda #$00
			// sta ZP.DrawNoColor

		jmp !Loop-
	}

}