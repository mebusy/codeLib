// nesmus nbasic handler
// Version: March 20, 2004
//
// Usage:
// Music data is in the format created by the nesmus tool.
// You may have multiple songs in your ROM, and define each start and stop with an array.
//
// YOU MUST CREATE A LABEL NAMED music_pointers
// It should be data containing the start and end addresses of each of your songs
// Addresses are stored (low byte, high byte). Start address is the first byte of
// the song. End address is the first byte after the end of your song.
//
//
// To load a song, set the nesmus_song variable (first song is 0), then gosub load_music
// At each frame (assumed to be 30fps), you should gosub nesmus_loop. 
//
//
// Each time the song finishes and is ready to loop again, it will set the variable
// nesmus_song_over to 1. You can watch for this flag if you wish to execute an event
// at the end of the song. It is up to your program to reset it to any other value,
// such as 0, if you wish to use it.

array zeropage nesmus_pos 2		//current play position
array nesmus_start 2			//start byte of current song
array nesmus_end 2				//just past end byte of current song
array nesmus_stack 2			//hold position for repeats

//requires variable nesmus_song
nesmus_load:
	set nesmus_wait 0 //how many frames until the next music event
	set $4015 %00011111 //turn on the music channels

	//load start and current pointers
	set nesmus_temp << nesmus_song 2 //4 bytes per song
	set [nesmus_start 0] [music_pointers nesmus_temp]
	set [nesmus_pos 0] [music_pointers nesmus_temp]
	inc nesmus_temp
	set [nesmus_start 1] [music_pointers nesmus_temp]
	set [nesmus_pos 1] [music_pointers nesmus_temp]
	inc nesmus_temp

	//load end pointer
	set [nesmus_end 0] [music_pointers nesmus_temp]
	inc nesmus_temp
	set [nesmus_end 1] [music_pointers nesmus_temp]
	inc nesmus_temp

	return

nesmus_loop:
	if nesmus_wait <> 0 then //do nothing this frame
		dec nesmus_wait
		return
		endif

	//turn stuff off at start of song
	set nesmus_temp [nesmus_start 1]
	if nesmus_pos = nesmus_start
	if [nesmus_pos 1] = nesmus_temp
		gosub nesmus_shut_up

	//nbasic bug
	//if [nesmus_pos 0] = [nesmus_end 0]
	//if [nesmus_pos 1] = [nesmus_end 1] then

	// restarting the song will take an extra frame
	set nesmus_temp [nesmus_end 1]
	if nesmus_pos = nesmus_end
	if [nesmus_pos 1] = nesmus_temp then
			gosub nesmus_restart_song
			//goto nesmus_loop
			return
			endif

	set y 0
	asmline lda [nesmus_pos],y ;//get command byte
	set nesmus_command a
	inc y //ready for next command byte
	if nesmus_command = 255 then
		gosub nesmus_startloop //increments pointer for us
		goto nesmus_loop
		endif
	if nesmus_command = 254 then
		gosub nesmus_endloop
		//gosub nesmus_inc_pointer
		goto nesmus_loop
		endif
	gosub nesmus_playnote //increments pointer for us
	return

nesmus_shut_up:
	set a 0
	set $4000 a
	set $4001 a
	set $4002 a
	set $4003 a
	set $4004 a
	set $4005 a
	set $4006 a
	set $4007 a
	set $4008 a
	set $4009 a
	set $400a a
	set $400b a
	set $400c a
	set $400d a
	set $400e a
	set $400f a
	return

nesmus_restart_song:
	set [nesmus_pos 0] [nesmus_start 0]
	set [nesmus_pos 1] [nesmus_start 1]
	set nesmus_wait 0
	set nesmus_song_over 1
	set y 0
	return

nesmus_startloop:
	asmline lda [nesmus_pos],y
	inc y
	set nesmus_loop_count a
	gosub nesmus_inc_pointer

	set nesmus_stack nesmus_pos
	set x 1
	set [nesmus_stack x] [nesmus_pos x]
	return

nesmus_endloop:
	dec nesmus_loop_count
	if nesmus_loop_count = 0 then
		gosub nesmus_inc_pointer
		return
		endif
	set nesmus_pos nesmus_stack
	set x 1
	set [nesmus_pos x] [nesmus_stack x]
	return

//increment pointer based on value of y
nesmus_inc_pointer:
	asm
		tya
		sta nesmus_temp
		clc
		lda nesmus_pos
		adc nesmus_temp
		sta nesmus_pos
		lda nesmus_pos+1
		adc #0
		sta nesmus_pos+1
	endasm
	return

//coming into this function, nesmus_command holds the wait time,
//and y points to the bitmask
nesmus_playnote:
	set nesmus_wait nesmus_command
	asmline lda [nesmus_pos],y
	inc y
	set nesmus_bitmask a
	if & nesmus_bitmask %00000011 <> 0 gosub nesmus_channel_0
	if & nesmus_bitmask %00001100 <> 0 gosub nesmus_channel_1
	if & nesmus_bitmask %00110000 <> 0 gosub nesmus_channel_2
	if & nesmus_bitmask %11000000 <> 0 gosub nesmus_channel_3
	gosub nesmus_inc_pointer
	return

nesmus_channel_0:
	asmline lda [nesmus_pos],y
	inc y
	set $4000 a
	asmline lda [nesmus_pos],y
	inc y
	set $4001 a
	asmline lda [nesmus_pos],y
	inc y
	set $4002 a
	asmline lda [nesmus_pos],y
	inc y
	set $4003 a
	return

nesmus_channel_1:
	asmline lda [nesmus_pos],y
	inc y
	set $4004 a
	asmline lda [nesmus_pos],y
	inc y
	set $4005 a
	asmline lda [nesmus_pos],y
	inc y
	set $4006 a
	asmline lda [nesmus_pos],y
	inc y
	set $4007 a
	return

nesmus_channel_2:
	asmline lda [nesmus_pos],y
	inc y
	set $4008 a
	asmline lda [nesmus_pos],y
	inc y
	set $4009 a
	asmline lda [nesmus_pos],y
	inc y
	set $400a a
	asmline lda [nesmus_pos],y
	inc y
	set $400b a
	return

nesmus_channel_3:
	asmline lda [nesmus_pos],y
	inc y
	set $400c a
	asmline lda [nesmus_pos],y
	inc y
	set $400d a
	asmline lda [nesmus_pos],y
	inc y
	set $400e a
	asmline lda [nesmus_pos],y
	inc y
	set $400f a
	return
