from pymouse import PyMouse
from pykeyboard import PyKeyboard
import time

m = PyMouse()
k = PyKeyboard()


x_dim, y_dim = m.screen_size()

# m.click(x_dim/2, y_dim/2, 1)
# k.type_string('Hello, World!')

def tower():
    m.click( 290, y_dim/2+200, 1) 
    time.sleep(1)
    m.click( 290, y_dim/2+180, 1) 

def country():
    m.click( 480, y_dim/2+180, 1)
    time.sleep(2)
    m.click( 320, y_dim/2 + 100, 1)
    time.sleep(15)
    m.click( 430, y_dim*0.67, 1)  #  skip
    time.sleep(2)
    m.click( 290, y_dim*0.67, 1)  #  skip

def legendInstance():
    time.sleep(1)
    m.click( 410, y_dim*.86 , 1)
    # time.sleep( 3 )




while True:
    current_time = time.localtime()
    stamp = time.strftime('%Y-%m-%d-%H:%M:%S', current_time)
    print stamp
    
    start_time = "2018-10-12-23:12:00"
    # start_time = "2018-10-13-00:01:00"

    if stamp > start_time :
        print 'start battle '
        m.click( 60, y_dim - 20, 1)
        time.sleep( 0.1 )
        # m.click( 290, y_dim/2+50, 1)  # battle wild BOSS
        # m.click( 290+50, y_dim/2+50, 1)  # battle guild
        # m.click( 290, y_dim/2+250, 1)  # nation battle
        # m.click( 290, y_dim/2+125, 1); time.sleep(25)  # lv bu
        # m.click( 290, y_dim/2+50, 1); time.sleep(25)  # huang cheng
        # tower()
        country()
        # legendInstance()
        time.sleep( 3 )
        m.click( 430, y_dim*0.67, 1)  #  skip
        time.sleep( 2 )
        m.click( 430, y_dim*0.8, 1)  #  skip
        time.sleep( 2 )
    else:
        print '__waiting ... ' ,  start_time
        time.sleep( 5 )


print 'done'
