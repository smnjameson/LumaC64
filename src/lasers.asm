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

	* =* "PATH"
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
		color:
			.fill 32, 0
	}

	Init: {
			lda #$00
			sta Active
			sta Tracing
			sta Complete
			sta Path.count
			rts
	}

	ClearIfNeeded: {
			//TODO
			lda #$00
			sta Active
			sta Tracing
			sta Complete
			sta Path.count

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
			lda Active
			bne !+
			
			jsr TrackActiveLasers
			inc Active
		!:
			jsr TraceLasers
			lda #$01
			sta Tracing

			rts
	}

	TraceLasers: {
			lda IRQ.Timer
			and #$01
			beq !+
			rts
		!:
			// rts 
			ldx #$00
		!loop:
			txa
			pha
			lda Path.terminated, x
			beq !+
			jmp !Next+ 
		!:
			cpx Path.count
			bcc !+
			jmp !Next+ 
		!:

			//Advance laser path
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
			bmi !Terminate+
			cmp #$0a
			bcs !Terminate+
			lda Path.y, x
			bmi !Terminate+
			cmp #$08
			bcs !Terminate+	

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
				lda LEVEL.Data.Current, y
				and #$1f
				tax
				lda TABLES.HorizPassable, x
				cmp #$01
				jmp !Done+
			!Vert:
				lda LEVEL.Data.Current, y
				and #$1f
				tax
				lda TABLES.VertPassable, x
				cmp #$01
			!Done:
			ldx ZP.LaserDirTemp
			bcc !Terminate+

				//Update new tile
				jsr UpdateTile
		
			jmp !Next+


		!Terminate:	
			lda #$01
			sta Path.terminated, x

		!Next:
			pla
			tax
			inx
			cpx Path.count
			bne !loop-

			rts
	}

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
			tax
			lda TABLES.TileUpTransform, x
			sta LEVEL.Data.Current, y
			jmp !Exit+
		!NotUp:

			//Transform dn
			cmp #$02
			bne !NotDn+
			lda LEVEL.Data.Current, y
			tax
			lda TABLES.TileDnTransform, x
			sta LEVEL.Data.Current, y
			jmp !Exit+
		!NotDn:

			//Transform lt
			cmp #$03
			bne !NotLt+
			lda LEVEL.Data.Current, y
			tax
			lda TABLES.TileLtTransform, x
			sta LEVEL.Data.Current, y
			jmp !Exit+
		!NotLt:

			//Transform lt
			cmp #$04
			bne !NotRt+
			lda LEVEL.Data.Current, y
			tax
			lda TABLES.TileRtTransform, x
			sta LEVEL.Data.Current, y
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
}