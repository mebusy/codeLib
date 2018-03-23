import edu.princeton.cs.algs4.In;
// import java.util.HashMap ; 
// import java.util.Stack;
// import java.util.ArrayList ;
import edu.princeton.cs.algs4.StdOut;


public class Outcast {
    private WordNet wn ;
    public Outcast(WordNet wordnet)         // constructor takes a WordNet object
    {
        wn = wordnet ;
    }
    public String outcast(String[] nouns)   // given an array of WordNet nouns, return an outcast
    {
        String oc = "";
        int longestPath = -1 ;
        for( int j=0 ; j< nouns.length ; j++ ) {
            int d = 0;
            // StdOut.printf( "%s:\n" ,  nouns[j]  );
            for( int i=0 ; i< nouns.length ; i++ ) {
                // StdOut.printf( "\t  -%s: %d\n" ,  nouns[i] , wn.distance( nouns[j] , nouns[i] ) );
                d += wn.distance( nouns[j] , nouns[i] );
            }
            // StdOut.printf( "\t---total length:%d\n" , d  );
            if (d > longestPath) {
                longestPath = d;
                oc = nouns[j] ;    
            }
        }
        return oc ;
    }
    public static void main(String[] args)  // see test client below
    {
        WordNet wordnet = new WordNet(args[0], args[1]);
        Outcast outcast = new Outcast(wordnet);
        for (int t = 2; t < args.length; t++) {
            In in = new In(args[t]);
            String[] nouns = in.readAllStrings();
            StdOut.println(args[t] + ": " + outcast.outcast(nouns));
        }

    }
}

