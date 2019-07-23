



ram = [0] * 16384

heap_base = 2048

ram[ heap_base ] = 0 
ram[ heap_base + 1] = 16384 - 2048 - 2 


def alloc( size ):
    block_addr = None
    freeList = heap_base
    while True:
        nextBlock = ram[freeList]
        curBlockSize = ram[freeList+1] 
        if curBlockSize < size+2 :
            if nextBlock > 0 :
                freeList = nextBlock 
            else:
                assert False 
        else:
            block_addr = freeList + 2 + curBlockSize - (size+2) 
            ram[freeList+1] =  ram[freeList+1] - (size+2)

            ram[block_addr] = 0 
            ram[block_addr+1] = size
            return block_addr+2

    assert False 

def merge( addr1, addr2, addr3   ):
    block_addr = addr1 
    block_next = addr2 

    block_addr_2nd = addr2
    
    if block_addr + 2 + ram[block_addr+1] == ram[block_addr]:
        ram[block_addr] = ram[ram[block_addr]]
        ram[block_addr+1] = ram[block_addr+1] + ( ram[block_next+1]+2 )
        block_addr_2nd = block_addr
    
    if addr3 != 0 :
        block_addr = block_addr_2nd 
        block_next = addr3
        if block_addr + 2 + ram[block_addr+1] == ram[block_addr]:
            ram[block_addr] = ram[ram[block_addr]]
            ram[block_addr+1] = ram[block_addr+1] + ( ram[block_next+1]+2 )

    

def dealloc( o ):
    obj_addr = o-2 
    # obj_size = ram[obj_addr+1]

    freeList = heap_base
    while True:
        nextBlock = ram[freeList]
        # curBlockSize = ram[freeList+1] 

        b2Insert = False
        if nextBlock == 0:
            b2Insert = True 
        if nextBlock > 0:
            if obj_addr < nextBlock :
                b2Insert = True

        if b2Insert:
            ram[freeList] = obj_addr 
            ram[obj_addr] = nextBlock 

            merge( freeList, obj_addr , nextBlock  )

            return 
        else:
            freeList = nextBlock 



def printFreeList():
 
    freeList = heap_base
    while True:
        nextBlock = ram[freeList]

        print "free:", freeList , ram[freeList+1] + 2 
        if nextBlock > 0 :
            freeList = nextBlock 
        else:
            print "end"
            return 
    



if __name__ == '__main__':
    print "start:"
    printFreeList()
    test1 = [ 10 , 20 , 30, 40 , 50  ]
    objs = []
    for i, size in enumerate(test1):
        obj = alloc(size) 
        objs.insert( 0,obj )
        assert obj-2  == 16384 - sum( test1[:i+1]  ) - 2*( i+1)
    for obj in objs :
        print "obj: addr {}, size {}".format( obj-2, ram[obj-1] + 2   )
    printFreeList()

    dealloc( objs[2]  )
    printFreeList()
    dealloc( objs[3]  )
    printFreeList()
    dealloc( objs[4]  )
    printFreeList()

    dealloc( objs[0]  )
    printFreeList()
    dealloc( objs[1]  )
    printFreeList()

    from random import shuffle
    for _ in xrange(1000):
        shuffle(test1)
        objs = []
        for i in xrange(5):
            obj = alloc( test1[i] )
            objs.append( obj )
        shuffle( objs )
        for obj in objs  :
            dealloc( obj )

    assert ram[2048+1] == 14334



