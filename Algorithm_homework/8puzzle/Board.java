
import java.util.Iterator ;
import java.lang.* ;
import edu.princeton.cs.algs4.* ;

public class Board {
    
	private int dimension ; 
	private int[][] grid ;
	public Board(int[][] blocks)           // construct a board from an n-by-n array of blocks
	{
		this.dimension = blocks[0].length ;
		grid = new int[dimension][dimension];
		int n = this.dimension ;
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				grid[i][j] = blocks[i][j];
	}                                           // (where blocks[i][j] = block in row i, column j)
    public int dimension()                 // board dimension n
	{
		return this.dimension  ;
	}
    public int hamming()                   // number of blocks out of place
	{
		int nHamming = 0 ;
		int i , x , y ; 
		int n = this.dimension ; 
		int nBlocks = n*n ; 
		for ( int j=0 ; j< nBlocks ; j++ ) {
			i = (j-1+nBlocks )%nBlocks  ;
			y = i % n ; 
			x = i / n ;
		    
            if (grid[x][y] == 0)
                continue ;
			if ( grid[x][y] != j ) 
				nHamming ++ ; 
		}
        // System.out.println( nHamming );
        // x = 1/0 ;
		return nHamming ; 	
	}
    public int manhattan()                 // sum of Manhattan distances between blocks and goal
	{
		
		int nManh = 0 ;
		int  x , y;
		int n = this.dimension ; 
		int nBlocks = n*n ; 
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
			{
                if (grid[i][j] == 0)
                    continue ;
				int t = (grid[i][j]-1+nBlocks )%nBlocks 			;
			 	y = t % n ;
				x = t / n ;		
				// System.out.println( grid[i][j] + " : " +  i + " " + j + " " + x + " " + y    );
				nManh += ( Math.abs( x - i ) + Math.abs( y - j )  ) ;
				
			}
        // System.out.println( nManh );
        // x = 1/0 ;
		return nManh ; 	
	}
    public boolean isGoal()                // is this board the goal board?
	{
		int i,x,y ; 
		int n = this.dimension();
		int nBlocks = n*n ;
		for ( int j=0 ; j< nBlocks ; j++ ) { 
			
			i = (j-1+nBlocks ) % nBlocks  ;
			y = i % n ; 
			x = i / n ;
			if ( grid[x][y] != j )
				return false ;
		}
		return true ;
	}
	private void swap ( int grid[][], int x0, int y0 , int x1 , int y1  ) {
		int temp = grid[x0][y0] ; 
		grid[x0][y0] = grid[x1][y1]  ;
		grid[x1][y1] = temp ; 
	}

    private int[][] gridCopy() {
        
		int n = dimension() ;
		int[][] grid_twin = new int[n][n] ;

		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				grid_twin[i][j] = this.grid[i][j];
        return grid_twin ;  
    }

    public Board twin()                    // a board that is obtained by exchanging any pair of blocks
	{
		int n = dimension() ;
	    int[][] grid_twin = gridCopy();	
        int indeces[] = new int[4] ;
        int cnt =0 ;
		for (int i = 0; i < n; i++)
        {
			for (int j = 0; j < n; j++)
            {
                if ( grid_twin[i][j] != 0  )
                {
                    indeces[cnt++] = i ; 
                    indeces[cnt++] = j ;  
                }              

                if (cnt >=indeces.length ) break; 
            }
            if (cnt >=indeces.length ) break;  
        }
        swap( grid_twin ,  indeces[0], indeces[1] , indeces[2] , indeces[3]   ) ;


		return new Board( grid_twin  ) ;
	}
    public boolean equals(Object y)        // does this board equal y?
	{
		Board by = (Board)(y) ;

	    int n = dimension() ;	
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				if ( this.grid[i][j] != by.grid[i][j] ) 
					return false ;
		return true ;
	}


    public Iterable<Board> neighbors()     // all neighboring boards
	{
       
        java.util.ArrayList <Board> nb = new java.util.ArrayList<Board>();
        
        // find 0
		int n = dimension() ;
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++) {
                if ( this.grid[i][j] == 0 ){
                    if ( i > 0 ) {
                        int[][] gridCopy = gridCopy(); 
                        swap(gridCopy , i-1,j ,   i,j  ) ;
                        nb.add( new Board( gridCopy ) ) ;
                    }                       
                    if ( i < n-1 ) {
                        int[][] gridCopy = gridCopy(); 
                        swap(gridCopy , i+1,j ,   i,j  ) ;
                        nb.add( new Board( gridCopy ) ) ;
                    }                       
                    if ( j > 0 ) {
                        int[][] gridCopy = gridCopy(); 
                        swap(gridCopy , i,j-1 ,   i,j  ) ;
                        nb.add( new Board( gridCopy ) ) ;
                    }                       
                    if ( j < n-1 ) {
                        int[][] gridCopy = gridCopy(); 
                        swap(gridCopy , i,j+1 ,   i,j  ) ;
                        nb.add( new Board( gridCopy ) ) ;
                    }                       
                }
            } 
        return nb ;
	}
    public String toString()               // string representation of this board (in the output format specified below)
	{
		int n = this.dimension();
		StringBuilder s = new StringBuilder();
		s.append(n + "\n");
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
				s.append(String.format("%2d ", grid[i][j]));
			}
			s.append("\n");
		}
		return s.toString();
	}

    public static void main(String[] args) // unit tests (not graded)
	{

	}
}



