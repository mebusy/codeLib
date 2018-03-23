import edu.princeton.cs.algs4.MinPQ ;
import edu.princeton.cs.algs4.* ;
import java.util.Comparator ;
public class Solver {
	
    private class Node {
		public Node( Board state , java.util.ArrayList<Board> path ,   int costs  ) {
			this.state = state ;
			this.accumulated_costs = costs ; 
			this.path = path ;
		}
        public int accumulated_costs = 0 ;
        public java.util.ArrayList<Board> path ;
        public Board state ;  

		public String toString() {
			return state.toString() + "cost: " + accumulated_costs + ", manh: " + state.manhattan() +  ", path len: " + path.size() + "\n\n" ; 
		}
    }
    
    private static class ByManh implements Comparator<Node> {
		public int compare( Node x , Node y ) {
			return x.state.manhattan()+x.accumulated_costs   - (y.state.manhattan()+y.accumulated_costs) ;
		}
	}

    // private static class ByHamm implements Comparator<Node> {
	// 	public int compare( Node x , Node y ) {
	// 		return x.state.hamming()+x.accumulated_costs   - (y.state.hamming()+y.accumulated_costs) ;
	// 	}
	// }
	private Board initialBoard ;
	private MinPQ<Node> fringe = new MinPQ<Node>( new ByManh()) ; 
	private java.util.ArrayList<Board> solution =  null ;
    
    private java.util.ArrayList<Board>  solve1step ( java.util.HashMap<String,String > close , MinPQ<Node> fringe   ) {
        
        if ( fringe.isEmpty() ) 
            return null ; 	
        Node node = fringe.delMin() ;
        Board state = node.state ;
        java.util.ArrayList<Board> path = node.path ;
        int costs = node.accumulated_costs ;	


        // System.out.println( "expand node : " + node.toString() );	
        if (state.isGoal() ) {
            return path ;	
        }

        String key = state.toString() ;
        if ( ! close.containsKey( key ) ) {
            close.put(key, "") ;
            for ( Board succ_state   : state.neighbors() ) {
                java.util.ArrayList<Board> succ_path = new  java.util.ArrayList<Board>( path ) 	;
                succ_path.add( succ_state  ) ; 
                Node succ_node = new Node( succ_state , succ_path  ,  costs + 1   )  ;
                fringe.insert ( succ_node  );		
                // System.out.println( "add new node: " + succ_node.toString()  );
            }
        }
        
        return null ;
    }
    
    public Solver(Board initial)           // find a solution to the initial board (using the A* algorithm)
	{
        if ( initial == null ) 
            throw new java.lang.NullPointerException();
		initialBoard = initial   ;

		java.util.HashMap<String,String > close  = new java.util.HashMap<String,String >(); 
		java.util.ArrayList<Board> init_path = new  java.util.ArrayList<Board>( ) 	;
		init_path.add( initialBoard  ) ; 
		fringe.insert(  new Node(  initialBoard , init_path , 0  )  );	

        MinPQ<Node> fringe_twin = new MinPQ<Node>( new ByManh()) ; 
        java.util.ArrayList<Board> solution_twin =  null ;
        java.util.HashMap<String,String > close_twin  = new java.util.HashMap<String,String >(); 

        Board twin = initialBoard.twin() ;
		java.util.ArrayList<Board> init_path_twin = new  java.util.ArrayList<Board>( ) 	;
		init_path_twin.add( twin   ) ; 
		fringe_twin.insert(  new Node(  twin , init_path_twin  , 0  )  );	
        

		while ( solution == null &&  solution_twin == null  ) {
            solution = solve1step( close , fringe  );
            solution_twin = solve1step( close_twin , fringe_twin  );
		}

	}
    public boolean isSolvable()            // is the initial board solvable?
	{
		return solution != null   ;	
	}
    public int moves()                     // min number of moves to solve initial board; -1 if unsolvable
	{
		if (!isSolvable() )
			return -1 ;
		return solution.size() -1 ;	
	}
    public Iterable<Board> solution()      // sequence of boards in a shortest solution; null if unsolvable
    {
        return solution  ;     
    }
    public static void main(String[] args) // solve a slider puzzle (given below)
	{
		// create initial board from file
		In in = new In(args[0]);
		int n = in.readInt();
		int[][] blocks = new int[n][n];
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				blocks[i][j] = in.readInt();
		Board initial = new Board(blocks);

		// solve the puzzle
		Solver solver = new Solver(initial);

		// print solution to standard output
		if (!solver.isSolvable())
			StdOut.println("No solution possible");
		else {
			StdOut.println("Minimum number of moves = " + solver.moves());
			for (Board board : solver.solution())
				StdOut.println(board);
		}
	}
}

