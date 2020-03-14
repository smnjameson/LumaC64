LEVEL: {

	Data: {
		Initial: 
			.fill 80, $00
		Display: 
			.fill 80, $00
		Current: 
			.fill 80, $00
	}

	LoadLevel: {
			//load level number in Acc
			asl
			sta ZP.LevelPointer + 0
			lda #$00
			rol
			clc
			adc #>LevelPointerData
			sta ZP.LevelPointer + 1


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
			sta SCREEN_RAM + 31, x
			inx
			cpx #$08
			bne !-
			
			clc
			ldx #$00
		!:
			lda (ZP.LevelDataVector), y
			beq !Exit+
			adc #$80
			sta SCREEN_RAM + 31, x
			lda #$01
			sta COLOR_RAM + 31, x
			iny
			inx
			cpx #$08
			bne !-

		!Exit:
			sty ZP.LevelDataIndex
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


	DrawTile: {
			//Draw the tile number in Acc
			//At the tile location in x
			//Which is item Y

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
		TileCol:
			sta $BEEF, y
			inx
			cpx #$09
			bne !inner-

			rts
	}
}