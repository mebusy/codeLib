// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

    @R0
    D=M
    @R1
    D=D-M  // M[R0] - M[R1]
    @INIT
    D;JGE

    // or swap
    @R0
    D=M   // D = M R0
    @temp
    M=D   // temp = M R0

    @R1
    D=M   // D = M R1
    @R0
    M=D    // M R0 = M R1

    @temp
    D=M
    @R1
    M=D 
    
(INIT)
    
    @R0
    D=M   // D = M R0
    @muland
    M=D  // muland= M R0
    
    @R1
    D=M   // D = M R1
    @n
    M=D   //  n = M R1 

    @R2
    M=0   // M[R2] =0
     
    // 
(LOOP)

    @n
    D=M
    @END
    D;JEQ  // n=0 , end
    
    // M R2 = M R2 + muland
    @muland
    D=M
    @R2
    M=D+M   
    
    // n --
    @n
    M=M-1
    
    @LOOP
    0;JMP

(END)
    @END
    0;JMP
