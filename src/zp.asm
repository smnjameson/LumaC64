* = $02 virtual
ZP: {
	LevelPointer:		.word $0000
	LevelDataVector: 	.word $0000
	LevelTemp:			.byte $00, $00, $00
	LevelDataIndex:		.byte $00
	LevelColorTemp:		.byte $00
	LevelShadowTemp:	.byte $00

	Joystick:			.byte $00

	SlideMoveCount:		.byte $00
	SlideCheckPosX: 	.byte $00
	SlideCheckPosY: 	.byte $00
	SlideTemp: 			.byte $00
	SlideIndex:			.byte $00

	DirCheck:			.byte $00
	LaserDirTemp:		.byte $00, $00
	MirrorDirTemp:		.byte $00, $00
	MirrorTileIndex: 	.byte $00

	HudCharTemp:		.byte $00
}	