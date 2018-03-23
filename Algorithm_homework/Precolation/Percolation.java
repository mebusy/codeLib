/*
 * author: qibinyi
 * date:  20170215
 */

import edu.princeton.cs.algs4.WeightedQuickUnionUF;

import java.lang.* ;

public class Percolation {
    private int nGrid ;    
    private WeightedQuickUnionUF wquUF ;
    private int directions[][] = { {1,0},{-1,0},{0,1},{0,-1}  } ; 
    private boolean bOpens[] ;
    private int nNumOpened = 0 ;
    private int testIndexOfTopSite = -1;
    private int testIndexOfBottomSite = -1;
    /*
    * check whether arguments is outof range
    */
    private boolean isOutsideRange(int row, int col) {
        return ( row<1 || row > nGrid || col<1 ||  col > nGrid );
    }

    /*
    * create n-by-n grid, with all sites blocked
    */
    public Percolation(int n)  {
        if (n <=0 )
            throw new IllegalArgumentException();
        nGrid = n ; 
        wquUF = new WeightedQuickUnionUF(n*n);
        bOpens = new boolean[n*n]  ;
        nNumOpened = 0 ;     
        testIndexOfTopSite = -1;
        testIndexOfBottomSite = -1;
    }


    /*
    * open site (row, col) if it is not open already  
    */
    public    void open(int row, int col)   {
        if( isOutsideRange(row, col)) throw new IndexOutOfBoundsException();
        
        if (isOpen(row, col)) return ;

        int index = (row-1)*nGrid + (col -1);
        bOpens [index] = true ;
        nNumOpened ++ ;
        
        if (row == 1){
            if (testIndexOfTopSite == -1 ) {
                testIndexOfTopSite = index ;
            }else{
                wquUF.union( index, testIndexOfTopSite  ) ;              
            }
        }

        if ( row  == nGrid){
            if (testIndexOfBottomSite == -1 ) {
                testIndexOfBottomSite = index ;
            }else{
                wquUF.union( index, testIndexOfBottomSite  ) ;              
            }
        }

        for (int i=0 ; i< directions.length ; i++) {
            int newRow = row + directions[i][0];
            int newCol = col + directions[i][1] ;
            
            if ( isOutsideRange(newRow , newCol) || !isOpen(newRow, newCol) ) continue ;
            
            int index2connect = (newRow-1)*nGrid + (newCol -1) ;
            
            wquUF.union( index, index2connect ) ;           
        }

    }

    /*
    * is site (row, col) open? 
    */
    public boolean isOpen(int row, int col)  {
        if( isOutsideRange(row, col)) throw new IndexOutOfBoundsException();
        int index = (row-1)*nGrid + (col -1);
        return bOpens [index];
    }


    /*
    * is site (row, col) full?
    */
    public boolean isFull(int row, int col)  {
        if( isOutsideRange(row, col)) throw new IndexOutOfBoundsException();
        int index = (row-1)*nGrid + (col -1);
        return testIndexOfTopSite!= -1 &&  wquUF.connected( testIndexOfTopSite, index  ) ;
    }

    /*
    * number of open sites
    */ 
    public int numberOfOpenSites() {
        return nNumOpened ;   
    }

    /*
    * does the system percolate?  
    */
    public boolean percolates() {
        if(testIndexOfBottomSite == -1) return false ;

        int row = testIndexOfBottomSite/nGrid +1 ;
        int col = testIndexOfBottomSite%nGrid +1 ;
    
        // System.out.println( "percolated test: " + row + "," + col );

        return isFull( row, col  );  

    }

    /*
    * test client (optional)     
    */
    public static void main(String[] args) {   
    }

}
