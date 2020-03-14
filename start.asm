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

	JoyDirectionMapX:
		.byte 0,0,0,0,-1,0,0,0
		.byte 1,0,0,0,0,0,0,0

	JoyDirectionMapY:
		.byte 0,-1,1,0,0,0,0,0
		.byte 0,0,0,0,0,0,0,0

	SelectPositionX:
		.fill 10, $18 + $18 * i
	SelectPositionY:
		.fill 10, $29 + $18 * i
}


* = $1000 "Music"


* = $3000 "Code"
	#import "src/intro.asm"
	#import "src/game.asm"
	#import "src/level.asm"
	#import "src/control.asm"
	#import "src/irq.asm"

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


