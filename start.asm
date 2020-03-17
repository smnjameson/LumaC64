/*
 $0800 Init code and util routines
 $1000 Music
 $3000 CODE
 $8000 Levels (24k)
 $c000 SCREEN RAM
 $c800 Font
 $d000 Sprites
 $e000 Tile & color data

*/

//Constants
.label SCREEN_RAM = $c000
.label SPRITE_POINTER = SCREEN_RAM + $03f8
.label COLOR_RAM = $d800

#import "src/zp.asm"

BasicUpstart2(Entry)
Entry: {
		sei

		lda #$7f
		sta $dc0d
		sta $dd0d

		lda #$35
		sta $01

		lda #$00
		sta $d020
		sta $d021

		lda $d016
		ora #%00010000
		sta $d016

		lda #$0b
		sta $d022
		lda #$0c
		sta $d023

		lda #%00000010
		sta $d018
		lda $dd00
		and #%11111100
		sta $dd00

		cli

		lda #$00	//Initialise music
		jsr $1000

		jsr IRQ.Init
		jmp INTRO.Start
}

* = * "Utility functions and tables"
ClearScreen: {
		//Fill screen with value in accumulator color from X register
		ldy #$fa
	!Loop:
		sta SCREEN_RAM - 001, y
		sta SCREEN_RAM + 249, y
		sta SCREEN_RAM + 499, y
		sta SCREEN_RAM + 749, y
		dey
		bne !Loop-

		txa
		ldy #$fa
	!Loop:
		sta COLOR_RAM - 001, y
		sta COLOR_RAM + 249, y
		sta COLOR_RAM + 499, y
		sta COLOR_RAM + 749, y
		dey
		bne !Loop-
		rts		
}


