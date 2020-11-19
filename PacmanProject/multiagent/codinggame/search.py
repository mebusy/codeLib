#!/usr/local/bin/python3
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

    def buildPath( last_path_info ) :
        ret = []
        while last_path_info[0] is not None:
            ret.append( last_path_info[1] )
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
            return buildPath( path_info )

        print (state , " -> ")
        # expand
        if state not in closed :
            closed[state] = path_info
            for sucState , action, cost  in problem.getSuccessors( state ):
                fringe.push( ( sucState , (state,action) , costs + cost ),
                    costs + cost + problem.getHeuristic( sucState )  )
                print ("\t <- " , sucState)

    return []


class Problem(object):
    def __init__(self, startState, goalState, spells, spell_ids):
        self.startState = startState
        self.goalState = goalState
        self.spells = spells
        self.spell_ids = spell_ids

    def getStartState(self):
        return self.startState
    def getGoalState(self):
        return self.goalState
    def getHeuristic(self, state):
        h = 0
        diff = state.ingredients - self.goalState.ingredients
        for v in diff:
            if v < 0:
                h += -v
        return h
    def isGoalState(self, state):
        diff = state.ingredients - self.goalState.ingredients
        return np.all( diff >= 0 )
    def getSuccessors( self, state ):
        suc = []
        # action REST -1
        if state.spell_castable.sum() < 4: # NEW
            suc.append( ( State( state.ingredients+np.zeros(4), np.ones(4) ), -1, 1 ) )

        for i,spell in enumerate( self.spells ):
            if state.spell_castable[i] == 1:
                ingredients = state.ingredients + spell
                if ingredients.sum() <= 10 and np.all( ingredients >= 0 ):
                    spell_castable = state.spell_castable + np.zeros(4)
                    spell_castable[i] = 0 # casted
                    suc.append( (State( ingredients, spell_castable ),self.spell_ids[i], 1 ))

        return suc

        

class State(object):
    def __init__(self, ingredients, spell_castable  ):
        # all positive
        self.ingredients = np.array(ingredients)
        self.spell_castable = spell_castable


if __name__ == '__main__':
    fringe = PriorityQueue()
    problem = Problem( State([3,0,0,0], np.ones(4)), State(np.array([1,1,3,1]), np.ones(4)),
        np.array( [[2, 0, 0, 0], [-1, 1, 0, 0], [0, -1, 1, 0], [0, 0, -1, 1]] ), np.array( [0,1,2,3] )  )
    # print( problem.getHeuristic( State([3,0,0,0]) ) )
    print( graphSearch( problem, fringe )  )



