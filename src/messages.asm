MESSAGES: {

	data: {
		lookup:
			.word complete
			.word outofmoves
			.word tutor1
			.word tutor2
			.word tutor3
			.word tutor4
			.word tutor5
			.word tutor6
			.word tutor7
		complete:
			.byte $50,$50,$ff	//X,Y, X arrow offset ($ff == 0ff)
			.byte $5c,$5d,$5e,$5f //Foreground
			.byte $7c,$7d,$7d,$7e //Background
		outofmoves:
		tutor1:
		tutor2:
		tutor3:
		tutor4:
		tutor5:
		tutor6:
		tutor7:
	}	

	messageDisplayed:
		.byte $ff

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
			asl
			tax
			lda data.lookup, X
			sta ZP.MessageVector + 0
			inx
			lda data.lookup, X
			sta ZP.MessageVector + 1

			lda #$ff
			sta $d015
			lda #$00
			sta $d01c

			ldy #$03
			ldx #$00
		!:
			lda (ZP.MessageVector), y 
			sta SPRITE_POINTER, x 
			iny
			inx
			cpx #$08
			bne !-


			ldy #$00
			ldx #$00
			lda (ZP.MessageVector), y 
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
			sta $d001
			sta $d003
			sta $d005
			sta $d007
			sta $d009
			sta $d00b
			sta $d00d
			sta $d00f


			lda #$01
			sta $d027
			sta $d028
			sta $d029
			sta $d02a
			lda #$0b
			sta $d02b
			sta $d02c
			sta $d02d
			sta $d02e
			rts
	}
}