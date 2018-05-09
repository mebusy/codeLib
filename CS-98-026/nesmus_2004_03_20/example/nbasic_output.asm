nbasic_stack = 256
nesmus_pos = 0
nbasic_temp = 2
nesmus_start = 3
nesmus_end = 5
nesmus_stack = 7
nesmus_song_over = 9
nesmus_song = 10
a_pressed = 11
b_pressed = 12
a_inc = 13
b_inc = 14
spritenum = 15
spritex = 16
spritey = 17
temp = 18
number_to_draw = 19
nesmus_wait = 20
nesmus_temp = 21
nesmus_command = 22
nesmus_loop_count = 23
nesmus_bitmask = 24
joy1a = 25
joy1b = 26
joy1select = 27
joy1start = 28
joy1up = 29
joy1down = 30
joy1left = 31
joy1right = 32
	.inesprg 1 ;//one PRG bank
	.ineschr 1 ;//one CHR bank
	.inesmir 0 ;//mirroring type 0
	.inesmap 0 ;//memory mapper 0 (none)
	.org $8000
	.bank 0

music_pointers:
	.db low(music_data1),high(music_data1) ;//start of song 1
	.db low(music_data2),high(music_data2) ;//end of song 1
	.db low(music_data2),high(music_data2) ;//start of song 2
	.db low(music_data3),high(music_data3) ;//end of song 2

music_data1:
	.incbin "music/tomley.dat"
music_data2:
	.incbin "music/scale.dat"
music_data3:

start:
 jsr vwait
 lda #0
 sta 8192
 lda #28
 sta 8193
 jsr init_vars
 jsr vwait
 jsr load_palette
 lda #0
 sta nesmus_song_over
 lda #0
 sta nesmus_song
 jsr nesmus_load

mainloop:
 jsr joy_handler
 jsr vwait
 lda #1
 cmp nesmus_song_over
 bne nbasic_autolabel_1
 jsr swap_songs

nbasic_autolabel_1:
 jsr nesmus_loop
 jsr drawstuff
 jmp mainloop

swap_songs:
 inc nesmus_song
 lda #1
 and nesmus_song
 sta nesmus_song
 jsr nesmus_load
 lda #0
 sta nesmus_song_over
 rts

init_vars:
 lda #0
 sta a_pressed
 lda #0
 sta b_pressed
 lda #0
 sta a_inc
 lda #0
 sta b_inc
 lda #65
 sta spritenum
 lda #128
 sta spritex
 lda #120
 sta spritey
 rts

draw_debug:
 lda #60
 sta spritey
 lda #60
 sta spritex
 lda #45
 sta temp
 lda temp
 clc
 lsr a
 lsr a
 lsr a
 lsr a
 sta number_to_draw
 jsr draw_number
 lda #15
 and temp
 sta number_to_draw
 jsr draw_number
 rts

drawstuff:
 lda #0
 sta 8195
 lda #80
 sta spritey
 lda #80
 sta spritex
 lda nesmus_song
 sta number_to_draw
 jsr draw_number
 lda #90
 sta spritey
 lda #80
 sta spritex
 lda nesmus_loop_count
 sta number_to_draw
 jsr draw_number
 lda #100
 sta spritey
 lda #80
 sta spritex
 ldx #1
 lda nesmus_pos,x
 sta temp
 lda temp
 clc
 lsr a
 lsr a
 lsr a
 lsr a
 sta number_to_draw
 jsr draw_number
 lda #15
 and temp
 sta number_to_draw
 jsr draw_number
 ldx #0
 lda nesmus_pos,x
 sta temp
 lda temp
 clc
 lsr a
 lsr a
 lsr a
 lsr a
 sta number_to_draw
 jsr draw_number
 lda #15
 and temp
 sta number_to_draw
 jsr draw_number
 lda #110
 sta spritey
 lda #80
 sta spritex
 ldx #1
 lda nesmus_end,x
 sta temp
 lda temp
 clc
 lsr a
 lsr a
 lsr a
 lsr a
 sta number_to_draw
 jsr draw_number
 lda #15
 and temp
 sta number_to_draw
 jsr draw_number
 ldx #0
 lda nesmus_end,x
 sta temp
 lda temp
 clc
 lsr a
 lsr a
 lsr a
 lsr a
 sta number_to_draw
 jsr draw_number
 lda #15
 and temp
 sta number_to_draw
 jsr draw_number
 rts

draw_number:
 lda spritey
 sta 8196
 lda number_to_draw
 sta 8196
 lda #0
 sta 8196
 lda spritex
 sta 8196
 lda #8
 clc
 adc spritex
 sta spritex
 rts

