LASERS: {
	.label BATTERY = $15

	Active:
		.byte $00
	Tracing:
		.byte $00
	Complete:
		.byte $00

	Data: {
		PreLaserCopy:
			.fill 80, 0
	}

	Path: {
		count: 
			.byte 0
		x:
			.fill 32, 0
		y:
			.fill 32, 0
		dx:
			.fill 32, 0
		dy:
			.fill 32, 0
		terminated:
			.fill 32, 0
		*=*"SPRAKS"
		spark:
			.fill 32,0
		color:
			.fill 32, 0
	}

	Init: {
			lda #$00
			sta Active
			sta Tracing
			sta Complete
			sta Path.count

			jsr clearSparks

			lda #$00
			sta SparkPrevCounter

			lda #$01
			sta $d02b
			sta $d02c
			sta $d02d
			sta $d02e

			rts
	}

	clearSparks: {
			lda #$00
			ldy #$00
		!:
			sta Path.spark, y
			iny
			cpy #$20
			bne !-
		!skip:

			lda #$00
			sta SparkCounter
			sta $d008
			sta $d009
			sta $d00a
			sta $d00b
			sta $d00c
			sta $d00d
			sta $d00e
			sta $d00f
			rts
	}

	ClearIfNeeded: {
			//TODO
			lda #$00
			sta Active
			sta Tracing
			sta Complete
			sta Path.count

			jsr clearSparks

			//Copy map from PreLaserCopy TO Current
			ldx #79
		!:
			lda Data.PreLaserCopy, x
			sta LEVEL.Data.Current, x
			dex
			bpl !-				
			rts
	}

	CopyCurrentMap: {
			ldx #79
		!:
			lda LEVEL.Data.Current, x

			sta Data.PreLaserCopy, x
			dex
			bpl !-
			rts
	}

	TrackActiveLasers: {
		// rts


			ldx #79
		!loop:
			lda LEVEL.Data.Current, x
			and #$1f
			cmp #$11
			bcs !+
 			jmp !NoLaser+
 		!:
			cmp #$15
			bcc !+
			jmp !NoLaser+
		!:


			lda LEVEL.Data.Current, x
			and #$c0
			asl
			rol
			rol
			sta ZP.PathColorTemp

			//Found laser
			//Check for battery
			lda TABLES.ValidDirections, x
			sta ZP.DirCheck

			//UP
				lda ZP.DirCheck
				and #CONTROL.UP
				beq !NotUp+
				txa
				sec
				sbc #$0a
				tay
				lda LEVEL.Data.Current, y
				cmp #BATTERY
				bne !NotUp+
				jmp !BatteryFound+
			!NotUp:

			//DN
				lda ZP.DirCheck
				and #CONTROL.DN
				beq !NotDn+
				txa
				clc
				adc #$0a
				tay
				lda LEVEL.Data.Current, y
				cmp #BATTERY
				bne !NotDn+
				jmp !BatteryFound+
			!NotDn:

				//LT
				lda ZP.DirCheck
				and #CONTROL.LT
				beq !NotLt+
				txa
				sec
				sbc #$01
				tay
				lda LEVEL.Data.Current, y
				cmp #BATTERY
				bne !NotLt+
				jmp !BatteryFound+
			!NotLt:		

				//RT
				lda ZP.DirCheck
				and #CONTROL.RT
				beq !NotRt+
				txa
				clc
				adc #$01
				tay
				lda LEVEL.Data.Current, y
				cmp #BATTERY
				bne !NotRt+
				jmp !BatteryFound+
			!NotRt:	

				jmp !NoBattery+

		!BatteryFound:
				ldy Path.count
				lda TABLES.IndexToX, x
				sta Path.x, y
				lda TABLES.IndexToY, x
				sta Path.y, y
				lda LEVEL.Data.Current, x
				and #$1f
				tay 
				lda TABLES.LaserDirToJoyDir - 17, y
				pha
				tay
				lda TABLES.JoyDirectionMapX, y
				ldy Path.count
				sta Path.dx, y
				pla 
				tay
				lda TABLES.JoyDirectionMapY, y
				ldy Path.count
				sta Path.dy, y

				lda #$00
				sta Path.terminated, y
				sta Path.spark, y
				lda ZP.PathColorTemp
				sta Path.color, y

				inc Path.count

		!NoBattery:
		!NoLaser:
			dex
			bmi !+
			jmp !loop-
		!:
			rts
	}

	Update: {
			lda CONTROL.SlidingActive
			beq !DoUpdate+
			jsr ClearIfNeeded
			rts
		!:
			
			lda #$00
			sta Active
			rts	


		!DoUpdate:
			jsr DoSparks
			
			lda Active
			bne !+
			
			jsr TrackActiveLasers
			lda #$01
			sta Tracing			
			inc Active
		!:
			jsr TraceLasers

			jsr AreWeComplete


			
			rts
	}

	AreWeComplete: {
			lda GAME.Settings.isCompleted
			beq !+
			rts
		!:

			//Clear prev lit targets
			
			lda Tracing
			bne !NoPrevLitChange+
				ldy #$00
				ldx #$00
			!loop:
				lda LEVEL.Data.Current, x
				and #$1f
				cmp #$1f
				beq !+
				lda #$00
				sta PrevLitTargets, x
			!:
				lda PrevLitTargets, x
				beq !+
				iny
			!:
				inx
				cpx #80
				bne !loop-
				sty ChimeIndex
		!NoPrevLitChange:


			ldx #$00
		!loop:
				lda LEVEL.Data.Current, x
				and #$1f
				cmp #$1e
				beq !Fail+

			inx
			cpx #80
			bne !loop-


			lda #$01
			sta GAME.Settings.isCompleted
			lda #$f0
			sta GAME.Settings.completeSoundOff

			lda #$00
			sta MESSAGES.messageDisplayed
			lda #MESSAGES.MessageEaseLength - 1
			sta MESSAGES.messageYOffset

			rts

		!Fail:
			rts
	}


	SparkSpriteIndex:
			.byte $00
	SparkPathIndex:
			.byte $00
	SparkCounter:
			.byte $00
	SparkPrevCounter:
			.byte $00
	SparkAnimCounter:
			.byte $00
	DoSparks: {
			lda MESSAGES.messageDisplayed
			bmi !+
			cmp #$02
			bcs !+
			rts
		!:
			lda #$00
			sta SparkCounter

			sta $d004
			sta $d005
			sta $d006
			sta $d007
			sta $d008
			sta $d009
			sta $d00a
			sta $d00b
			sta $d00c
			sta $d00d
			sta $d00e
			sta $d00f


			lda #$d015
			ora #%11110011
			sta $d015
			lda #$d01c
			ora #%11110000
			sta $d01c

			
		!loop:
			ldx SparkPathIndex
			// .break
			lda Path.spark, x
			bne !+
			jmp !skip+
		!:	

				//Apply spark
				lda Path.x, x
				tay
				lda TABLES.SelectPositionX, y
				pha
				lda SparkSpriteIndex
				asl
				tay
				pla
				sta $d008, y



				lda Path.y, x
				tay
				lda TABLES.SelectPositionY, y
				pha
				lda SparkSpriteIndex
				asl
				tay
				pla
				cmp #$29
				bcs !ok+
				lda #$00
			!ok:
				sta $d009, y


				sty ZP.SparkTemp

				ldy Path.dx, x
				iny				
				lda TABLES.SparkOffsetX, y
				clc
				ldy ZP.SparkTemp
				adc $d008, y
				sta $d008, y

				ldy Path.dy, x
				iny				
				lda TABLES.SparkOffsetY, y
				clc
				ldy ZP.SparkTemp
				adc $d009, y
				sta $d009, y


				ldy Path.dx, x
				beq !+
				ldy ZP.SparkTemp
				lda $d009, y
				clc
				adc #$0a
				sta $d009, y
			!:


			ldy SparkSpriteIndex
			iny
			sty SparkSpriteIndex


		!skip:
			inx
			cpx Path.count
			bcc !+
			ldx #$00
		!:
			stx SparkPathIndex


			ldy SparkSpriteIndex
			cpy #$04
			beq !Exit+


			ldy SparkCounter
			iny
			sty SparkCounter
			cpy #$20//Path.count
			beq !Exit+

			jmp !loop-


		!Exit:
			ldy #$00
			sty SparkSpriteIndex

			//record indexes etc
			lda IRQ.Timer
			and #$03
			bne !Skip+
			ldy SparkAnimCounter
			iny
			cpy #$03
			bne !+
			ldy #$00
		!:
			sty SparkAnimCounter
			tya 
			clc
			adc #$50

			sta SPRITE_POINTER + 4
			sta SPRITE_POINTER + 5
			sta SPRITE_POINTER + 6
			sta SPRITE_POINTER + 7

			lda #$01
			sta $d02b
			sta $d02c
			sta $d02d
			sta $d02e
		!Skip:



			lda GAME.Settings.musicOn
			bne !end+
			//Count sparks
			ldx #$1f
			lda #$00
			clc
		!:
			adc Path.spark, x
			dex
			bpl !-
			cmp #$00
			

			sta IRQ.isSparks
			// ldx SparkPrevCounter
			// bne !end+
			// sta SparkPrevCounter
		!end:
			rts
	}


	TraceLasers: {
		// 	lda IRQ.Timer
		// 	and #$01
		// 	beq !+
		// 	rts
		// !:
			lda #$00
			sta ZP.PathUpdateCount

			ldx #$00
		!loop:
			cpx Path.count
			bcc !+
			jmp !Exit+ 
		!:

			txa
			pha
			lda Path.terminated, x
			beq !+
			jmp !Next+ 
		!:

			inc ZP.PathUpdateCount
			// .break
			//Advance laser path
			lda Path.color, x
			sta ZP.PathColor

			lda Path.x, x
			clc
			adc Path.dx, x
			sta Path.x, x
			lda Path.y, x
			clc
			adc Path.dy, x
			sta Path.y, x

			//Check if in bounds
			lda Path.x, x
			bpl !+
			jmp !Terminate+
		!:
			cmp #$0a
			bcc !+
			jmp !Terminate+
		!:
			lda Path.y, x
			bpl !+
			jmp !Terminate+
		!:
			cmp #$08
			bcc !+
			jmp !Terminate+	
		!:

			//We are in bounds here
			//Check if we can advance

			//so advance the path
			lda Path.y, x
			tay
			lda TABLES.Times10, y
			clc
			adc Path.x, x
			tay

			stx ZP.LaserDirTemp

				//Check is current tile passable
				lda Path.dx, x
				beq !Vert+
			!Horiz:
				lda Path.dx, x
				bpl !Rt+
				lda LEVEL.Data.Current, y
				and #$1f
				tax
				lda TABLES.HorizPassableLt, x
				bmi !CheckTarget+
				cmp #$01
				jmp !Done+
			!Rt:
				lda LEVEL.Data.Current, y
				and #$1f
				tax
				lda TABLES.HorizPassableRt, x
				bmi !CheckTarget+
				cmp #$01
				jmp !Done+			

			!Vert:
				lda Path.dy, x
				bpl !Dn+
				lda LEVEL.Data.Current, y
				and #$1f
				tax
				lda TABLES.VertPassableUp, x
				bmi !CheckTarget+
				cmp #$01
				jmp !Done+
			!Dn:
				lda LEVEL.Data.Current, y
				and #$1f
				tax
				lda TABLES.VertPassableDn, x
				bmi !CheckTarget+
				cmp #$01
				jmp !Done+

			!Done:
			ldx ZP.LaserDirTemp
			bcs !NoTerminate+

				lda LEVEL.Data.Current, y
				and #$1f
				tay
				lda TABLES.CanSpark, y
				beq !NoSpark+
				lda #$01
				sta Path.spark,x
			!NoSpark:
				jmp !Terminate+

				//Update new tile
			!NoTerminate:
				jsr UpdateTile
		
			jmp !Next+

		!CheckTarget:
			lda LEVEL.Data.Current, y
			and #$1f
			cmp #$1e
			bcc !Terminate+
			cmp #$1f
			beq !Terminate+

			lda LEVEL.Data.Current, y
			and #$c0
			asl
			rol
			rol
			ldx ZP.LaserDirTemp
			cmp Path.color, x
			bne !Terminate+

			lda LEVEL.Data.Current, y
			clc
			adc #$01
			sta LEVEL.Data.Current, y
			lda PrevLitTargets, y
			bne !NoChime+
				lda #$01
				sta PrevLitTargets, y
				txa
				pha
				jsr PlayChime
				pla 
				tax
		!NoChime:

		!Terminate:	
			lda #$01
			sta Path.terminated, x


		!Next:
			pla
			tax
			inx
			cpx Path.count
			beq !+
			jmp !loop-
		!:
		!Exit:

			lda ZP.PathUpdateCount
			bne !+
			lda #$00
			sta Tracing
			lda LEVEL.MovesRemaining
			bne !+
			lda MESSAGES.messageDisplayed
			bpl !+
			lda GAME.Settings.isCompleted
			bne !+
			lda GAME.Settings.gameMode
			bne !+

				lda #$1f
				sta MESSAGES.messageYOffset
				lda #$01
				sta MESSAGES.messageDisplayed
		!:
			rts
	}

	PrevLitTargets:
			.fill 80, 0

	UpdateTile: {
			//x = Path index
			//y = Tile index

			//are we hitting a mirror
			lda LEVEL.Data.Current, y
			sty ZP.MirrorTileIndex
			cmp #$09
			bcc !NoMirror+
			cmp #$11
			bcs !NoMirror+

		!Mirror:
			lda #$00
			sta ZP.MirrorDirTemp

			jsr GetJoyDirection

			//Accumulator is now a JOY direction
			//Are we a mirror forward or backwards
			sta ZP.LaserDirTemp + 0
			stx ZP.LaserDirTemp + 1
			lda LEVEL.Data.Current, y
			cmp #$0d
			bcs !BackMirror+

		!FwdMirror:
			ldy ZP.LaserDirTemp + 0
			lda TABLES.MirrorReflectForward, y
			tay
			jmp !DoneMirror+
		!BackMirror:
			ldy ZP.LaserDirTemp + 0
			lda TABLES.MirrorReflectBack, y
			tay

		!DoneMirror:


			lda TABLES.JoyDirectionMapX, y
			sta Path.dx, x 
			lda TABLES.JoyDirectionMapY, y
			sta Path.dy, x

			ldy ZP.MirrorTileIndex

		!NoMirror:
			//Apply laser to current tile
			//Current tile = Y
			jsr UpdateNewTile
			// lda #$04
			// sta LEVEL.Data.Current, y
			rts
	}

	GetJoyDirection: {
			lda #$00
			sta ZP.MirrorDirTemp

			lda Path.dy, x //-1 or 1
			beq !NoVert+
			clc
			adc #$01 	//0,2
			lsr 		//0,1
			clc
			adc #$01	//1,2
			sta ZP.MirrorDirTemp
		!NoVert:

			lda Path.dx, x //-1 or 1
			beq !NoHoriz+
			clc
			adc #$01 	//0,2
			lsr 		//0,1
			clc
			adc #$01	//1,2
			asl
			asl			//4, 8
			clc
			adc ZP.MirrorDirTemp
			sta ZP.MirrorDirTemp
		!NoHoriz:
			lda ZP.MirrorDirTemp
			rts
	}


	UpdateNewTile: {
			//Current tile = Y
			//Current Path = X

			//Is tile blank (<8)
			// lda LEVEL.Data.Current, y
			//if so apply correct laser direction
			
			//Apply direction according to path exit direction

			jsr GetJoyDirection
			// .break
			tax 
			lda TABLES.JoyToDirIndex, x //(1,2,3,4,  U,D,L,R)


			//Transform up
			cmp #$01
			bne !NotUp+
			lda LEVEL.Data.Current, y
			and #$1f
			tax
			lda TABLES.TileUpTransform, x
			sta LEVEL.Data.Current, y
			tax
			lda TABLES.ColorTransformUp, x
			sta ZP.ColorUpdateIndex
			jsr ColorTile
			jmp !Exit+
		!NotUp:

			//Transform dn
			cmp #$02
			bne !NotDn+
			lda LEVEL.Data.Current, y
			and #$1f
			tax
			lda TABLES.TileDnTransform, x
			sta LEVEL.Data.Current, y
			tax
			lda TABLES.ColorTransformDn, x
			sta ZP.ColorUpdateIndex
			jsr ColorTile
			jmp !Exit+
		!NotDn:

			//Transform lt
			cmp #$03
			bne !NotLt+
			lda LEVEL.Data.Current, y
			and #$1f
			tax
			lda TABLES.TileLtTransform, x
			sta LEVEL.Data.Current, y
			tax
			lda TABLES.ColorTransformLt, x
			sta ZP.ColorUpdateIndex
			jsr ColorTile
			jmp !Exit+
		!NotLt:

			//Transform lt
			cmp #$04
			bne !NotRt+
			lda LEVEL.Data.Current, y
			and #$1f
			tax
			lda TABLES.TileRtTransform, x
			sta LEVEL.Data.Current, y
			tax
			lda TABLES.ColorTransformRt, x
			sta ZP.ColorUpdateIndex
			jsr ColorTile
			jmp !Exit+
		!NotRt:

			// lda #$04
			// sta LEVEL.Data.Current, y

			//Exit
			jmp !Exit+
		!NotBlank:


		!Exit:
			rts
	}

	ColorTile: {
			lda TABLES.TileToScreenLSB, y
			sta ZP.ColorTileVector + 0
			lda TABLES.TileToScreenMSB, y
			clc
			adc #>[COLOR_RAM - SCREEN_RAM]
			sta ZP.ColorTileVector + 1


			ldx ZP.PathColor
			lda TABLES.ItemColors, x
			sta ZP.ColorUpdateValue

			clc
			lda ZP.ColorUpdateIndex
			asl
			asl
			tax

		!loop:
			lda TABLES.ColorPatterns, x
			bmi !ExitLoop+
					
			ldy RecolorList.count
			sta RecolorList.index, y
			lda ZP.ColorTileVector + 0
			sta RecolorList.lsb, y
			lda ZP.ColorTileVector + 1
			sta RecolorList.msb, y
			lda ZP.ColorUpdateValue
			sta RecolorList.color, y
			inc RecolorList.count
			inx
			jmp !loop-
		!ExitLoop:

		!Exit:
			rts

	}

	DoRecolor: {
		// .break
			ldy #$00
		!:
			cpy RecolorList.count
			beq !Exit+

			lda RecolorList.lsb, y
			sta Mod + 1
			lda RecolorList.msb, y
			sta Mod + 2
			ldx RecolorList.index, y
			lda RecolorList.color, y
		Mod:
			sta $BEEF, x
			iny 
			jmp !-

		!Exit:
			ldy #$00
			sty RecolorList.count
			rts
	}	



	RecolorList: {
		count: 
			.byte $00
		lsb:
			.fill 256, 0
		msb:
			.fill 256, 0
		index:
			.fill 256, 0
		color:
			.fill 256, 0
	}


	ChimeIndex:
		.byte $00

	PlayChime: {
		lda ChimeIndex
		cmp #$04
		bcc !+
		lda #$03
	!:
		asl
		tax 
		ldy ChimeTable + 1, x       //Start address of sound effect data 
	    lda ChimeTable, x
	    ldx #14
	    jsr GAME.GetNextChannel
	   	jsr $1006

	   	inc ChimeIndex
	   	rts
	}
	
	ChimeTable:
		.word Chime1
		.word Chime2
		.word Chime3
		.word Chime4


	.var spksnd = LoadBinary("assets/spark.bin");
	.var spksnd2 = LoadBinary("assets/sparkoff.bin");
	Spark01:
		.fill spksnd.getSize(), spksnd.get(i) 	
	Spark02:
		.fill spksnd2.getSize(), spksnd2.get(i) 	

	.var c1 = LoadBinary("assets/target1.bin");
	.var c2 = LoadBinary("assets/target2.bin");
	.var c3 = LoadBinary("assets/target3.bin");
	.var c4 = LoadBinary("assets/target4.bin");

	Chime1:
		.fill c1.getSize(), c1.get(i) 	
	Chime2:
		.fill c2.getSize(), c2.get(i) 	
	Chime3:
		.fill c3.getSize(), c3.get(i) 	
	Chime4:
		.fill c4.getSize(), c4.get(i) 	
}