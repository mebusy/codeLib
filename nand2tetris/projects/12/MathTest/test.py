


def multiply(x,y):
    s = 0 
    shiftX = x 
    for i in xrange(16):
        if y & (1<<i) != 0  :
            s = s + shiftX 
        shiftX = shiftX + shiftX 
    return s


# python code in Jack mana
def sqrt( x ) :
    y = 0 
    n = 0 
    while x >= 2**n  :
        n += 1

    j = n/2 
    while j >=0 :
        tmp = (y+ (2**j)) * (y+ (2**j)) 
        if tmp > 0 :
            if tmp <= x :
                y = y + (2**j)
        j = j-1
    return y


for i in xrange( 50 ) :
    r = sqrt( i )  
    print "~~~~" , i, r 