joy_handler:
 jsr joystick1
 jsr incrementer
 lda joy1right
 clc
 adc spritex
 sta spritex
 lda spritex
 sec
 sbc joy1left
 sta spritex
 lda joy1down
 clc
 adc spritey
 sta spritey
 lda spritey
 sec
 sbc joy1up
 sta spritey
 lda a_inc
 clc
 adc spritenum
 sta spritenum
 lda spritenum
 sec
 sbc b_inc
 sta spritenum
 lda #1
 cmp joy1start
 bne nbasic_autolabel_2
 lda #128
 sta spritex
 lda #120
 sta spritey

nbasic_autolabel_2:
 rts

incrementer:
 lda #0
 sta a_inc
 lda #0
 cmp joy1a
 bne nbasic_autolabel_3
 lda #0
 sta a_pressed

nbasic_autolabel_3:
 lda #1
 cmp joy1a
 bne nbasic_autolabel_4
 lda #0
 cmp a_pressed
 bne nbasic_autolabel_5
 lda #1
 sta a_pressed
 lda #89
 cmp spritenum
 bcc nbasic_autolabel_6
 beq nbasic_autolabel_6
 lda #1
 sta a_inc

nbasic_autolabel_6:

nbasic_autolabel_5:

nbasic_autolabel_4:
 lda #0
 sta b_inc
 lda #0
 cmp joy1b
 bne nbasic_autolabel_7
 lda #0
 sta b_pressed

nbasic_autolabel_7:
 lda #1
 cmp joy1b
 bne nbasic_autolabel_8
 lda #0
 cmp b_pressed
 bne nbasic_autolabel_9
 lda #1
 sta b_pressed
 lda #65
 cmp spritenum
 bcs nbasic_autolabel_10
 lda #1
 sta b_inc

nbasic_autolabel_10:

nbasic_autolabel_9:

nbasic_autolabel_8:
 rts

load_palette:
 lda #63
 sta 8198
 lda #0
 sta 8198
 lda #14
 sta 8199
 lda #63
 sta 8198
 lda #17
 sta 8198
 lda #48
 sta 8199
 rts

nesmus_load:
 lda #0
 sta nesmus_wait
 lda #31
 sta 16405
 lda nesmus_song
 clc
 asl a
 asl a
 sta nesmus_temp
 ldx nesmus_temp
 lda music_pointers,x
 ldx #0
 sta nesmus_start,x
 ldx nesmus_temp
 lda music_pointers,x
 ldx #0
 sta nesmus_pos,x
 inc nesmus_temp
 ldx nesmus_temp
 lda music_pointers,x
 ldx #1
 sta nesmus_start,x
 ldx nesmus_temp
 lda music_pointers,x
 ldx #1
 sta nesmus_pos,x
 inc nesmus_temp
 ldx nesmus_temp
 lda music_pointers,x
 ldx #0
 sta nesmus_end,x
 inc nesmus_temp
 ldx nesmus_temp
 lda music_pointers,x
 ldx #1
 sta nesmus_end,x
 inc nesmus_temp
 rts

nesmus_loop:
 lda #0
 cmp nesmus_wait
 beq nbasic_autolabel_11
 dec nesmus_wait
 rts

nbasic_autolabel_11:
 ldx #1
 lda nesmus_start,x
 sta nesmus_temp
 lda nesmus_start
 cmp nesmus_pos
 bne nbasic_autolabel_12
 ldx #1
 lda nesmus_pos,x
 cmp nesmus_temp
 bne nbasic_autolabel_13
 jsr nesmus_shut_up

nbasic_autolabel_13:

nbasic_autolabel_12:
 ldx #1
 lda nesmus_end,x
 sta nesmus_temp
 lda nesmus_end
 cmp nesmus_pos
 bne nbasic_autolabel_14
 ldx #1
 lda nesmus_pos,x
 cmp nesmus_temp
 bne nbasic_autolabel_15
 jsr nesmus_restart_song
 rts

nbasic_autolabel_15:

nbasic_autolabel_14:
 ldy #0
 lda [nesmus_pos],y ;//get command byte
 sta nesmus_command
 iny
 lda #255
 cmp nesmus_command
 bne nbasic_autolabel_16
 jsr nesmus_startloop
 jmp nesmus_loop

nbasic_autolabel_16:
 lda #254
 cmp nesmus_command
 bne nbasic_autolabel_17
 jsr nesmus_endloop
 jmp nesmus_loop

nbasic_autolabel_17:
 jsr nesmus_playnote
 rts

