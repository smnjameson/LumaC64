.const KOALA_TEMPLATE = "C64FILE, Bitmap=$0000, ScreenRam=$1f40, ColorRam=$2328, BackgroundColor = $2710"
       


INTRO: {
	isIntro:
		.byte $00
	invalidCode:
		.byte $00

	Start: {
			ldx #$ff 
			txs

			lda #$00
			sta $d015

			lda #$01
			sta isIntro

				lda #$01
				jsr $1000

				//color
			    ldx #0
			!loop:
		        .for (var i=0; i<4; i++) {
		           lda $5c00+i*$100,x
		           sta $d800+i*$100,x
		        }
		        inx
		        bne !loop-
		        

		        ldx #$00
		    !:
		    	lda #$00
		    	sta SCREEN_RAM + 15 * $28, x	
		    	sta SCREEN_RAM + 19 * $28, x	
		    	lda #$01
		    	sta COLOR_RAM + 15 * $28, x	
		    	sta COLOR_RAM + 19 * $28, x	
		    	inx
		    	cpx #160
		    	bne !-

		    	jsr DrawOptions

		    	jsr GAMESCROLLER.Init
		    	
		    	lda #$00
		    	sta Selected
		    	sta invalidCode

		mainloop:
				lda $d011
				bpl *-3
			    	jsr DrawSelected
			    	jsr Controls
			    	jsr GAMESCROLLER.Update
				lda $d011
				bmi *-3

				jmp mainloop
	}

	CheckCodes: {
				lda #<LevelPassCodeData
				sta ZP.codeCheck + 0
				lda #>LevelPassCodeData
				sta ZP.codeCheck + 1

				ldx #$00
			!Loop:
				ldy #$00
			!:
				lda (ZP.codeCheck), y
				clc
				adc #$70
				cmp KeyInput, y
				bne !NoMatch+
				iny
				cpy #$04
				bne !-
			!Match:
				jmp !Success+

			!NoMatch:
				clc
				lda ZP.codeCheck + 0
				adc #$04
				sta ZP.codeCheck + 0
				lda ZP.codeCheck + 1
				adc #$00
				sta ZP.codeCheck + 1
				inx
				cpx #LEVEL.MAX_LEVELS
				bne !Loop-
				rts

			!Success:
				lda #$00
				sta isIntro
				stx GAME.Settings.currentLevel
				lda #$00
				sta GAME.Settings.gameMode


				lda #$00
				ldx #$09		//Force mc in every square
				jsr ClearScreen
				jsr HUD.Init
				jmp GAME.Start
	}


	JoyDebounce:
			.byte $00
	KeyDebounce:
			.byte $00
	KeyPosition:
			.byte $00
	KeyInput:
			.byte $71,$71,$71,$71

	KeyLookup:
			.encoding "screencode_upper"
			.text "W@@@@@@@" //0
			.text "S@RYIP@@"
			.text "A@@GJL@@" //2
			.text "D@@@@@@@"
			.text "EZCBM@@@" //4
			.text "@@FHK@@@"
			.text "@@TUO@@Q" //6
			.text "@@XVN@@@"


	KeyControl: {
			lda #%11111111	//Enable keyboard handling
			sta $dc02
			lda #%00000000	
			sta $dc03	


			ldx #$00 //ROW
			ldy #%11111110  
		!loop:
			tya
			sta $dc00

			lda $dc01
			sta ZP.introkey
			cmp #$ff
			beq !+ //No key on row is pressed

				lda KeyDebounce
				bne !Exit+

				//CHECK ACTUAL KEYS
				lda #$00
				sta ZP.introTemp3
				lda ZP.introkey
			!lp1:

				ror
				bcc !skip+
				inc ZP.introTemp3
				jmp !lp1-
			!skip:
				lda ZP.introTemp3
				//COL
				asl
				asl
				asl
				sta ZP.introTemp3
				txa
				adc ZP.introTemp3
				tax
				lda KeyLookup, x

				ldx KeyPosition
				clc
				adc #$70
				sta KeyInput, x
				inc KeyPosition

				lda KeyPosition
				cmp #$04
				bne !NotComplete+
				
				jsr CheckCodes
				lda #$50
				sta invalidCode

			!NotComplete:
				lda #$01
				sta KeyDebounce
				jmp !Exit+

		!:
			tya
			sec 
			rol	//Advance row
			tay	
			inx
			cpx #$08
			bne !loop-

			lda #$00
			sta KeyDebounce
		!Exit:
			lda #%00000000	//Restore joy control
			sta $dc02			
			rts
	}

	Controls: {
			lda $dc00
			and #$1f
			sta ZP.Joystick
			cmp #$1f
			bne !Pressed+
			lda #$00
			sta JoyDebounce
			rts

		!Pressed:
			lda JoyDebounce
			beq !+
			rts
		!:
			lda #$01
			sta JoyDebounce

			lda ZP.Joystick
			and #$01
			bne !NotUp+
			lda Selected
			beq !NotUp+
			dec Selected
			lda #$00
			sta SelectedAnim
		!NotUp:

			lda ZP.Joystick
			and #$02
			bne !NotDn+
			lda Selected
			cmp #$02
			beq !NotDn+
			lda #$00
			sta SelectedAnim
			sta KeyPosition
			inc Selected
		!NotDn:


			lda ZP.Joystick
			and #$10
			bne !NotFr+
			lda Selected
			cmp #$02
			beq !NotFr+
			
			pla
			pla
			jmp Exit
		!NotFr:	
			rts
	}

	Exit: {
			lda #$00
			sta isIntro

			lda Selected
			sta GAME.Settings.gameMode
			lda #$00
			sta GAME.Settings.currentLevel

			lda #$00
			ldx #$09		//Force mc in every square
			jsr ClearScreen
			jsr HUD.Init
			jmp GAME.Start			
			jmp GAME.Start
	}

	Irq001: {
			// lda #$00
			// sta $d021

				lda #$3b
				sta $d011

				lda #%01101000
				sta $d018
				lda $dd00
				and #%11111100
				ora #%10
				sta $dd00



			lda #<Irq002
			sta $fffe
			lda #>Irq002
			sta $ffff

			lda #$a8
			sta $d012
			rts
	}

	Irq002: {
			saveState()
				nop
				nop
				nop
				nop
				nop

				lda #$1b
				sta $d011

				lda #%00000010
				sta $d018
				lda $dd00
				and #%11111100
				sta $dd00

				// lda #$00
				// sta $d021

				lda #<IRQ.MainIRQ
				sta $fffe
				lda #>IRQ.MainIRQ
				sta $ffff

				lda #IRQ.SCROLLER_SPLIT
				sta $d012		
			restoreState()
			asl $d019	
			rti
	}




	Selected: 
			.byte $00
	SelectedLookup:
			.word Select0
			.word Select1
			.word Select2
			
			.encoding "screencode_upper"
	Select0:
			.byte 202
			.fill 18, 191
			.byte 209

			.text @"\$d2 NORMAL:          \$d4"
			.text @"\$d2                  \$d4"
			.text @"\$d2 - LIMITED SHIFTS \$d4"
			.text @"\$d2 - NO LEVEL SKIP  \$d4"
			.text @"\$d2 - GIVES PASSCODE \$d4"

			.byte 250
			.fill 18, 190 //width-3
			.byte 255

	Select1:
			.byte 202
			.fill 18, 191
			.byte 209
			
			.text @"\$d2 PRACTICE:        \$d4"
			.text @"\$d2                  \$d4"
			.text @"\$d2 - NO SHIFT LIMIT \$d4"
			.text @"\$d2 - LEVEL SKIP     \$d4"
			.text @"\$d2 - NO PASSCODES   \$d4"

			.byte 250
			.fill 18, 190 //width-3
			.byte 255
	Select2:
			.byte 202
			.fill 18, 191
			.byte 209

			.text @"\$d2 ENTER LEVEL CODE \$d4"
			.text @"\$d2 TO RESUME A GAME \$d4"
			.text @"\$d2                  \$d4"
			.text @"\$d2    CODE: ....    \$d4"
			.text @"\$d2                  \$d4"

			.byte 250
			.fill 18, 190 //width-3
			.byte 255
		


	DrawSelected: {
			lda Selected
			asl
			tax
			lda SelectedLookup, x
			sta ZP.introSelectVector + 0
			inx
			lda SelectedLookup, x
			sta ZP.introSelectVector + 1

			lda TABLES.ScreenLSB + 16
			clc
			adc #$10
			sta ZP.introScreenVector + 0
			sta ZP.introColorVector + 0

			lda TABLES.ScreenMSB + 16
			adc #$00
			sta ZP.introScreenVector + 1
			adc #>[COLOR_RAM - SCREEN_RAM]
			sta ZP.introColorVector + 1


			lda #$07
			sta ZP.introTemp1
			ldy #$00
			ldx #$00
		!loop:
			lda (ZP.introSelectVector), y
			sty ZP.introTemp2
			sta ZP.introTemp3
			txa
			tay
			lda ZP.introTemp3
			cmp #$70
			bcs !+
			adc #$70
		!:
			sta (ZP.introScreenVector), y
			tax 
			lda CHAR_COLORS, x
			sta (ZP.introColorVector), y
			tya
			tax 
			ldy ZP.introTemp2
			iny
			inx
			cpx #$14
			bne !loop-
			ldx #$00

			dec ZP.introTemp1
			beq !exit+

			lda ZP.introScreenVector + 0
			clc
			adc #$28
			sta ZP.introScreenVector + 0
			sta ZP.introColorVector + 0
			bcc !+
			inc ZP.introScreenVector + 1	
			inc ZP.introColorVector + 1	
		!:
			jmp !loop-

		!exit:

			//SELECTED ARROW
			lda #$00
			ldx #$00
		!:
			sta SCREEN_RAM + 17 * $28 + 0, x
			sta SCREEN_RAM + 19 * $28 + 0, x
			sta SCREEN_RAM + 21 * $28 + 0, x
			inx
			cpx #$03
			bne !-


			ldx Selected
			lda SelectedOfsets, x
			clc
			adc SelectedAnim
			tax 


			lda #$ab
			sta SCREEN_RAM + 17 * $28, x
			lda IRQ.Timer
			lsr
			lsr
			and #$0f
			tay
			lda SelectedRamp, y
			sta COLOR_RAM + 17 * $28, x


			lda IRQ.Timer
			and #$07
			bne !+
			ldx SelectedAnim
			cpx #$02
			bcs !+
			inx
			stx SelectedAnim
		!:


			//Draw keycode
			lda Selected
			cmp #$02
			bne !end+

			ldx #$00
		!:	
			cpx KeyPosition
			beq !DoneLoop+
			lda KeyInput, x
			sta SCREEN_RAM + 20 * $28 + 27, x
			lda #$01
			sta COLOR_RAM + 20 * $28 + 27, x
			inx
			cpx #$04
			bne !-
		!DoneLoop:
			lda IRQ.Timer
			and #$0f
			tax
			lda SelectedRamp, x
			ldx KeyPosition
			sta COLOR_RAM + 20 * $28 + 27, x


			jsr KeyControl
		!end:



			lda invalidCode
			beq !end+
			lda Selected
			cmp #$02
			bne !end+

			
			ldx #$00
		!:
			lda #$00
			sta SCREEN_RAM + 17 * $28 + 18, x
			lda Error, x
			clc
			adc #$70
			sta SCREEN_RAM + 18 * $28 + 18, x
			lda #$02
			sta COLOR_RAM + 18 * $28 + 18, x
			inx
			cpx #$10
			bne !-

			dec invalidCode
			bne !end+

			lda #$00 
			sta KeyPosition
		!end:
			rts
	}

	Error:
		.encoding "screencode_upper"
		.text "NOT A LEVEL CODE"
	SelectedRamp:
			.byte 3,5,4,2,6,2,4,5
			.byte 3,5,4,2,6,2,4,5
	SelectedAnim:
			.byte $00
	SelectedOfsets:
			.byte 0,80,160


	.encoding "screencode_upper"
	Option1:
			.text "NORMAL    "
	Option2:
			.text "PRACTICE  "
	Option3:
			.text "ENTER CODE"


	DrawOptions: {
				ldx #$00
			!:
				lda Option1, x
				clc
				adc #$70
				sta SCREEN_RAM + 17 * $28 + 4, x	

				lda Option2, x
				clc
				adc #$70
				sta SCREEN_RAM + 19 * $28 + 4, x	

				lda Option3, x
				clc
				adc #$70
				sta SCREEN_RAM + 21 * $28 + 4, x	

				inx 
				cpx #10
				bne !-
				rts
	}





}