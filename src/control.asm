CONTROL: {
	.label UP = 1
	.label DN = 2
	.label LT = 4
	.label RT = 8
	.label FR = 16

	.label DEBOUNCE_TIMER = $08

	PositionX:
		.byte $00
	PositionY:
		.byte $00

	* = * "SLIDES"
	SlideX:
		.byte $00, $00
	SlideY:
		.byte $00, $00
	SlideDir:
		.byte $00, $00
	SlideCount:
		.byte $00

	Ramp:
		.byte $01,$07,$0f,$0a,$04,$0a,$0f,$07
	RampIndex:
		.byte $00
	Debounce:
		.byte $00

	SlidingActive:
		.byte $00
	MovingTile:
		.byte $00

	Init: {
		//Set sprites and initial positions
		lda #$00
		sta PositionX
		sta PositionY
		sta SlidingActive

		lda #$01
		sta Debounce
		
		lda #$0b
		sta $d025
		lda #$0c
		sta $d026

		lda #$01
		sta $d027
		sta $d028

		lda #$07
		sta $d029
		sta $d02a

		lda #%00000011
		sta $d015
		lda #%00001100
		sta $d01c

		rts
	}

	Update: {
		jsr UpdatePosition
		jsr PositionSprites
		rts
	}

	UpdatePosition: {
			lda $dc00
			sta ZP.Joystick



		//MESSAGES ///////////////////////////////////////
			lda MESSAGES.messageDisplayed
			bmi !+
			lda MESSAGES.messageYOffset
			beq !CanDismiss+
			lda #$01
			sta Debounce
		!CanDismiss:
			lda ZP.Joystick
			and #$10
			bne !ExitMsg+
			lda Debounce
			beq !Debounced+
			rts

		!Debounced:

			lda MESSAGES.messageDisplayed
			cmp #$02
			bcs !Tutorial+

			lda #$ff
			sta MESSAGES.messageYOffset
			rts

		!Tutorial:
			jsr MESSAGES.NextTutorial
			lda #$01
			sta Debounce
			rts

		!ExitMsg:
			lda #$00
			sta Debounce
			rts	
		///////////////////////////////////////////////
		





		!:
			lda SlidingActive
			beq !NoSlidingActive+
			rts
		!NoSlidingActive:

			lda LASERS.Tracing
			beq !+
			rts
		!:


			//Check if fire pressed
			lda ZP.Joystick
			and #FR
			bne !NoFire+
			jmp UpdateWithFire
		!NoFire:

			lda Debounce
			beq !Debounced+
			dec Debounce
			lda ZP.Joystick
			and #[UP+DN+LT+RT]
			cmp #[UP+DN+LT+RT]
			beq !+
			jmp !Exit+
		!:
			lda #$00
			sta Debounce

		!Debounced:
		!Up:
			lda PositionY
			beq !NoUp+
			lda ZP.Joystick
			and #UP
			bne !NoUp+
			dec PositionY
			lda #DEBOUNCE_TIMER
			sta Debounce
		!NoUp:

		!Dn:
			lda PositionY
			cmp #$07
			beq !NoDn+
			lda ZP.Joystick
			and #DN
			bne !NoDn+
			inc PositionY
			lda #DEBOUNCE_TIMER
			sta Debounce
		!NoDn:

		!Lt:
			lda PositionX
			beq !NoLt+
			lda ZP.Joystick
			and #LT
			bne !NoLt+
			dec PositionX
			lda #DEBOUNCE_TIMER
			sta Debounce
		!NoLt:

		!Rt:
			lda PositionX
			cmp #$09
			beq !NoRt+
			lda ZP.Joystick
			and #RT
			bne !NoRt+
			inc PositionX
			lda #DEBOUNCE_TIMER
			sta Debounce
		!NoRt:	

		!Exit:
			rts	
	}

	UpdateWithFire: {
			lda #$00
			sta RampIndex

			//Check if item is movable
			jsr GetIndexPosition //returns in X 
			lda LEVEL.Data.Current, x
			and #$1f
			tay
			lda TABLES.MoveableTileMap, y 
			bne !Moveable+
			jmp !Exit+

		!Moveable:
			//Check for move direction
			lda ZP.Joystick
			and #[UP+DN+LT+RT]
			cmp #[UP+DN+LT+RT]
			bne !MoveAttempted+
			jmp !Exit+

		!MoveAttempted:
			//Check Move count and direction
			jsr GetMoveCountAndDirection
			//If not moved then return control
			bcc !+
			jmp !Exit+
		!:
			jsr GetIndexPosition
			lda LEVEL.Data.Current, x
			and #$c0
			pha
			lda LEVEL.Data.Current, x
			and #$1f
			tay
			pla
			ora TABLES.TileClearValue, y

			sta MovingTile
			lda #$01
			sta SlidingActive
			lda #$01
			sta LEVEL.Data.Current, x
			sta LASERS.Data.PreLaserCopy, x
			
			jsr SetupSlideSprite

			jsr LASERS.ClearIfNeeded
			jsr LASERS.CopyCurrentMap


		!Exit:
			rts
	}

	GetMoveCountAndDirection: {
		//Get direction
			lda ZP.Joystick
			and #$0f
			eor #$0f
			tax
			lda TABLES.JoyDirectionMapX, x
			sta SlideDir + 0
			lda TABLES.JoyDirectionMapY, x
			sta SlideDir + 1
			bne !NonZero+
			lda SlideDir + 0
			bne !NonZero+
			jmp !ExitNotOK+

		!NonZero:
			//Now get count
			lda #$00
			sta ZP.SlideMoveCount
			lda PositionX
			sta ZP.SlideCheckPosX
			lda PositionY
			sta ZP.SlideCheckPosY

		!Loop:
			lda ZP.SlideCheckPosX
			clc
			adc SlideDir + 0
			sta ZP.SlideCheckPosX
			bmi !CountAndExit+
			cmp #$0a
			bcs !CountAndExit+
			//X is onscreen
			lda ZP.SlideCheckPosY
			clc
			adc SlideDir + 1
			sta ZP.SlideCheckPosY
			bmi !CountAndExit+
			cmp #$08
			bcs !CountAndExit+
			//Y is onscreen		
			//Calcualte index
			ldx ZP.SlideCheckPosY
			lda TABLES.Times10, x
			clc
			adc ZP.SlideCheckPosX
			tax
			lda LEVEL.Data.Current, x
			cmp #$08
			bcs !CountAndExit+

			inc ZP.SlideMoveCount
			jmp !Loop-



		!CountAndExit:
			lda ZP.SlideMoveCount
			bne !ExitOK+
		!ExitNotOK:
			sec
			rts

		!ExitOK:


			clc
			rts
	}

	SetupSlideSprite: {
			lda MovingTile
			and #$1f
			tax
			lda TABLES.TileToSpriteMap, x

			sta SPRITE_POINTER + 2
			clc
			adc #$01
			sta SPRITE_POINTER + 3

			//Copy positions from selector
			lda $d000
			sta $d004
			sta SlideX + 0
			sta SlideX + 1
			lda $d001
			sta $d005
			sta SlideY + 0
			sta SlideY + 1
			lda $d002
			sta $d006
			lda $d003
			sta $d007

			//Apply color
			cpx #$11
			bcc !NoColor+
			cpx #$16
			bcs !NoColor+
			cpx #$15
			bne !+
			lda #$07
			jmp !Color+
		!:
			lda MovingTile
			and #$c0
			asl
			rol
			rol
			tax
			lda TABLES.ItemColors, x
			sec
			sbc #$08
			jmp !Color+

		!NoColor:
			lda #$01
		!Color:
			sta $d029
			sta $d02a

			//Calculate target positions
			lda ZP.SlideMoveCount
			asl
			asl
			asl
			sta ZP.SlideTemp
			clc
			adc ZP.SlideTemp
			adc ZP.SlideTemp
			sta ZP.SlideTemp //Move count x24

			//Check x first
			lda SlideDir + 0 
			beq !NotX+
			bmi !Subtract+
		!Add:
			lda SlideX + 0
			clc
			adc ZP.SlideTemp
			sta SlideX + 1
			jmp !NotX+
		!Subtract:
			lda SlideX + 0
			sec
			sbc ZP.SlideTemp
			sta SlideX + 1
		!NotX:

			//Check y first
			lda SlideDir + 1 
			beq !NotY+
			bmi !Subtract+
		!Add:
			lda SlideY + 0
			clc
			adc ZP.SlideTemp
			sta SlideY + 1
			jmp !NotY+
		!Subtract:
			lda SlideY + 0
			sec
			sbc ZP.SlideTemp
			sta SlideY + 1
		!NotY:

			//Disable selector, enable tile copy
			lda #%00001100
			sta $d015
			lda #%00001100
			sta $d01c

			//Decrement move counter
			lda GAME.Settings.gameMode
			beq !normal+
		!practice:
			inc LEVEL.MovesRemaining
			lda LEVEL.MovesRemaining
			cmp #$00
			bne !+
			lda #$ff
			jmp !+
		!normal:
			dec LEVEL.MovesRemaining
			lda LEVEL.MovesRemaining
			cmp #$ff
			bne !+
			lda #$00
		!:
			sta LEVEL.MovesRemaining
		!skip:


			rts
	}


	RestoreSelector: {
			lda #$00
			sta SlidingActive
			lda #%00000011
			sta $d015	
			jsr PositionSprites	
			rts
	}

	GetIndexPosition: {
			ldx PositionY
			lda TABLES.Times10, x
			clc
			adc PositionX
			tax
			rts
	}


	PositionSprites: {
			lda MESSAGES.messageDisplayed
			bmi !+
			cmp #$02
			bcs !+
			rts
		!:

			lda SlidingActive
			beq !+
			jmp SlideActiveSprite
		!:

			lda #%00000011
			sta $d015
			lda #$40
			sta SPRITE_POINTER + 0
			lda #$41
			sta SPRITE_POINTER + 1

			//Move sprite to location
			ldx PositionX
			lda TABLES.SelectPositionX, x
			sta $d000
			sta $d002

			ldx PositionY
			lda TABLES.SelectPositionY, x
			sta $d001
			clc
			adc #$15
			sta $d003


			//Do color ramp
			lda IRQ.Timer
			and #$07
			beq !+
			inc RampIndex
			lda RampIndex
			and #$07
			tax
			lda Ramp, x
			sta $d027
			sta $d028
		!:
			rts
	}

	SlideActiveSprite: {
			//Apply movement
			lda SlideX + 0
			clc
			adc SlideDir + 0
			clc
			adc SlideDir + 0
			clc
			adc SlideDir + 0
			clc
			adc SlideDir + 0
			clc
			adc SlideDir + 0
			clc
			adc SlideDir + 0
			sta SlideX + 0


			lda SlideY + 0
			clc
			adc SlideDir + 1
			clc
			adc SlideDir + 1
			clc
			adc SlideDir + 1
			clc
			adc SlideDir + 1
			clc
			adc SlideDir + 1
			clc
			adc SlideDir + 1
			sta SlideY + 0


			lda SlideY + 0
			cmp SlideY + 1
			bne !NotArrived+
			lda SlideX + 0
			cmp SlideX + 1
			bne !NotArrived+
		
		!Arrived:

			//Work out the new position
			lda SlideX + 1
			ldx #$00
		!:
			cmp TABLES.SelectPositionX, x
			beq !+
			inx 
			cpx #$0a
			bne !-
		!:
			stx ZP.SlideIndex
			stx PositionX

			lda SlideY + 1
			ldx #$00
		!:
			cmp TABLES.SelectPositionY, x
			beq !+
			inx 
			cpx #$08
			bne !-
		!:
			stx PositionY
			lda TABLES.Times10, x 
			clc
			adc ZP.SlideIndex
			tax

			//X contains the index
			lda MovingTile
			sta LEVEL.Data.Current, x
			sta LASERS.Data.PreLaserCopy, x

			jsr RestoreSelector



		!NotArrived:

			//Draw sprite in position	
			lda SlideX + 0
			sta $d004
			sta $d006
			lda SlideY + 0
			sta $d005
			clc
			adc #$15
			sta $d007
			rts
	}
}