nesmus_shut_up:
 lda #0
 sta 16384
 sta 16385
 sta 16386
 sta 16387
 sta 16388
 sta 16389
 sta 16390
 sta 16391
 sta 16392
 sta 16393
 sta 16394
 sta 16395
 sta 16396
 sta 16397
 sta 16398
 sta 16399
 rts

nesmus_restart_song:
 ldx #0
 lda nesmus_start,x
 ldx #0
 sta nesmus_pos,x
 ldx #1
 lda nesmus_start,x
 ldx #1
 sta nesmus_pos,x
 lda #0
 sta nesmus_wait
 lda #1
 sta nesmus_song_over
 ldy #0
 rts

nesmus_startloop:
 lda [nesmus_pos],y
 iny
 sta nesmus_loop_count
 jsr nesmus_inc_pointer
 lda nesmus_pos
 sta nesmus_stack
 ldx #1
 lda nesmus_pos,x
 sta nesmus_stack,x
 rts

nesmus_endloop:
 dec nesmus_loop_count
 lda #0
 cmp nesmus_loop_count
 bne nbasic_autolabel_18
 jsr nesmus_inc_pointer
 rts

nbasic_autolabel_18:
 lda nesmus_stack
 sta nesmus_pos
 ldx #1
 lda nesmus_stack,x
 sta nesmus_pos,x
 rts

nesmus_inc_pointer:
		tya
		sta nesmus_temp
		clc
		lda nesmus_pos
		adc nesmus_temp
		sta nesmus_pos
		lda nesmus_pos+1
		adc #0
		sta nesmus_pos+1
 rts

nesmus_playnote:
 lda nesmus_command
 sta nesmus_wait
 lda [nesmus_pos],y
 iny
 sta nesmus_bitmask
 lda #3
 and nesmus_bitmask
 cmp #0
 beq nbasic_autolabel_19
 jsr nesmus_channel_0

nbasic_autolabel_19:
 lda #12
 and nesmus_bitmask
 cmp #0
 beq nbasic_autolabel_20
 jsr nesmus_channel_1

nbasic_autolabel_20:
 lda #48
 and nesmus_bitmask
 cmp #0
 beq nbasic_autolabel_21
 jsr nesmus_channel_2

nbasic_autolabel_21:
 lda #192
 and nesmus_bitmask
 cmp #0
 beq nbasic_autolabel_22
 jsr nesmus_channel_3

nbasic_autolabel_22:
 jsr nesmus_inc_pointer
 rts

nesmus_channel_0:
 lda [nesmus_pos],y
 iny
 sta 16384
 lda [nesmus_pos],y
 iny
 sta 16385
 lda [nesmus_pos],y
 iny
 sta 16386
 lda [nesmus_pos],y
 iny
 sta 16387
 rts

nesmus_channel_1:
 lda [nesmus_pos],y
 iny
 sta 16388
 lda [nesmus_pos],y
 iny
 sta 16389
 lda [nesmus_pos],y
 iny
 sta 16390
 lda [nesmus_pos],y
 iny
 sta 16391
 rts

nesmus_channel_2:
 lda [nesmus_pos],y
 iny
 sta 16392
 lda [nesmus_pos],y
 iny
 sta 16393
 lda [nesmus_pos],y
 iny
 sta 16394
 lda [nesmus_pos],y
 iny
 sta 16395
 rts

nesmus_channel_3:
 lda [nesmus_pos],y
 iny
 sta 16396
 lda [nesmus_pos],y
 iny
 sta 16397
 lda [nesmus_pos],y
 iny
 sta 16398
 lda [nesmus_pos],y
 iny
 sta 16399
 rts

joystick1:
 lda #1
 sta 16406
 lda #0
 sta 16406
 lda 16406
 and #1
 sta joy1a
 lda 16406
 and #1
 sta joy1b
 lda 16406
 and #1
 sta joy1select
 lda 16406
 and #1
 sta joy1start
 lda 16406
 and #1
 sta joy1up
 lda 16406
 and #1
 sta joy1down
 lda 16406
 and #1
 sta joy1left
 lda 16406
 and #1
 sta joy1right
 rts

vwait:
		lda $2002
		bpl vwait ;//wait for start of retrace
	vwait_1:
		lda $2002
		bmi vwait_1 ;//wait for end of retrace
 lda #0
 sta 8197
 lda #0
 sta 8197
 lda #0
 sta 8198
 lda #0
 sta 8198
 rts
;//jump table points to NMI, Reset, and IRQ start points
	.bank 1
	.org $fffa
	.dw start, start, start
;//include CHR ROM
	.bank 2
	.org $0000
	.incbin "hex.chr"
	.incbin "hex.chr"

