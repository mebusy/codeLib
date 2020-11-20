#!/usr/local/bin/python3
import time

import numpy as np
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

    def getStartState(self):
        return self.startState
    def getGoalState(self):
        return self.goalState
    def getHeuristic(self, state):
        h = 0
        diff = state.ingredients - self.goalState.ingredients
        for i,v in enumerate(diff):
            if v < 0:
                h += -v * (1)
        return h
    def isGoalState(self, state):
        diff = state.ingredients - self.goalState.ingredients
        return np.all( diff >= 0 )
    def getSuccessors( self, state ):
        suc = []

        # action REST -1
        if state.spell_castable.sum() < self.nSpell  : # NEW
            suc.append( ( State( state.ingredients+np.zeros(4), np.ones( self.nSpell  ) ), -1,1, 1 ) )

        # other spell
        for i,spell in enumerate( self.spells ):
            if state.spell_castable[i] == 1:
                max_cast_times = self.spell_repeatable[i] and 10 or 1
                for j in range(max_cast_times):
                    ingredients = state.ingredients + spell*(j+1)
                    if ingredients.sum() <= 10 and np.all( ingredients >= 0 ):
                        spell_castable = state.spell_castable + np.zeros( self.nSpell )
                        spell_castable[i] = 0 # casted
                        suc.append( (State( ingredients, spell_castable ),self.spell_ids[i], j+1,  1 ))
                    else:
                        break

        return suc

        


class State(object):
    def __init__(self, ingredients, spell_castable ):
        # all positive
        self.ingredients = np.array(ingredients)
        self.spell_castable = spell_castable
        # print(self.ToString())
    def ToString(self):
        return ( tuple(self.ingredients), tuple(self.spell_castable) )



if __name__ == '__main__':
    start = time.time()

    for i in range(100):
        fringe = PriorityQueue()

        spells =  [[2, 0, 0, 0], [-1, 1, 0, 0], [0, -1, 1, 0], [0, 0, -1, 1], [-4,0,1,0] ] 
        spell_ids = [1+i for i in range( len(spells) ) ]
        nSpell = len(spells)
        problem = Problem( 
            State([2,1,0,0], np.ones(nSpell)), 
            State(np.array([1,1,3,1]), np.ones(nSpell)),
            # State(np.array([0,4,0,0]), np.ones(nSpell)),
            np.array( spells), 
            np.array(spell_ids),
            [True]* nSpell
            )
        # print( problem.getHeuristic( State([3,0,0,0]) ) )
        print( graphSearch( problem, fringe )  )

    print( "use time: {}".format(time.time() - start))



