MESSAGES: {

	CompleteRamp:
		.byte 1,0,0,0,0,0,0,0
	FailRamp:
		.byte 2,0,0,0,0,0,0,0
	TutorRamp:
			.byte $0d,$0d,$0d,$0d,$05,$08,$05,$0d

	messageOffsetX:
			.fill 128, sin((i/128) * PI * 2) * 20
	messageOffsetYY:
			.fill 128, cos((i/32) * PI * 2) * 20

	messageY:
		.byte $00
	messageArrowX:
		.byte $00

	data: {
		lookup:
			.word complete
			.word outofmoves

		complete:
			.byte $6c,$88,$ff	//X,Y, X arrow offset ($ff == 0ff)
			.byte $58,$59,$5a,$5f //Foreground
			.byte $5b,$5c,$5d,$5f //Background

		outofmoves:
			.byte $60,$88,$ff	//X,Y, X arrow offset ($ff == 0ff)
			.byte $60,$61,$62,$63 //Foreground
			.byte $64,$65,$66,$67 //Background

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
			cmp #$02
			bcc !+
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
			lda #$07
			sta $d02b
			sta $d02c
			lda #$0d
			sta $d02d
			sta $d02e


			lda #$ff
			sta $d015
			lda #$f0
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

			
			lda IRQ.Timer
			lsr
			// and #$7f
			tax
			lda messageOffsetX, x
			clc
			ldy #$00
			adc (ZP.MessageVector), y 
			ldx #$00
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

			sta ZP.MessageTemp
			lda IRQ.Timer
			lsr
			tax
			lda messageOffsetYY, x
			clc
			adc ZP.MessageTemp
			
			cmp #$e2
			bcc !+
			// bpl !+
			lda #$00
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
			bne !noMusic+
			lda messageDisplayed
			bne !noMusic+
			lda #$02
			jsr $1000
		!noMusic:
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

			lda GAME.Settings.musicOn
			bne !SetMusic+
			lda #$03
			jmp !Apply+
		!SetMusic:
			lda #$00
		!Apply:
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

	Tutorials: {
			lookup:
				.word Tutor1
				.word Tutor2
				.word Tutor3
				.word Tutor4
				.word Tutor5
				.word Tutor6
				.word Tutor7
				.word Tutor8
				.word Tutor9
				.word Tutor10


			//202,191,209
			//210,0,212
			//250,190,255
			.encoding "screencode_upper"
			Tutor1:
				.byte 6,3,  24,9 //x,y,w,h
				
				.fill 24, 32 //width
				.byte 32, 202
				.fill 20, 191 //width-4
				.byte 209, 32

				.text @" \$d2THE AIM IS TO LIGHT \$d4 "
				.text @" \$d2ALL OF THESE COLORED\$d4 "
				.text @" \$d2TARGETS. WITHIN THE \$d4 "
				.text @" \$d2NUMBER OF SHIFTS    \$d4 "
				.text @" \$d2AVAILABLE...        \$d4 "

				.byte 32, 250
				.fill 20, 190 //width-3
				.byte 255, 32
				.text @"                     \$bc\$bd "

			Tutor2:
				.byte 2,14,  23,7 //x,y,w,h
				
				.fill 23, 32 //width
				.byte 32, 202
				.fill 19, 191 //width-4
				.byte 209, 32

				.text @" \$d2USING LASERS OF THE\$d4 "
				.text @" \$d2MATCHING COLOR TO  \$d4 "
				.text @" \$d2LIGHT THEM...      \$d4 "

				.byte 32, 250
				.fill 19, 190 //width-4
				.byte 255, 32
				.text @" \$bc\$bd                    "


			Tutor3:
				.byte 0,5,  24,7 //x,y,w,h
				
				.fill 24, 32 //width
				.byte 32, 202
				.fill 20, 191 //width-4
				.byte 209, 32

				.text @" \$d2LASERS NEED TO TOUCH\$d4 "
				.text @" \$d2A BATTERY TO OBTAIN \$d4 "
				.text @" \$d2POWER...            \$d4 "

				.byte 32, 250
				.fill 20, 190 //width-4
				.byte 255, 32
				.text @" \$bc\$bd                     "


			Tutor4:
				.byte 0,3,  28,9 //x,y,w,h
				
				.text @" \$ba\$bb                         "
				.byte 32, 202
				.fill 24, 191 //width-4
				.byte 209, 32

				.text @" \$d2MOVE THIS CURSOR DOWN TO\$d4 "
				.text @" \$d2SELECT THE BATTERY.     \$d4 "
				.text @" \$d2THEN HOLD FIRE AND PULL \$d4 "
				.text @" \$d2DOWN TO MOVE IT INTO    \$d4 "
				.text @" \$d2POSITION.               \$d4 "


				.byte 32, 250
				.fill 24, 190 //width-4
				.byte 255, 32
				.fill 28, 32 //width

			Tutor5:
				.byte 5,3,  25,9 //x,y,w,h
				
				.text @"                      \$ba\$bb "
				.byte 32, 202
				.fill 21, 191 //width-4
				.byte 209, 32

				.text @" \$d2MOVE MIRRORS AROUND  \$d4 "
				.text @" \$d2TO REFLECT THE BEAM  \$d4 "
				.text @" \$d2OF THE LASER SO IT   \$d4 "
				.text @" \$d2POINTS IN THE DESIRED\$d4 " 
				.text @" \$d2DIRECTION.           \$d4 "

				.byte 32, 250
				.fill 21, 190 //width-4
				.byte 255, 32
				.fill 25, 32 //width


			Tutor6:
				.byte 0,11,  30,7 //x,y,w,h
				
				.fill 30, 32 //width
				.byte 32, 202
				.fill 26, 191 //width-4
				.byte 209, 32

				.text @" \$d2LASERS CAN ALSO BE MOVED. \$d4 "
				.text @" \$d2AND A SINGLE BATTERY CAN  \$d4 "
				.text @" \$d2POWER MULTIPLE LASERS.    \$d4 "

				.byte 32, 250
				.fill 26, 190 //width-4
				.byte 255, 32
				.text @"         \$bc\$bd                   "	

			Tutor7:
				.byte 0,9,  23,6 //x,y,w,h
				
				.text @"         \$ba\$bb            "	
				.byte 32, 202
				.fill 19, 191 //width-4
				.byte 209, 32

				.text @" \$d2MIRRORS CAN REFLECT\$d4 "
				.text @" \$d2ON BOTH SIDES ALSO.\$d4 "

				.byte 32, 250
				.fill 19, 190 //width-4
				.byte 255, 32
				.fill 23, 32 //width

			Tutor8:
				.byte 4,8,  23,7 //x,y,w,h
				
				.fill 23, 32 //width
				.byte 32, 202
				.fill 19, 191 //width-4
				.byte 209, 32

				.text @" \$d2TRY MOVING THESE   \$d4 "
				.text @" \$d2BATTERIES TO FINISH\$d4 "
				.text @" \$d2THE LEVEL.         \$d4 "

				.byte 32, 250
				.fill 19, 190 //width-4
				.byte 255, 32
				.text @"      \$bc\$bd       \$bc\$bd      "	

			Tutor9:
				.byte 5,6,  25,7 //x,y,w,h
				
				.text @"                      \$ba\$bb "
				.byte 32, 202
				.fill 21, 191 //width-4
				.byte 209, 32

				.text @" \$d2HINT:                \$d4 "
				.text @" \$d2YOU MAY NEED TO MOVE \$d4 "
				.text @" \$d2THE BATTERIES FIRST  \$d4 "

				.byte 32, 250
				.fill 21, 190 //width-4
				.byte 255, 32
				.fill 25, 32 //width

			Tutor10:
				.byte 0,6,  15,8 //x,y,w,h
				
				.fill 15, 32 //width
				.byte 32, 202
				.fill 11, 191 //width-4
				.byte 209, 32

				.text @" \$d2JUST TWO   \$d4 "
				.text @" \$d2SHIFTS ONLY\$d4 "
				.text @" \$d2HERE. WHICH\$d4 "
				.text @" \$d2TO MOVE?   \$d4 "

				.byte 32, 250
				.fill 11, 190 //width-4
				.byte 255, 32
				.fill 15, 32 //width



			tutorNext:
				.byte 1,2,3,255,8,255,255,255,255,255,255
			width:
				.byte $00
			height:
				.byte $00
			ScreenData:
				.fill 256, 0
			ColorData:
				.fill 256, 0
	}

	currentTutor:
			.byte $00

	addTutorial: {
			sta currentTutor
			asl
			tax
			lda Tutorials.lookup + 0, x
			sta ZP.tutorIndex + 0
			lda Tutorials.lookup + 1, x
			sta ZP.tutorIndex + 1

			//Find top corner
			ldy #$00
			lda (ZP.tutorIndex), y
			sta ZP.tutorTemp
			iny 
			lda (ZP.tutorIndex), y
			tax
			lda TABLES.ScreenLSB, x
			clc
			adc ZP.tutorTemp
			sta ZP.tutorScreen + 0
			sta ZP.tutorColor + 0
			lda TABLES.ScreenMSB, x
			adc #$00
			sta ZP.tutorScreen + 1
			adc #>[COLOR_RAM-SCREEN_RAM]
			sta ZP.tutorColor + 1

			iny 
			lda (ZP.tutorIndex), y
			sta ZP.tutorCols
			iny 
			lda (ZP.tutorIndex), y
			sta ZP.tutorRows
			iny
			lda (ZP.tutorIndex), y
			sta ZP.tutorArrow

			//Clear that area
			jsr ClearTutorArea

			//Set special message type
			lda #$02
			sta messageDisplayed
			lda #$00
			sta messageYOffset
			sta $d020
			rts
	}	

	ClearTutorArea: {

			lda ZP.tutorRows
			sta ZP.tutorTemp
			lda ZP.tutorScreen + 0
			pha
			lda ZP.tutorScreen + 1
			pha
			lda ZP.tutorColor + 0
			pha
			lda ZP.tutorColor + 1
			pha


				ldy #$00
				ldx #$00
			!:
				lda (ZP.tutorScreen), y
				sta Tutorials.ScreenData, x

				tya
				pha
				txa
				adc #$04
				tay 
				lda (ZP.tutorIndex), y
				cmp #$70
				bcs !skip+
				adc #$70
			!skip:
				sta ZP.tutorTemp2
				pla
				tay
				lda ZP.tutorTemp2

			!FetchedChar:
				sta (ZP.tutorScreen), y
				sta ZP.tutorTemp2
				lda (ZP.tutorColor), y
				sta Tutorials.ColorData, x

				txa
				pha
					ldx ZP.tutorTemp2
					lda CHAR_COLORS, x
					sta ZP.tutorTemp2
				pla
				tax 

				lda ZP.tutorTemp2
				sta (ZP.tutorColor), y
				inx
				iny
				cpy ZP.tutorCols
				bne !-



				clc
				lda ZP.tutorScreen + 0
				adc #$28
				sta ZP.tutorScreen + 0
				lda ZP.tutorScreen + 1
				adc #$00
				sta ZP.tutorScreen + 1

				clc
				lda ZP.tutorColor + 0
				adc #$28
				sta ZP.tutorColor + 0
				lda ZP.tutorColor + 1
				adc #$00
				sta ZP.tutorColor + 1

				dec ZP.tutorRows
				beq !End+

				ldy #$00
				jmp !-

		!End:

			// //ARROW
			// ldy ZP.tutorArrow

			// lda (ZP.tutorScreen), y
			// sta Tutorials.ScreenData, x
			// lda (ZP.tutorColor), y
			// sta Tutorials.ColorData, x			
			// lda #188
			// sta (ZP.tutorScreen), y
			// lda #11
			// sta (ZP.tutorColor), y

			// inx
			// iny

			// lda (ZP.tutorScreen), y
			// sta Tutorials.ScreenData, x
			// lda (ZP.tutorColor), y
			// sta Tutorials.ColorData, x			
			// lda #189
			// sta (ZP.tutorScreen), y
			// lda #09
			// sta (ZP.tutorColor), y


			pla
			sta ZP.tutorColor + 1
			pla
			sta ZP.tutorColor + 0
			pla
			sta ZP.tutorScreen + 1
			pla
			sta ZP.tutorScreen + 0
			lda ZP.tutorTemp
			sta ZP.tutorRows
			rts
	}

	RestoreScreen: {
			lda ZP.tutorRows
			pha


				ldy #$00
				ldx #$00
			!:
				lda Tutorials.ScreenData, x
				sta (ZP.tutorScreen), y
				lda Tutorials.ColorData, x
				sta (ZP.tutorColor), y
				inx
				iny
				cpy ZP.tutorCols
				bne !-

				dec ZP.tutorRows
				beq !End+

				clc
				lda ZP.tutorScreen + 0
				adc #$28
				sta ZP.tutorScreen + 0
				lda ZP.tutorScreen + 1
				adc #$00
				sta ZP.tutorScreen + 1

				clc
				lda ZP.tutorColor + 0
				adc #$28
				sta ZP.tutorColor + 0
				lda ZP.tutorColor + 1
				adc #$00
				sta ZP.tutorColor + 1

				ldy #$00
				jmp !-

		!End:
			pla
			sta ZP.tutorRows
			rts
	}



	NextTutorial: {
			jsr RestoreScreen

			ldx currentTutor
			lda Tutorials.tutorNext, x
			bmi !+
			jsr addTutorial
			rts
		!:
			lda #$ff
			sta messageDisplayed
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