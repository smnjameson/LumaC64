MESSAGES: {

	CompleteRamp:
		.byte $04,$0e,$03,$0d,$01,$0d,$03,$0e
	FailRamp:
		.byte $02,$09,$00,$09,$02,$09,$00,$09
	TutorRamp:
		.byte $0d,$0d,$0d,$0d,$05,$08,$05,$0d

	messageY:
		.byte $00
	messageArrowX:
		.byte $00

	data: {
		lookup:
			.word complete
			.word outofmoves
			.word tutor1
			.word tutor2
			.word tutor3
			.word tutor4
			.word tutor5
			.word tutor6
			.word tutor7

		complete:
			.byte $60,$88,$ff	//X,Y, X arrow offset ($ff == 0ff)
			.byte $5c,$5d,$5e,$5f //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		outofmoves:
			.byte $60,$88,$ff	//X,Y, X arrow offset ($ff == 0ff)
			.byte $58,$59,$5a,$5b //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor1:
			.byte $a8,$64,$f0	//X,Y, X arrow offset ($ff == 0ff)
			.byte $60,$61,$62,$63 //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor2:
			.byte $30,$ac,$30	//X,Y, X arrow offset ($ff == 0ff)
			.byte $64,$65,$66,$67 //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor3:
			.byte $18,$64,$18	//X,Y, X arrow offset ($ff == 0ff)
			.byte $68,$69,$6a,$6b //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor4:
			.byte $18,$b4,$18	//X,Y, X arrow offset ($ff == 0ff)
			.byte $6c,$6d,$6e,$6f //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor5:
			.byte $18,$5c,$18	//X,Y, X arrow offset ($ff == 0ff)
			.byte $70,$71,$72,$73 //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor6:
			.byte $48,$98,$90	//X,Y, X arrow offset ($ff == 0ff)
			.byte $74,$75,$76,$77 //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutor7:
			.byte $18,$3c,$60	//X,Y, X arrow offset ($ff == 0ff)
			.byte $78,$79,$7a,$7b //Foreground
			.byte $7c,$7d,$7d,$7e //Background

		tutornext:
			.byte 0,0,3,4,5,255,255,255,255
	}	

	.label MessageEaseLength = $28
	*=*"message"
	messageDisplayed:
		.byte $ff
	messageYOffset:
		.byte MessageEaseLength

	
	messageEaseOut: 
		.fill MessageEaseLength, ((MessageEaseLength-i)/MessageEaseLength) * ((MessageEaseLength-i)/MessageEaseLength) * ((MessageEaseLength-i)/MessageEaseLength) * $88
	messageEase: 
		:easeOutBounce($ff, $88, MessageEaseLength - 1)

	
	Init: {
			lda #$ff
			sta messageDisplayed
			rts
	}	


	Update: {
			lda messageDisplayed
			bpl !+
			rts

		!:
			asl
			tax
			lda data.lookup, X
			sta ZP.MessageVector + 0
			inx
			lda data.lookup, X
			sta ZP.MessageVector + 1

			

			inc CONTROL.RampIndex
			lda CONTROL.RampIndex
			and #$1f
			lsr
			lsr
			tax
			lda messageDisplayed
			bne !_001+
		!_000:
			lda CompleteRamp, x
			jmp !_set+
		!_001:
			cmp #$01
			bne !_002+
			lda FailRamp, x
			jmp !_set+
		!_002:
			lda TutorRamp, x
			jmp !_set+
		!_set:
			sta $d027
			sta $d028
			sta $d029
			sta $d02a
			lda #$0b
			sta $d02b
			sta $d02c
			sta $d02d
			sta $d02e


			lda #$ff
			sta $d015
			lda #$00
			sta $d01c

			ldy #$02
			lda (ZP.MessageVector), y 
			sta messageArrowX

			ldy #$03
			ldx #$00
		!:
			lda (ZP.MessageVector), y 
			sta SPRITE_POINTER, x 
			iny
			inx
			cpx #$08
			bne !-


			ldy #$00
			ldx #$00
			lda (ZP.MessageVector), y 
		!:
			sta $d000, x
			sta $d008, x
			clc
			adc #$18
			inx
			inx
			iny
			cpy #$04
			bne !-

			ldy #$01 
			lda (ZP.MessageVector), y
			ldx messageYOffset
			beq !+
			txa 
			bpl !Plus+
			eor #$ff
			tax
			lda messageEaseOut, x
			jmp !+
		!Plus:
			lda #MessageEaseLength
			sec
			sbc messageYOffset
			tax
			lda messageEase, x
		!:
			sta $d001
			sta $d003
			sta $d005
			sta $d007
			sta $d009
			sta $d00b
			sta $d00d
			sta $d00f
			sta messageY



		UpdateMessage:
			lda messageYOffset
			beq !+			
			bmi !Off+
		!On:

			dec messageYOffset
			jmp !+
		!Off:
			dec messageYOffset
			lda messageYOffset
			cmp #[0 - MessageEaseLength]
			beq !Clear+
		!:
			rts


		!Clear:

			lda messageDisplayed
			cmp #$00
			bne !Fail+

		!Success:
			lda #$ff
			sta MESSAGES.messageYOffset
			inc GAME.Settings.currentLevel
			lda #$00
			jsr $1000
			jsr GAME.Start
			rts

		!Fail:
			cmp #$02
			bcs !Tutorial+
			jsr GAME.Start
			rts

		!Tutorial:
			lda #$ff
			sta messageDisplayed

			lda #%00000011
			sta $d015
			lda #%00001100
			sta $d01c
			lda #$40
			sta SPRITE_POINTER + 0
			lda #$41
			sta SPRITE_POINTER + 1

			rts
	}
}


.macro easeOutBounce(start, finish, length) {
		.var d = length
		.var b = start
		.var c = finish - start
		.for(var i=0; i <= d; i++) {
			.var t = i/d;
			.if (t < (1/2.75)) {
				.byte floor(c*(7.5625*t*t) + b);
			} else {
				.if (t < (2/2.75)) {
					.byte floor(c*(7.5625*(t-=(1.5/2.75))*t + 0.75) + b)
				} else {
					.if (t < (2.5/2.75)) {
						.byte floor(c*(7.5625*(t-=(2.25/2.75))*t + 0.9375) + b)
					} else {
						.byte floor(c*(7.5625*(t-=(2.625/2.75))*t + 0.984375) + b)		
					}
				}
			} 
		}
	}

.macro easeInOutBack(start, finish, length) {
		.var s = 1.70158
		.var d = length
		.var b = start
		.var c = finish - start
		.for(var i=0; i <= d; i++) {
			.var t = i/ (d/2)
			.if (t < 1) {
				.byte (c/2)*(t*t*(((s*=(1.525))+1)*t - s)) + b
			} else {
				.byte (c/2)*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b 
			}
		}
	}	