//this var is used by the music stuff
array nbasic_temp 1

//the header defined that right here is $8000
//i'm setting the romstart var in music.bas to this address
music_pointers:
	asm
	.db low(music_data1),high(music_data1) ;//start of song 1
	.db low(music_data2),high(music_data2) ;//end of song 1
	.db low(music_data2),high(music_data2) ;//start of song 2
	.db low(music_data3),high(music_data3) ;//end of song 2

music_data1:
	.incbin "music/tomley.dat"
music_data2:
	.incbin "music/scale.dat"
music_data3:
	endasm


//the program starts here on NES boot (see footer)
start:
	gosub vwait
	set $2000 %00000000
	set $2001 %00011100 //sprites and bg visible, no sprite clipping
	gosub init_vars
	gosub vwait
	gosub load_palette
	set nesmus_song_over 0
	set nesmus_song 0
	gosub nesmus_load
//the main program loop
mainloop:
	gosub joy_handler
	gosub vwait
	if nesmus_song_over = 1
		gosub swap_songs
	gosub nesmus_loop //called each frame to update music
	gosub drawstuff
	goto mainloop

swap_songs:
	inc nesmus_song
	set nesmus_song & nesmus_song 1 //swap between 0 and 1
	gosub nesmus_load
	set nesmus_song_over 0
	return

//set default sprite location
init_vars:
	set a_pressed 0
	set b_pressed 0
	set a_inc 0
	set b_inc 0
	set spritenum 65
	set spritex 128
	set spritey 120
	return

draw_debug:
	set spritey 60
	set spritex 60
	set temp $2d
	set number_to_draw >> temp 4
	gosub draw_number
	set number_to_draw & temp %1111 
	gosub draw_number
	return

//routine to draw a sprite
drawstuff:
	set $2003 0
	//gosub draw_debug

	//draw current song
	set spritey 80
	set spritex 80
	set number_to_draw nesmus_song
	gosub draw_number 
	//draw current loop counter
	set spritey 90
	set spritex 80
	set number_to_draw nesmus_loop_count
	gosub draw_number

	//draw current music pos
	set spritey 100
	set spritex 80
	set temp [nesmus_pos 1] //high byte
	set number_to_draw >> temp 4
	gosub draw_number
	set number_to_draw & temp %1111 
	gosub draw_number
	set temp [nesmus_pos 0] //low byte
	set number_to_draw >> temp 4
	gosub draw_number
	set number_to_draw & temp %1111 
	gosub draw_number
	
	//draw music end pos
	set spritey 110
	set spritex 80
	set temp [nesmus_end 1] //high byte
	set number_to_draw >> temp 4
	gosub draw_number
	set number_to_draw & temp %1111 
	gosub draw_number
	set temp [nesmus_end 0] //low byte
	set number_to_draw >> temp 4
	gosub draw_number
	set number_to_draw & temp %1111 
	gosub draw_number
	return

draw_number:
	set $2004 spritey
	set $2004 number_to_draw
	set $2004 0
	set $2004 spritex
	set spritex + spritex 8
	return

//move sprite based on joystick input
joy_handler:
	gosub joystick1
	gosub incrementer
	set spritex + spritex joy1right
	set spritex - spritex joy1left
	set spritey + spritey joy1down
	set spritey - spritey joy1up
	set spritenum + spritenum a_inc
	set spritenum - spritenum b_inc
	if joy1start = 1 then
		set spritex 128
		set spritey 120
		endif
	return

//handle press and release of A/B buttons
incrementer:
	//handle A button
	set a_inc 0
	if joy1a = 0 set a_pressed 0
	if joy1a = 1 if a_pressed = 0 then
		set a_pressed 1
		if spritenum < 89  set a_inc 1
		endif
	//handle B button
	set b_inc 0
	if joy1b = 0 set b_pressed 0
	if joy1b = 1 if b_pressed = 0 then
		set b_pressed 1
		if spritenum > 65  set b_inc 1
		endif
	return

//load the colors
load_palette:
	//set the PPU start address (background color 0)
	set $2006 $3f
	set $2006 0
	set $2007 $0e //set base color black
	//set the PPU start address (foreground color 1)
	set $2006 $3f
	set $2006 $11
	set $2007 $30 //set fg color 1 white
	return	

