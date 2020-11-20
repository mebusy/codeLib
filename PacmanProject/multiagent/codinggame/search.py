#!/usr/local/bin/python3
import time

import heapq

class PriorityQueue:
    def  __init__(self):
        self.heap = []
        self.count = 0

    def push(self, item, priority):
        # self.count is added for stable ?
        entry = (priority, self.count, item)
        heapq.heappush(self.heap, entry)
        self.count += 1

    def pop(self):
        return heapq.heappop(self.heap)[-1]

    def isEmpty(self):
        return len(self.heap) == 0


def graphSearch( problem, fringe):

    closed = {}
    nExpand = 0

    def buildPath( last_path_info ) :
        ret = []
        while last_path_info[0] is not None:
            ret.append( last_path_info[1:] )
            last_path_info = closed[ last_path_info[0] ]
        ret.reverse()
        return ret



    # node is a tuple: ( state , (parentState,action)  , cumulate cost )
    fringe.push( (problem.getStartState(),(None,None), 0 ), 
        0 + problem.getHeuristic( problem.getStartState() ) )
    while True:
        # test
        if fringe.isEmpty():
            return []
        state , path_info  , costs  = fringe.pop()
        if problem.isGoalState(state):
            print( "nExpand", nExpand )# , file=sys.stderr, flush=True)
            return buildPath( path_info )

        # print state , " -> "
        # expand
        if state.ToString() not in closed :
            closed[state.ToString()] = path_info
            for sucState , action, cast_times, cost  in problem.getSuccessors( state ):
                fringe.push( ( sucState , (state.ToString(),action, cast_times ) , costs + cost ),
                    costs + cost + problem.getHeuristic( sucState )  )
                nExpand += 1
                # print "\t <- " , sucState

    return []


class Problem(object):
    def __init__(self, startState, goalState, spells, spell_ids, spell_repeatable):
        self.startState = startState
        self.goalState = goalState
        self.spells = spells
        self.spell_ids = spell_ids
        self.spell_repeatable = spell_repeatable
        self.nSpell = len( spells )
        self.ALL_CASTABLE = (1,) * self.nSpell

    def getStartState(self):
        return self.startState
    def getGoalState(self):
        return self.goalState
    def getHeuristic(self, state):
        h = 0
        for i in range(4 ):
            v = state.ingredients[i] - self.goalState.ingredients[i]
            if v < 0:
                h += -v * (1)
        return h
    def isGoalState(self, state):
        for i in range(4 ):
            v = state.ingredients[i] - self.goalState.ingredients[i]
            if v < 0:
                return False
        return True
    def getSuccessors( self, state ):
        suc = []

        # action REST -1
        # if state.spell_castable.sum() < self.nSpell  : # NEW
        if not all( state.spell_castable ):
            suc.append( ( State( state.ingredients, self.ALL_CASTABLE ), -1,1, 1 ) )

        # other spell
        ingredients = [0,0,0,0]
        for i,spell in enumerate( self.spells ):
            if state.spell_castable[i]:
                max_cast_times = self.spell_repeatable[i] and 10 or 1
                for j in range(max_cast_times):
                    hasNegative = False
                    # ingredients = [state.ingredients[ii] + spell[ii]*(j+1) for ii in range(4) ]
                    ingredients[0] = state.ingredients[0] + spell[0]*(j+1)
                    ingredients[1] = state.ingredients[1] + spell[1]*(j+1)
                    ingredients[2] = state.ingredients[2] + spell[2]*(j+1)
                    ingredients[3] = state.ingredients[3] + spell[3]*(j+1)
                    for v in ingredients:
                        if v < 0:
                            hasNegative = True
                            break
                    # print( state.ingredients , spell,  ingredients , sum( ingredients ) )
                    if sum( ingredients ) <= 10 and not hasNegative :
                        suc.append( (State( ingredients, state.spell_castable[:i]+ (False,) +state.spell_castable[i+1:]  ),self.spell_ids[i], j+1,  1 ))
                    else:
                        break
        return suc

        


class State(object):
    def __init__(self, ingredients, spell_castable ):
        # all positive
        self.ingredients = tuple(ingredients)
        self.spell_castable = tuple(spell_castable)
        self.key = (self.ingredients + self.spell_castable).__hash__()
        # print(self.ToString())
    def ToString(self):
        return self.key



if __name__ == '__main__':
    start = time.time()

    for _ in range(1):
        fringe = PriorityQueue()

        spells = [(2, 0, 0, 0), (-1, 1, 0, 0), (0, -1, 1, 0), (0, 0, -1, 1), (2, -2, 0, 1), (-3, 0, 0, 1), (-3, 1, 1, 0), (-5, 0, 3, 0), (0, 0, 2, -1), (3, 0, 1, -1), (1, 1, 1, -1), (3, -2, 1, 0), (0, 2, -2, 1), (0, -2, 2, 0)]
        spell_ids = [1+i for i in range( len(spells) ) ]
        spell_repeatable = [False, False, False, False, True, True, True, True, True, True, True, True, True, True]
        nSpell = len(spells)
        problem = Problem( 
            State((3,0,0,0), (True,)*nSpell), 
            State((2,2,0,2), (True,)*nSpell),
            tuple( spells), 
            tuple(spell_ids),
            tuple( spell_repeatable )
            )
        # print( problem.getHeuristic( State([3,0,0,0]) ) )
        print( graphSearch( problem, fringe )  )

    print( "use time: {}".format(time.time() - start))



