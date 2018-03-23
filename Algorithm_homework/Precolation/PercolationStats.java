/*
 * author: qibinyi
 * date:  20170215
 */

import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;
import java.lang.* ;

public class PercolationStats {

    private double trial_results [] ;
    
    public PercolationStats(int n, int trials){    // perform trials independent experiments on an n-by-n grid
        if(n<=0 || trials <=0 )
            throw new IllegalArgumentException();
        

        // StdRandom.setSeed( System.currentTimeMillis() );
        trial_results = new double[trials];

        for (int i=0; i< trials ; i++) {
            Percolation perc = new Percolation( n );
            int[] order = StdRandom.permutation( n*n );
            while ( !perc.percolates() ) {
                int index = order[ perc.numberOfOpenSites() ] ;
                
                int row = index/n +1 ;  
                int col = index%n +1 ;   
                perc.open(row, col);

            }   
            trial_results[i] = perc.numberOfOpenSites()*1.0/(n*n) ;
        }
    }    
    public double mean() {                          // sample mean of percolation threshold
        return StdStats.mean(trial_results);
    }
    public double stddev(){                        // sample standard deviation of percolation threshold
        return StdStats.stddev(trial_results );
    }
    public double confidenceLo(){                  // low  endpoint of 95% confidence interval
        return mean() - 1.96*stddev() / Math.sqrt( trial_results.length );
    }
    public double confidenceHi(){                  // high endpoint of 95% confidence interval
        return mean() +  1.96*stddev() / Math.sqrt( trial_results.length );
    }


    public static void main(String[] args){        // test client (described below)
        if ( args.length < 2 ) 
            System.out.println( "usage: PercolationStats <grid_size> <trival_times" );   

        PercolationStats stat = new PercolationStats( Integer.parseInt( args[0]), Integer.parseInt(args[1]))  ;       
        
        System.out.println("mean                    = "+ stat.mean() );
        System.out.println("stddev                  = "+ stat.stddev() );

        System.out.println("95% confidence interval  = ["+ stat.confidenceLo() + "," + stat.confidenceHi() + "]" );

    }
}



