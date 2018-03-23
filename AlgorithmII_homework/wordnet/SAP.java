import edu.princeton.cs.algs4.In;
import edu.princeton.cs.algs4.Digraph;
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import edu.princeton.cs.algs4.Queue ;

public class SAP {

    private Digraph dg ;
    private void checkObjectArgument(Object obj) {
        if(obj== null) 
            throw new java.lang.IllegalArgumentException( "argument can not be null" );
        
    }
    private void checkVertexIndex( int idx ) {
        if ( idx < 0 || idx >= dg.V() ) 
            throw new java.lang.IllegalArgumentException( "invalid vertex id" );
    }

    private void checkVertexCollection( Iterable<Integer> v ) {
        if(v== null) 
            throw new java.lang.IllegalArgumentException( "argument can not be null" );

        for(int i : v ) {
            checkVertexIndex(i) ;  
        }
        
    }

    private boolean[] marked;
    private int GetShortestAncestorPath( HashMap<Integer,Integer> pv, HashMap<Integer,Integer> pw , boolean bReturnAncestor ) {
        int shortestPath = Integer.MAX_VALUE ;
        int ancestor = -1 ;

        for( int kv :pv.keySet() ) {
            // System.out.println( kv );
            if ( pw.containsKey( kv ) && pv.get( kv ) + pw.get( kv ) < shortestPath  ) {
                ancestor = kv ;
                shortestPath = pv.get( kv ) + pw.get( kv ) ; 
            }
        }

        if(bReturnAncestor)
            return ancestor ; 
        else
            return ancestor == -1?  -1: shortestPath   ;
        
    }

    private HashMap<Integer,Integer>  bfs( Digraph G, Iterable<Integer> cs )  {
        marked = new boolean[dg.V()];
        HashMap<Integer,Integer> pv = new HashMap<Integer,Integer>() ;
        Queue<Integer> q = new Queue<Integer>();

        for ( int s : cs ) {
            q.enqueue(s);
            marked[s] = true;
            pv.put( s, 0 );
            // StdOut.printf( "bfs visit %d - length %d\n" , s , 0);
        }
        while (!q.isEmpty())
        {
            int v = q.dequeue();
            for (int w : G.adj(v))
            {
                if (!marked[w])
                {
                    q.enqueue(w);
                    marked[w] = true;
                    pv.put( w, pv.get( v )+1  );
                    // StdOut.printf( "bfs visit %d - length %d\n" , w ,  pv.get( w )  );
                }
            } // end for
        } // end while

        return pv ;
    } // end bfs

    // ==========================

    // constructor takes a digraph (not necessarily a DAG)
    public SAP(Digraph G) {
        checkObjectArgument( G );
        dg = G ; 

    }

    // length of shortest ancestral path between v and w; -1 if no such path
    public int length(int v, int w) {
        checkVertexIndex(v);
        checkVertexIndex(w);

        ArrayList<Integer> vs = new ArrayList<Integer>() ;
        vs.add( v );
        ArrayList<Integer> ws = new ArrayList<Integer>() ;
        ws.add( w );
        HashMap<Integer,Integer> pv = bfs( dg, vs );
        HashMap<Integer,Integer> pw = bfs( dg, ws );
        // for ( Map.Entry<Integer,Integer> entry : pv.entrySet() )
        //     StdOut.printf("len = %d, parent = %d\n", entry.getKey(), entry.getValue() );
        
        return GetShortestAncestorPath( pv, pw , false  ) ;
    }

    // a common ancestor of v and w that participates in a shortest ancestral path; -1 if no such path
    public int ancestor(int v, int w) {
        checkVertexIndex(v);
        checkVertexIndex(w);

        ArrayList<Integer> vs = new ArrayList<Integer>() ;
        vs.add( v );
        ArrayList<Integer> ws = new ArrayList<Integer>() ;
        ws.add( w );
        HashMap<Integer,Integer> pv = bfs( dg, vs );
        HashMap<Integer,Integer> pw = bfs( dg, ws );
        // for ( Map.Entry<Integer,Integer> entry : pv.entrySet() )
        //     StdOut.printf("len = %d, parent = %d\n", entry.getKey(), entry.getValue() );


        return GetShortestAncestorPath( pv, pw , true  ) ;
    }

    // length of shortest ancestral path between any vertex in v and any vertex in w; -1 if no such path
    public int length(Iterable<Integer> v, Iterable<Integer> w) {
        checkVertexCollection(v);
        checkVertexCollection(w);
        HashMap<Integer,Integer> pv = bfs( dg, v );
        HashMap<Integer,Integer> pw = bfs( dg, w );
        return GetShortestAncestorPath( pv, pw , false  ) ;   
    }

    // a common ancestor that participates in shortest ancestral path; -1 if no such path
    public int ancestor(Iterable<Integer> v, Iterable<Integer> w) {
        checkVertexCollection(v);
        checkVertexCollection(w);
        HashMap<Integer,Integer> pv = bfs( dg, v );
        HashMap<Integer,Integer> pw = bfs( dg, w );
        return GetShortestAncestorPath( pv, pw , true  ) ;   
    }

    // do unit testing of this class
    public static void main(String[] args) {
        In in = new In( args[0] ) ;
        Digraph dg = new Digraph(in) ;
        SAP sap = new SAP( dg ) ; 
        while (!StdIn.isEmpty()) {
            int v = StdIn.readInt();
            int w = StdIn.readInt();
            int length   = sap.length(v, w);
            int ancestor = sap.ancestor(v, w);
            StdOut.printf("bfs_0 length = %d, ancestor = %d\n", length, ancestor);
            ArrayList<Integer> pv = new ArrayList<Integer>();
            pv.add(v) ;
            ArrayList<Integer> pw = new ArrayList<Integer>();
            pw.add(w) ;
            
            length   = sap.length(pv, pw);
            ancestor = sap.ancestor(pv, pw);
            StdOut.printf("bfs_c length = %d, ancestor = %d\n", length, ancestor);
        }
    }
}

