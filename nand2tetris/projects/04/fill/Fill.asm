// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(START)

    @pixel
    M=0    //  set white pixel

    @KBD
    D=M
    
    @DRAW
    D; JEQ   // keep white , draw

    @pixel
    M=-1     // key pressed, set black pixel

(DRAW)

    @SCREEN
    D=A
    @pt
    M=D

(LOOP)
    
    @pt
    D=M
    @KBD
    D=D-A // pt - KBD  
    @ENDDRAW
    D;JGE  // pt -KBD >=0, end

    @pixel
    D=M     // get pixel 
    @pt
    A=M  // new M 
    M=D 
    
    @pt 
    M=M+1 

    @LOOP
    0;JMP

(ENDDRAW)
    
    
    @START
    0;JMP
    
