
from math import sqrt

def is_prime(n):
    if n == 1:
        return False
    for i in xrange(2, int(sqrt(n))+1):
        if n % i == 0:
            return False
    return True


if __name__ == "__main__" :
    for i in xrange( 15000,20000 ):
        if is_prime( i ):
            print "found prime:" , i 
            break 


