
//file footer
asm
;//jump table points to NMI, Reset, and IRQ start points
	.bank 1
	.org $fffa
	.dw start, start, start
;//include CHR ROM
	.bank 2
	.org $0000
	.incbin "hex.chr"
	.incbin "hex.chr"
endasm
