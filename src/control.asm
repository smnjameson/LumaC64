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

		lda #$40
		sta SPRITE_POINTER + 0
		lda #$41
		sta SPRITE_POINTER + 1

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

			lda SlidingActive
			beq !NoSlidingActive+
			rts

		!NoSlidingActive:
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
			sta MovingTile
			lda #$01
			sta SlidingActive
			lda #$01
			sta LEVEL.Data.Current, x
			
			jsr SetupSlideSprite

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
			sec //return control
			rts

		!NonZero:
			//Now get count
			lda #$00
			sta ZP.SlideMoveCount
			lda PositionX
			sta ZP.SlideCheckPosX
			lda PositionY
			sta ZP.SlideCheckPosY
			



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
			ldx #$03
		!:
			lda $d000, x
			sta $d004, x
			dex
			bpl !-

			//Disable selector, enable tile copy
			lda #%00001100
			sta $d015
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
}