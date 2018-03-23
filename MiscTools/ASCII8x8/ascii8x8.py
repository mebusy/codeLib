
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw
import sys



def list2byte( l ) :
    assert len(l) == ASCII_SIZE 
    val = 0
    for i,v in enumerate( l ) :
        assert v == 0 or v == 255
        val +=  ( 0 if v == 0 else 1 ) << i 

    return val 

def drawInCanvasWithSize( nSize , ch , offx_plus = 0 , offy_plus = 0) :
    im = Image.new( "1" , ( nSize ,nSize ) ) 
    draw = ImageDraw.Draw(im)
    off = (nSize - ASCII_SIZE)/2
    draw.text( ( off+offx_plus, off+offy_plus   ) , ch , fill="#FFFFFF",font=font )
    data = list(im.getdata())

    # find the bound rectangle 
    l = t = nSize
    r = b = 0
    for j in xrange (nSize) :
        for i in xrange(nSize) :
            v = data[ j*nSize + i ]
            assert v == 0 or v == 255

            if v == 255:
                if i < l :
                    l = i 
                if i > r :
                    r = i 
                if j < t :
                    t = j 
                if j > b :
                    b = j

    # print l,t,r,b
    if l > r or t > b :
        l = t = 0
        r = b = ASCII_SIZE

    w = ( r-l+1 ) 
    h = ( b-t+1 )

    marginx = (ASCII_SIZE-w)//2  
    marginy = ((ASCII_SIZE-h)//2)

    return (w, h, marginx, marginy  )  , im , marginx - l, marginy - t 

def render( code ) :
    ch = chr(code)
    out = []

    # fake draw 
    info, _,_,_   = drawInCanvasWithSize( ASCII_SIZE * 2 , ch  )
    # true draw
    TEST_RANGE = ASCII_SIZE/4 
    for j in xrange( -TEST_RANGE, TEST_RANGE+1, 1 ) :
        for i in xrange( -TEST_RANGE, TEST_RANGE+1, 1 ) :
            _info, im, offx, offy  = drawInCanvasWithSize( ASCII_SIZE , ch, i,j ) 
            if info == _info :
                _info, im,_,_  = drawInCanvasWithSize( ASCII_SIZE , ch,  i+offx, j+offy   ) 
                # im.show()
                data = list(im.getdata())
                for i in xrange( ASCII_SIZE ):
                    out.append( list2byte( data[ i*ASCII_SIZE:i*ASCII_SIZE+ASCII_SIZE ]  )) 
                return out 
    raise Exception( "draw failed" )

    return None


if __name__ == "__main__":
    print "* render ascii character into dot matrix"
    print "* in size of 8x8, 16x16, 32x32, so on and so forth\n "

    ASCII_SIZE = 8
    if len(sys.argv) > 1:
        size = int( sys.argv[1] )
        ASCII_SIZE = size
        assert ASCII_SIZE % 8 == 0  , "must be multiple of 8"

    font = ImageFont.truetype("/Library/Fonts/Microsoft/Verdana.ttf", ASCII_SIZE )
        
    all_cap_letters = []
    for i in xrange( ord('A') , ord('Z')+1  ):
        all_cap_letters += render( i ) 
    print all_cap_letters , len( all_cap_letters )
    print 'done'




