#!/usr/local/bin/python3

import sys

class GameState(object):
    def getNumAgents(self):
        # TODO
        return 2

    def getLegalActions(self, agentIndex):
        return [ "WAIT" ]

    def generateSuccessor(self, agentIndex, action ):
        return self

    pass

class AlphaBetaAgent(object):
    """
      Your minimax agent with alpha-beta pruning (question 3)
    """
    def __init__( self, nDepth, playerIndex  ):
        self.depth = nDepth
        self.index = playerIndex

    def debug ( self , msg , *v ):
        pass
        # print msg, v

    # return (index, value )
    def value ( self, gameState , agentIndex , moveRemains , alpha , beta ):
        # protection, legalMoves, moveRemains shouldn't be 'zero' value
        if (moveRemains ==0) :
            return (-1,self.evaluationFunction(gameState))

        legalMoves = gameState.getLegalActions( agentIndex  )
        if len(legalMoves) == 0:
            return (-1,self.evaluationFunction(gameState))

        if agentIndex == 0:
            return self.maxValue( gameState , agentIndex , moveRemains , alpha , beta )
        else:
            return self.minValue( gameState , agentIndex , moveRemains , alpha , beta )

    def maxValue( self, gameState , agentIndex , moveRemains  , alpha , beta ):
        v = -sys.maxsize
        legalMoves = gameState.getLegalActions( agentIndex  )

        nextAgentIndex = (agentIndex +1)% gameState.getNumAgents()

        max_index = -1
        for i , action in enumerate( legalMoves  ):
            state = gameState.generateSuccessor( agentIndex  , action)
            v_successor = self.value ( state , nextAgentIndex  , moveRemains -1  , alpha , beta )[1]
            self.debug( "child value calulated", v_successor)
            if v_successor > v:
                v = v_successor
                max_index = i
                self.debug( " new max child: " , v )

            if v > beta :
                self.debug( " be pruned: " , max_index ,v   )
                return max_index , v

            alpha = max(alpha, v)
            self.debug( " try update alpha: " ,  alpha   )

        self.debug( " no pruned , all child calculated , index % value: " , max_index , v  )
        return max_index , v

    def minValue( self , gameState , agentIndex , moveRemains , alpha , beta ):

        v = sys.maxsize
        legalMoves = gameState.getLegalActions( agentIndex  )

        nextAgentIndex = (agentIndex +1)% gameState.getNumAgents()

        min_index = -1
        for i , action in enumerate( legalMoves  ):
            state = gameState.generateSuccessor( agentIndex  , action)
            v_successor = self.value ( state , nextAgentIndex  , moveRemains -1  , alpha , beta )[1]
            self.debug( "child value calulated", v_successor)
            if v_successor < v:
                v = v_successor
                min_index = i
                self.debug( " new min child: " , v )

            if v < alpha:
                self.debug( " be pruned: " , min_index ,v   )
                return min_index , v

            beta = min (beta, v)
            self.debug( " try update beta: " ,  beta   )

        self.debug( " no pruned , all child calculated , index % value: " , min_index , v  )
        return min_index , v

    def getAction(self, gameState):
        """
          Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        alpha = -sys.maxsize
        beta  =  sys.maxsize

        nDepth = self.depth
        nNumAgents = gameState.getNumAgents()

        # print nDepth , nNumAgents

        i, v = self.value( gameState , self.index  , nDepth* nNumAgents, alpha, beta )
        return  gameState.getLegalActions( self.index   ) [i]

    def evaluationFunction(self, gameState):
        return 1

if __name__ == '__main__':
    gameState = GameState()
    agent = AlphaBetaAgent(2, 0)
    action = agent.getAction( gameState )
    print(action)


