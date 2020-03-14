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

		lda #%00000010
		sta $d018
		lda $dd00
		and #%11111100
		sta $dd00

		cli

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

* = $1000 "Music"


* = $3000 "Code"
	#import "src/intro.asm"
	#import "src/game.asm"
	#import "src/level.asm"

* = $8000 "Level data"
	#import "assets/levels.asm"

* = $c800 "Font data"
	.import binary "assets/chars.bin"

* = $e000 "Tile data"
TILES:
	.import binary "assets/tiles.bin"
CHAR_COLORS:
	.import binary "assets/colors.bin"


