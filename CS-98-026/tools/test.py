
C = 0 
A = 0

def ASL( n ) :
    global C 
    b7 = (n >> 7) & 0x1
    n = (n << 1) & ( 0xFE ) 
    C = b7
    return n  

def ROL( n) :
    global C 
    b7 =  (n >> 7) & 0x1 
    n = ( ( n << 1 ) & ( 0xFF ) )  | C 
    C = b7
    return n 

def ROL_():
    global A
    A = ROL(A)
    return A 

def EOR( n ):
    global A 
    A = A ^ n 
    
    
def F1_e96b_random( _2e = 0 , _2f = 0  ):
    global A 
    _2e = ASL( _2e )
    _2f = ROL( _2f ) 
    ROL_()
    ROL_()
    EOR( _2e  )
    ROL_()
    EOR( _2e  )
    LSR_()
    LSR_()
    
    
