import edu.princeton.cs.algs4.In;
import edu.princeton.cs.algs4.Digraph;
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import java.util.HashMap ; 
import java.util.Stack;
import java.util.ArrayList ;
public class WordNet {
    // scc 
    private class DepthFirstOrder {
        private boolean[] marked;
        private Stack<Integer> reversePost; // 1

        public DepthFirstOrder(Digraph G) {
            reversePost = new Stack<Integer>(); //2
            marked = new boolean[G.V()];
            for (int v = 0; v < G.V(); v++)
                if (!marked[v]) dfs(G, v);
        }

        private void dfs(Digraph G, int v) {
            marked[v] = true;
            for (int w : G.adj(v))
                if (!marked[w]) dfs(G, w);
            // System.out.println( "push:" + v  );
            reversePost.push(v);  // 3
        }

        // 4      
        public Iterable<Integer> reversePost() {  
            ArrayList<Integer> l = new ArrayList<Integer>() ;
            while ( reversePost.size()>0 ) {
                l.add(  reversePost.pop()  ) ;   
            }
            return l ;
        }
    }

    private class SCC {
        private boolean[] marked;
        // id[v] = (index or ID of component)
        private int[] id; 
        // record component index
        private int count; 
        private int nVertHas0OutDegree = 0 ;

        public SCC(Digraph G) {
            marked = new boolean[G.V()];
            id = new int[G.V()];
            // +
            DepthFirstOrder dfs = new DepthFirstOrder(G.reverse());
            // m 
            for (int v : dfs.reversePost())
                //for (int v = 0; v < G.V(); v++) 
            {
                if (!marked[v])
                {
                    // run DFS from one vertex
                    // in each component
                    dfs(G, v);
                    count++; 
                } // end if
            } // end for
        } // end CC

        private void dfs(Digraph G, int v)
        {
            marked[v] = true;
            // all vertices discovered in same 
            // call of dfs have same id
            id[v] = count ;
            if ( G.outdegree( id[v]  ) ==0  ) 
                nVertHas0OutDegree ++ ;

            for (int w : G.adj(v))
                if (!marked[w])
                    dfs(G, w);
        }

        public int nSCC() {
            return count ;
        }

        public int n0OutDegreeVertex() {
            return nVertHas0OutDegree;    
        }
    }
    // end scc


    private void CheckStringArgument( String arg ) {
        if (arg ==null) 
            throw new java.lang.IllegalArgumentException();
    }

    private boolean isRootedDAG(Digraph _dg) {
        SCC scc = new SCC( _dg ) ;
        return scc.nSCC() == _dg.V() && scc.n0OutDegreeVertex() == 1 ;    
    }
    private void CheckWordNetNoun(String word) {
        if ( !isNoun( word ) ) 
            throw new java.lang.IllegalArgumentException();
    }

    private HashMap<String,ArrayList<Integer>> synset_map = new HashMap<String,ArrayList<Integer>>();
    private HashMap<Integer,String> synset_map_id2string = new HashMap<Integer,String>();
    private Digraph dg ;
    private SAP sap ;
    // constructor takes the name of the two input files
    public WordNet(String synsets, String hypernyms) {
        CheckStringArgument(synsets) ;
        CheckStringArgument(hypernyms) ;

        In in_synset = new In( synsets ) ;  
        int count = 0; 
        while ( in_synset.hasNextLine() ) {
            String line = in_synset.readLine() ;
            count ++ ;

            String[] components = line.split(",");
            assert components.length == 3; 

            int id =  Integer.parseInt( components[0] ) ;
            String[] synset = components[1].split(" "); 
            for ( int i=0;i< synset.length ; i++  ) {
                if ( !synset_map.containsKey( synset[i] )  )
                    synset_map.put( synset[i] ,new ArrayList<Integer>() ) ;
                synset_map.get( synset[i] ).add( id );
            }
            synset_map_id2string.put( id, components[1] ) ;
        }

        // System.out.println( count + " lines in total " );
        dg = new Digraph( count ) ;
        
        In in_hyper = new In( hypernyms ) ;
        while ( in_hyper.hasNextLine()  ) {
            String line = in_hyper.readLine();
            
            String[] ids = line.split(",") ;
            assert ids.length > 1 ;

            for (int i=1; i< ids.length ;i++) {
                dg.addEdge( Integer.parseInt(ids[0]) , Integer.parseInt(ids[i]) );    
            }
                
               
        } 



        if ( !isRootedDAG( dg ) ) 
            throw new java.lang.IllegalArgumentException("not rooted DAG !"); 

        sap = new SAP( dg ) ;
        

        // linearithmic 
    }

    // returns all WordNet nouns
    public Iterable<String> nouns() {
        return synset_map.keySet() ;   
    }

    // is the word a WordNet noun?
    public boolean isNoun(String word) {
        CheckStringArgument(word) ;

        // logarithmic (or better) 
        return synset_map.containsKey(word) ;   
    }

    // distance between nounA and nounB (defined below)
    public int distance(String nounA, String nounB) {
        CheckStringArgument(nounA) ;
        CheckStringArgument(nounB) ;

        // linear
        ArrayList<Integer> v = synset_map.get( nounA ) ;
        ArrayList<Integer> w = synset_map.get( nounB ) ;
        return sap.length(v,w) ;    
    }

    // a synset (second field of synsets.txt) that is the common ancestor of nounA and nounB
    // in a shortest ancestral path (defined below)
    public String sap(String nounA, String nounB) {
        CheckStringArgument(nounA) ;
        CheckStringArgument(nounB) ;

        // linear
        ArrayList<Integer> v = synset_map.get( nounA ) ;
        ArrayList<Integer> w = synset_map.get( nounB ) ;
        int ancestor = sap.ancestor( v,w ) ;
        return  synset_map_id2string.get( ancestor ) ;

    }

    // do unit testing of this class
    public static void main(String[] args) {
        WordNet wordnet = new WordNet(args[0], args[1]);
        while (!StdIn.isEmpty()) {
            String v = StdIn.readString();
            String w = StdIn.readString();
            int length   = wordnet.distance(v,w);
            String ancestor = wordnet.sap( v,w ) ;
            StdOut.printf("length = %d, ancestor = %s\n", length, ancestor);
        }
    }
}