TABLES: {
	TileToScreenLSB:
		.for(var i=0; i< 80; i++) {
			.var x = mod(i,10)
			.var y = floor(i/10)
			.byte <[SCREEN_RAM + y * $78 + x * 3]
		}
	TileToScreenMSB:
		.for(var i=0; i< 80; i++) {
			.var x = mod(i,10)
			.var y = floor(i/10)
			.byte >[SCREEN_RAM + y * $78 + x * 3]
		}	
	TileScreenOffsets:
		.byte 0,1,2,40,41,42,80,81,82

	TileDataOffsetsLSB:
		.fill 32, <[TILES + i * 9]
	TileDataOffsetsMSB:
		.fill 32, >[TILES + i * 9]

	Times10:
		.fill 8, i*10
	ItemToTileMap:
		.byte $01, $08, $16, $1c, $1a
		.byte $11, $12, $13, $14
		.byte $11, $12, $13, $14
		.byte $11, $12, $13, $14
		.byte $15, $0d, $09, $1e, $1e, $1e 
	ItemColorMap:
		.byte 0,0,0,0,0
		.byte 128,128,128,128
		.byte 192,192,192,192
		.byte 64,64,64,64
		.byte 0,0,0
		.byte 64,128,192
	ItemColors:
		.byte 00,10,13,14

	MoveableTileMap:
		.byte 0,0,0,0,0,0,0,0
		.byte 0,1,1,1,1,1,1,1
		.byte 1,1,1,1,1,1,0,0
		.byte 0,0,0,0,0,0,0,0

	TileToSpriteMap:
		.byte 0,0,0,0,0,0,0,0,0
		.byte $42,$42,$42,$42	//Mirror /
		.byte $44,$44,$44,$44	//Mirror \
		.byte $46,$48,$4a,$4c	//Lasers W-E-N-S
		.byte $4e				//Battery
		.byte 0,0,0,0,0,0,0,0,0,0

	LaserDirToJoyDir:
		.byte 4,8,1,2

	JoyDirectionMapX:
		.byte 0,0,0,0,-1,0,0,0
		.byte 1,0,0,0,0,0,0,0

	JoyDirectionMapY:
		.byte 0,-1,1,0,0,0,0,0
		.byte 0,0,0,0,0,0,0,0

	SelectPositionX:
		.fill 10, $18 + $18 * i
	SelectPositionY:
		.fill 8, $29 + $18 * i

	ValidDirections:
		.byte $a,$e,$e,$e,$e,$e,$e,$e,$e,$6
		.byte $b,$f,$f,$f,$f,$f,$f,$f,$f,$7
		.byte $b,$f,$f,$f,$f,$f,$f,$f,$f,$7
		.byte $b,$f,$f,$f,$f,$f,$f,$f,$f,$7
		.byte $b,$f,$f,$f,$f,$f,$f,$f,$f,$7
		.byte $b,$f,$f,$f,$f,$f,$f,$f,$f,$7
		.byte $b,$f,$f,$f,$f,$f,$f,$f,$f,$7
		.byte $9,$d,$d,$d,$d,$d,$d,$d,$d,$5

	IndexToX:
		.fill 10, i
		.fill 10, i
		.fill 10, i
		.fill 10, i
		.fill 10, i
		.fill 10, i
		.fill 10, i
		.fill 10, i

	IndexToY:
		.for(var j=0; j<8; j++) {
			.fill 10, j
		}

	VertPassableUp:
		.byte 1,1,0,1,0,1,1,1
		.byte 0,1,1,0,0,1,1,0
		.byte 0,0,0,0,0,0,1,1
		.byte 0,0,1,0,0,0,255,255

	VertPassableDn:
		.byte 1,1,0,1,0,1,1,1
		.byte 0,1,0,1,0,1,0,1
		.byte 0,0,0,0,0,0,1,1
		.byte 0,0,1,0,0,0,255,255

	HorizPassableLt:
		.byte 1,1,1,0,0,1,1,1
		.byte 0,1,1,0,0,1,0,1
		.byte 0,0,0,0,0,0,1,0
		.byte 1,0,0,0,1,0,255,255

	HorizPassableRt:
		.byte 1,1,1,0,0,1,1,1
		.byte 0,1,0,1,0,1,1,0
		.byte 0,0,0,0,0,0,1,0
		.byte 1,0,0,0,1,0,255,255

	CanSpark:
		.byte 0,0,1,1,1,0,0,0
		.byte 1,1,1,1,1,1,1,1
		.byte 1,0,0,0,0,0,0,0
		.byte 0,0,1,1,1,1,0,0

	MirrorReflectBack:
		.byte 0,4,8,0
		.byte 1,0,0,0
		.byte 2,0,0,0
		.byte 0,0,0,0

	MirrorReflectForward:
		.byte 0,8,4,0
		.byte 2,0,0,0
		.byte 1,0,0,0
		.byte 0,0,0,0

	JoyToDirIndex:
		.byte 0,1,2,0
		.byte 3,0,0,0
		.byte 4,0,0,0
		.byte 0,0,0,0

	TileUpTransform:
		.byte $02,$02,$02,$04,$04,$02,$02,$02
		.byte $08,$0a,$0a,$0c,$0c,$0e,$0e,$10
		.byte $10,$11,$12,$13,$14,$15,$18,$19
		.byte $18,$19,$1b,$1b,$1c,$1d,$1e,$1f
	TileDnTransform:
		.byte $02,$02,$02,$04,$04,$02,$02,$02
		.byte $08,$0b,$0c,$0b,$0c,$0f,$10,$0f
		.byte $10,$11,$12,$13,$14,$15,$18,$19
		.byte $18,$19,$1b,$1b,$1c,$1d,$1e,$1f
	TileLtTransform:
		.byte $03,$03,$04,$03,$04,$03,$03,$03
		.byte $08,$0a,$0a,$0c,$0c,$0f,$10,$0f
		.byte $10,$11,$12,$13,$14,$15,$17,$17
		.byte $19,$19,$1a,$1b,$1d,$1d,$1e,$1f
	TileRtTransform:
		.byte $03,$03,$04,$03,$04,$03,$03,$03
		.byte $08,$0b,$0c,$0b,$0c,$0e,$0e,$10
		.byte $10,$11,$12,$13,$14,$15,$17,$17
		.byte $19,$19,$1a,$1b,$1d,$1d,$1e,$1f

	TileClearValue:
		.byte $00,$01,$01,$01,$01,$01,$01,$01
		.byte $08,$09,$09,$09,$09,$0d,$0d,$0d
		.byte $0d,$11,$12,$13,$14,$15,$16,$16
		.byte $16,$16,$1a,$1a,$1c,$1c,$1e,$1f

	SparkOffsetX:
		.byte $0c, $00, $f4
	SparkOffsetY:
		.byte $17, $00, $fe
	//COLOR PATTERNS
	//1 	.|.
	//		.|.
	//		.|.
	
	//2		...
	//		---
	//		...
	
	//3		.|.
	//		...
	//		.|.

	//4		.|.
	//		-..
	//		...

	//5		...
	//		-..
	//		.|.

	//6		...
	//		..-
	//		.|.

	//7		.|.
	//		..-
	//		...


	ColorTransformUp:
		.byte 0,0,1,0,3,0,0,0
		.byte 0,0,4,0,4,0,7,0
		.byte 7,0,0,0,0,0,0,0
		.byte 1,3,0,1,2,2,2,2  //DEBUG: unique code here last 4

	ColorTransformDn:
		.byte 0,0,1,0,3,0,0,0
		.byte 0,0,0,6,6,0,0,5
		.byte 5,0,0,0,0,0,0,0
		.byte 1,3,0,1,0,0,0,0
	ColorTransformLt:
		.byte 0,0,0,2,2,0,0,0
		.byte 0,0,4,0,4,0,0,5
		.byte 5,0,0,0,0,0,0,2
		.byte 0,2,0,0,0,2,0,0
	ColorTransformRt:
		.byte 0,0,0,2,2,0,0,0
		.byte 0,0,0,6,6,0,7,0
		.byte 7,0,0,0,0,0,0,2
		.byte 0,2,0,0,0,2,0,0

	ColorPatterns:
		.byte 255,255,255,255
		.byte 1,41,81,255
		.byte 40,41,42,255
		.byte 1,81,255,255

		.byte 1,40,255,255
		.byte 40,81,255,255
		.byte 42,81,255,255
		.byte 1,42,255,255

		.byte 40,42,255,255

	ColorAntiPatterns:
		.byte 0,8,3,2,6,7,4,5,1
}


* = $1000 "Music"
	.var music = LoadBinary("assets/LumaMusic2.prg", BF_C64FILE)
	.fill music.getSize(), music.get(i)

* = $3000 "Code"
	#import "src/intro.asm"
	#import "src/game.asm"
	#import "src/level.asm"
	#import "src/control.asm"
	#import "src/irq.asm"
	#import "src/lasers.asm"
	#import "src/hud.asm"
	#import "src/keyboard.asm"
	#import "src/messages.asm"

* = $8000 "Level data"
	#import "assets/levels.asm"

* = $c800 "Font data"
	.import binary "assets/chars.bin"

* = $d000 "Sprites"
	.import binary "assets/sprites.bin"

* = $e000 "Tile data"
TILES:
	.import binary "assets/tiles.bin"
CHAR_COLORS:
	.import binary "assets/colors.bin"
HUD_MAP:
	.import binary "assets/hud.bin"


