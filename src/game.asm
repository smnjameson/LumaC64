GAME: {
	.label MODE_NORMAL = $00
	.label MODE_PRACTICE = $01

	Settings: {
		currentLevel: 	.byte $00
		isCompleted: 	.byte $00
		gameMode:		.byte $00
		completeSoundOff:	.byte $00
		musicOn:		.byte $01
	}

	NextChannel:
		.byte $00, $00
	GetNextChannel: {
		stx NextChannel
		ldx Settings.musicOn
		beq !+
		ldx #$0e
		rts
	!:
		sta NextChannel + 1
		txa
		clc 
		adc #$0e
		tax
		cpx #$0f
		bcc !+
		ldx #$00
	!:
		stx NextChannel
		lda NextChannel + 1
		rts
	}

	*=*"START"
	.var start1 = LoadBinary("assets/begin.bin");
	Start01:
		.fill start1.getSize(), start1.get(i) 	



	Start: {
		ldx #$ff 
		txs
		lda #$7b
		sta $d011

		jsr CONTROL.Init
		jsr LASERS.Init
		jsr MESSAGES.Init
		jsr GAMESCROLLER.Init


		lda #$00
		sta Settings.isCompleted
		sta Settings.completeSoundOff
		lda #%00000000
		sta $d404
		sta $d40b
		sta $d412
			

		lda Settings.currentLevel
		cmp #$80	
		bne !+
		lda Settings.gameMode
		cmp #MODE_PRACTICE
		beq !Reset+
		jmp COMPLETION.Start
	!Reset:
		lda #$00
		sta Settings.currentLevel
	!:
		jsr LEVEL.LoadLevel
		jsr LEVEL.DrawLevel

		lda Settings.musicOn
		bne !+
		lda #$03
		jsr $1000
		// ldy #>Start01
	 //    lda #<Start01
	 //    ldx #00
	 //    jsr GAME.GetNextChannel
	 //   	jsr $1006
		jmp !musicdone+
	!:
		lda $10b8
		beq !musicdone+
		lda #$00
		jsr $1000

	!musicdone:



				lda Settings.currentLevel
			!Level1:
				bne !Level2+
				lda #$00
				jsr MESSAGES.addTutorial
				jmp !DoneMessages+

			!Level2:
				cmp #$02
				bne !Level3+
				lda #$04
				jsr MESSAGES.addTutorial
				jmp !DoneMessages+

			!Level3:
				cmp #$05
				bne !Level4+
				lda #$05
				jsr MESSAGES.addTutorial
				jmp !DoneMessages+

			!Level4:
				cmp #$08
				bne !Level5+
				lda #$06
				jsr MESSAGES.addTutorial
				jmp !DoneMessages+
			
			!Level5:
				cmp #$01
				bne !Level6+
				lda #$07
				jsr MESSAGES.addTutorial
				jmp !DoneMessages+
			!Level6:

				cmp #$03
				bne !Level7+
				lda #$09
				jsr MESSAGES.addTutorial
				jmp !DoneMessages+
			!Level7:


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
			jsr GAMESCROLLER.Update
			// lda #$00
			// sta ZP.DrawNoColor

			//Stop complete music repeat
			lda Settings.completeSoundOff
			beq !+
			dec Settings.completeSoundOff
			bne !+
			lda #$03
			jsr $1000
		!:


		jmp !Loop-
	}

}