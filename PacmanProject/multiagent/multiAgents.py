# multiAgents.py
# --------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


from util import manhattanDistance
from game import Directions
import random, util

import sys, operator, math
from game import Agent

class ReflexAgent(Agent):
    """
      A reflex agent chooses an action at each choice point by examining
      its alternatives via a state evaluation function.

      The code below is provided as a guide.  You are welcome to change
      it in any way you see fit, so long as you don't touch our method
      headers.
    """


    def getAction(self, gameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {North, South, West, East, Stop}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

        "*** YOUR CODE HERE ***"
        listFood =  newFood.asList()
        if len(listFood)==0:
            return successorGameState.getScore()
        dist2closestFood = min( util.manhattanDistance(foodPos, newPos  ) for foodPos in listFood )
        dist2closestGhost = min(util.manhattanDistance(ghostState.getPosition() , newPos) for i, ghostState in enumerate(newGhostStates) )
        # really naive solution
        return successorGameState.getScore()-dist2closestFood + dist2closestGhost 

def scoreEvaluationFunction(currentGameState):
    """
      This default evaluation function just returns the score of the state.
      The score is the same one displayed in the Pacman GUI.

      This evaluation function is meant for use with adversarial search agents
      (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
      This class provides some common elements to all of your
      multi-agent searchers.  Any methods defined here will be available
      to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

      You *do not* need to make any changes here, but you can if you want to
      add functionality to all your adversarial search agents.  Please do not
      remove anything, however.

      Note: this is an abstract class: one that should not be instantiated.  It's
      only partially specified, and designed to be extended.  Agent (game.py)
      is another abstract class.
    """

    def __init__(self, evalFn = 'scoreEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
      Your minimax agent (question 2)
    """
    # return (index, value )
    def value ( self, gameState , agentIndex , moveRemains ):
        if (moveRemains ==0) :
            return (-1,self.evaluationFunction(gameState)) 

        legalMoves = gameState.getLegalActions( agentIndex  )      
        if len(legalMoves) == 0:
            return (-1,self.evaluationFunction(gameState))

        if agentIndex == 0:
            return self.maxValue( gameState , agentIndex , moveRemains )
        else:
            return self.minValue( gameState , agentIndex , moveRemains )

    def maxValue( self, gameState , agentIndex , moveRemains  ):
        legalMoves = gameState.getLegalActions( agentIndex  )      
         
        successorGameStates = [ gameState.generateSuccessor( agentIndex  , action) for action in legalMoves ]
        nextAgentIndex = (agentIndex +1)% gameState.getNumAgents()
        scores = [ self.value ( state , nextAgentIndex  , moveRemains -1 )[1]   for state in successorGameStates ]
        return max(enumerate(scores ), key=operator.itemgetter(1))
    
    def minValue( self , gameState , agentIndex , moveRemains  ):
        
        legalMoves = gameState.getLegalActions( agentIndex  )      

        successorGameStates = [ gameState.generateSuccessor( agentIndex  , action) for action in legalMoves ]
        nextAgentIndex = (agentIndex +1)% gameState.getNumAgents()
        scores = [ self.value ( state , nextAgentIndex , moveRemains -1 )[1] for state in successorGameStates ]
        return min(enumerate(scores ), key=operator.itemgetter(1))
         
    def getAction(self, gameState):
        """
          Returns the minimax action from the current gameState using self.depth
          and self.evaluationFunction.

          Here are some method calls that might be useful when implementing minimax.

          gameState.getLegalActions(agentIndex):
            Returns a list of legal actions for an agent
            agentIndex=0 means Pacman, ghosts are >= 1

          gameState.generateSuccessor(agentIndex, action):
            Returns the successor game state after an agent takes an action

          gameState.getNumAgents():
            Returns the total number of agents in the game
        """
        "*** YOUR CODE HERE ***"
        nDepth = self.depth ;
        nNumAgents = gameState.getNumAgents()
        
        # print nDepth , nNumAgents 
        

        i, v = self.value( gameState , self.index  , nDepth* nNumAgents  ) 
        return  gameState.getLegalActions( self.index   ) [i]           

class AlphaBetaAgent(MultiAgentSearchAgent):
    """
      Your minimax agent with alpha-beta pruning (question 3)
    """
    def debug ( self , msg , *v ):
        pass
        # print msg, v 

    # return (index, value )
    def value ( self, gameState , agentIndex , moveRemains , alpha , beta ):
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
        v = -sys.maxint 
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
        
        v = sys.maxint 
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
        alpha = -sys.maxint 
        beta  =  sys.maxint 

        nDepth = self.depth 
        nNumAgents = gameState.getNumAgents()
        
        # print nDepth , nNumAgents 

        i, v = self.value( gameState , self.index  , nDepth* nNumAgents, alpha, beta ) 
        return  gameState.getLegalActions( self.index   ) [i]           

class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    # return (index, value )
    def value ( self, gameState , agentIndex , moveRemains ):
        if (moveRemains ==0) :
            return (-1,self.evaluationFunction(gameState)) 

        legalMoves = gameState.getLegalActions( agentIndex  )      
        if len(legalMoves) == 0:
            return (-1,self.evaluationFunction(gameState))

        if agentIndex == 0:
            return self.maxValue( gameState , agentIndex , moveRemains )
        else:
            return self.expectValue( gameState , agentIndex , moveRemains )

    def maxValue( self, gameState , agentIndex , moveRemains  ):
        legalMoves = gameState.getLegalActions( agentIndex  )      
         
        successorGameStates = [ gameState.generateSuccessor( agentIndex  , action) for action in legalMoves ]
        nextAgentIndex = (agentIndex +1)% gameState.getNumAgents()
        scores = [ self.value ( state , nextAgentIndex  , moveRemains -1 )[1]   for state in successorGameStates ]
        return max(enumerate(scores ), key=operator.itemgetter(1))
    
    def expectValue( self , gameState , agentIndex , moveRemains  ):
        
        legalMoves = gameState.getLegalActions( agentIndex  )      

        successorGameStates = [ gameState.generateSuccessor( agentIndex  , action) for action in legalMoves ]
        nextAgentIndex = (agentIndex +1)% gameState.getNumAgents()
        scores = [ self.value ( state , nextAgentIndex , moveRemains -1 )[1] for state in successorGameStates ]
        return ( -1, sum(scores ) * 1.0 / len(scores ) ) 

    def getAction(self, gameState):
        """
          Returns the expectimax action using self.depth and self.evaluationFunction

          All ghosts should be modeled as choosing uniformly at random from their
          legal moves.
        """
        "*** YOUR CODE HERE ***"
        nDepth = self.depth ;
        nNumAgents = gameState.getNumAgents()
        
        i, v = self.value( gameState , self.index  , nDepth* nNumAgents  ) 
        return  gameState.getLegalActions( self.index   ) [i]           


def pointDistance( x , y  ):
    # return util.manhattanDistance ( x, y  )
    return math.sqrt( ((x[0]-y[0])**2 ) + ((x[1]-y[1])**2)  )

def betterEvaluationFunction(currentGameState):
    """
      Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
      evaluation function (question 5).

      DESCRIPTION: <write something here so we know what you did>
    """
    "*** YOUR CODE HERE ***"
    # util.raiseNotDefined()
    # func = util.lookup("scoreEvaluationFunction", globals())
    pos = currentGameState.getPacmanPosition()
    listFood =  currentGameState.getFood().asList()
    v1 = scoreEvaluationFunction(currentGameState)*3 
    
    if len(listFood ) == 0:
        return v1 
    
    # all_food_distance = [ pointDistance (foodPos, pos) for foodPos in listFood ]
    # dist2closestFood  = min( all_food_distance )
    dist2nextFood  = pointDistance ( listFood[0] , pos  )  #util.manhattanDistance( listFood[0] , pos  )
    v2 = - dist2nextFood
    v3 = - len(listFood) * 64
    # v4 = dist2nextFood ==0 and 256 or 0
    # print v1, v2 ,v3 , v4 
    return v1 + v2 + v3 # + v4

# Abbreviation
better = betterEvaluationFunction

