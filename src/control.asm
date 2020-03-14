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
	Ramp:
		.byte $01,$07,$0f,$0a,$04,$0a,$0f,$07
	RampIndex:
		.byte $00
	Debounce:
		.byte $00

	Init: {
		//Set sprites and initial positions
		lda #$00
		sta PositionX
		sta PositionY

		lda #$40
		sta SPRITE_POINTER + 0
		lda #$41
		sta SPRITE_POINTER + 1

		lda #$01
		sta $d027
		sta $d028

		lda #%00000011
		sta $d015
		lda #%00000000
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