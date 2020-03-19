LEVEL: {

	Data: {
		Initial: 
			.fill 80, $00
		Display: 
			.fill 80, $00
		Current: 
			.fill 80, $00
	}

	MovesRemaining:
			.byte $00

	LoadLevel: {
			//load level number in Acc
			asl
			sta ZP.LevelPointer + 0
			lda #$00
			rol
			clc
			adc #>LevelPointerData
			sta ZP.LevelPointer + 1

			lda #$00
			sta ZP.DrawNoColor

			ldy #$00
			lda (ZP.LevelPointer), y
			sta ZP.LevelDataVector + 0
			iny
			lda (ZP.LevelPointer), y
			sta ZP.LevelDataVector + 1

			jsr GenerateWalls
			jsr GenerateItems
			jsr DrawMetaData


			jsr CopyInitialMap

			rts
	}

	DrawMetaData: {
			ldy ZP.LevelDataIndex
			iny

			ldx #$00
		!:
			lda #$00
			sta SCREEN_RAM + $28 * $16 + $1f, x
			inx
			cpx #$08
			bne !-




			clc
			ldx #$00
		!:

			lda (ZP.LevelDataVector), y
			beq !Exit+
			adc #$70
			sta SCREEN_RAM + $28 * $16 + $1f, x
			iny
			inx
			cpx #$08
			bne !-
		!Exit:

		!:
			cpx #$07
			bcs !Exit+
			.for(var i=7; i>0;i--) {
				lda SCREEN_RAM + $28 * $16 + $1f + i -1
				sta SCREEN_RAM + $28 * $16 + $1f + i
			}
			lda #$00 
			sta SCREEN_RAM + $28 * $16 + $1f
			inx
			inx
			jmp !-

		!Exit:

			iny
			sty ZP.LevelDataIndex

			lda (ZP.LevelDataVector), y
			sta MovesRemaining

		//DRAW LEVEL CODE
		
			lda GAME.Settings.currentLevel
			sta CodeMod + 1
			lda #$00
			sta CodeMod + 2
			asl CodeMod + 1
			rol CodeMod + 2
			asl CodeMod + 1
			rol CodeMod + 2
			lda CodeMod + 2
			clc
			adc #>[LevelPassCodeData]
			sta CodeMod + 2

			ldx #$00
		!:
		CodeMod:
			lda $BEEF, x
			clc
			adc #$70
			sta SCREEN_RAM + $28 * $13 + $21, x
			inx
			cpx #$04
			bne !-

			rts
	}


	GenerateItems: {
			ldy #$0a
		!Loop:
			lda (ZP.LevelDataVector), y

			bpl !+
			jmp !Exit+
		!:
			cmp #23		//Correct pre lit objects
			bcc !Skip+
			sec 
			sbc #$03
		!Skip:
			tax 
			stx ZP.LevelTemp + 2 //Item number

			lda TABLES.ItemToTileMap, x
			sta ZP.LevelTemp
			iny
			lda (ZP.LevelDataVector), y
			and #$0f
			tax 
			lda TABLES.Times10, x
			sta ZP.LevelTemp + 1
			lda (ZP.LevelDataVector), y
			lsr
			lsr
			lsr
			lsr
			clc
			adc ZP.LevelTemp + 1
			tax
			//Before we store is there additional color?
			tya 
			pha
				lda ZP.LevelTemp
				ldy ZP.LevelTemp + 2 //item number
				clc 
				adc	TABLES.ItemColorMap, y
				sta Data.Initial, x
			pla
			tay
			iny
			jmp !Loop-

		!Exit:
			sty ZP.LevelDataIndex
			rts
	}



	GenerateWalls: {
			ldy #$00
		!Loop:
			lda (ZP.LevelDataVector), y
			sta ZP.LevelTemp
			tya 
			pha

				//Loop through the bits
				ldx #$00
			!InnerLoop:
				lsr ZP.LevelTemp
				bcc !Blank+
			!Wall:
				lda #$08
				sta Data.Initial, y
				bne !Done+
			!Blank:
				lda #$01
				sta Data.Initial, y			
			!Done:
				tya
				clc
				adc #$0a
				tay
				inx
				cpx #$08
				bne !InnerLoop-

			pla 
			tay
			iny
			cpy #$0a
			bne !Loop-

			rts
	}

	CopyInitialMap: {
			ldx #$4f
		!:
			lda Data.Initial, x
			sta Data.Display, x
			sta Data.Current, x
			dex
			bpl !-

			jsr LASERS.CopyCurrentMap

			rts
	}

	DrawLevel: {
			ldx #$00
		!:
				txa 
				pha 

				lda Data.Display, x
				jsr DrawTile

				pla 
				tax
			inx
			cpx #80
			bne !-
			rts
	}

	DoShadows: {
				
	}

	DrawTile: {
			//Draw the tile number in Acc
			//At the tile location in x

			pha
				and #$c0	//Color extract
				asl
				rol
				rol
				sta ZP.LevelColorTemp
			pla
			and #$1f	//Just tile
			tay
			lda TABLES.TileDataOffsetsLSB, y 
			sta TileFetch + 1
			lda TABLES.TileDataOffsetsMSB, y
			sta TileFetch + 2

			lda TABLES.TileToScreenLSB, x
			sta TileDraw + 1
			sta TileCol + 1
			lda TABLES.TileToScreenMSB, x
			sta TileDraw + 2	
			clc
			adc #>[COLOR_RAM - SCREEN_RAM]
			sta TileCol + 2	

			clc 
			ldx #$00
		!inner:
		TileFetch:
			lda $BEEF, x
			ldy TABLES.TileScreenOffsets, x
		TileDraw:
			sta $BEEF, y
			tay
	
	// 	lda ZP.DrawNoColor
	// 	beq !+
	// 		// .break
	// 		nop
	// 		jmp !NoColor+
	// !:

			lda COMPLETION.isCompletion
			beq !skip+
			lda #$08
			ldy TABLES.TileScreenOffsets, x
			jmp TileCol
		!skip:
			lda ZP.LevelColorTemp
			beq !Standard+
				//Custom color
				tay
				lda TABLES.ItemColors, y
				bne !DoneColor+
		!Standard:
			lda CHAR_COLORS, y
		!DoneColor:
			ldy TABLES.TileScreenOffsets, x
			cmp #$08
			beq !NoColor+
		!:
		TileCol:
			sta $BEEF, y

		!NoColor:
			inx
			cpx #$09
			bne !inner-


			rts
	}

	Update: {


			ldx #$4f
		!:
			lda Data.Current, x
			cmp Data.Display, x
			bne !UpdateTile+
		!Next:
			dex
			bpl !-

			jsr LASERS.DoRecolor

			rts

		!UpdateTile:
			stx ZP.LevelShadowTemp

				// ldx #$01
				// stx ZP.DrawNoColor

			ldx ZP.LevelShadowTemp
			sta Data.Display, x
			// .break
			jsr DrawTile
			ldx ZP.LevelShadowTemp
			jmp !Next-
	}
}