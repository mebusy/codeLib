import edu.princeton.cs.algs4.* ;
import java.awt.Color ;
import java.lang.Math ;
import java.util.ArrayList ;
import java.util.PriorityQueue ;
import java.util.Comparator;
import java.util.HashMap ;

public class SeamCarver {
    
    private class StateNode {
        public int state ;
        public double cumulateCost ;
        public int parentState ;
         
        public StateNode( int s , double cost ,  int  _parentState ) {
            state = s ;
            cumulateCost = cost ;
            parentState = _parentState ;
        }
    }
    private static Comparator<StateNode> nodeComparator = new Comparator<StateNode>(){
        @Override
        public int compare(StateNode n1, StateNode n2) {
            return  Double.compare( n1.cumulateCost , n2.cumulateCost  )   ;
        }
    };

    private int[] generateFromLastNode(  HashMap<Integer, Integer> close , int lastState , int lastParentState ) {
        ArrayList<Integer> path = new ArrayList<>();
        path.add( lastState ) ;
        
        while ( lastParentState != -1 ) {
            path.add( lastParentState ) ;
            lastParentState =  close.get( lastParentState ) ;
        }

        int[] ret = new int[path.size()];
        for (int i=0; i< ret.length ; i++) {
            ret[ ret.length-1-i ] = path.get(i) ;    
        }

        return ret ;
    }
    private int[] UniformSearch( Iterable<Integer> source_vertices , boolean bVertical ) {
        // System.out.println( "UniformSearch, vertices:"+ G.V() + " edges:"+ G.E() );
        int debug_node_expand = 0 ;
        int debug_node_test = 0 ;

        int width  = width();
        int height = height();
        PriorityQueue<StateNode> fringe = new  PriorityQueue<StateNode>( width*height ,  nodeComparator ) ; 
        HashMap<Integer, Integer> close = new HashMap<>();

        for(int s : source_vertices) {
            fringe.add( new StateNode( s , 0 , -1  )  ) ;   
        }

        while (true) {
            if (fringe.isEmpty())
                return null ;     

            StateNode node = fringe.poll();
            debug_node_test++ ;

            int state = node.state ;
            int parentState = node.parentState ;
            double costs = node.cumulateCost ;

            if ( (bVertical && (state/width == height -1) ) || (!bVertical && ( state % width == width-1 )) ) // we claim hit the goal !!!
            {
                // System.out.println( "node expand: " + debug_node_expand + " node test:" + debug_node_test  );
                return generateFromLastNode( close , state , parentState )   ;
            }
            
            if ( ! close.containsKey(state) ) {
                debug_node_expand ++ ;
                close.put( state , parentState ) ;

                int x0 = state % width ;
                int y0 = state / width ;
                for(int t=-1;t<2;t++) {
                    int x = x0 + (bVertical?t:1 ) ;
                    int y = y0 + (bVertical?1:t ) ;

                    if ( x<0 || y<0 || x>=width || y>=height) continue ;

                    int sucState = y*width + x   ;
                    // System.out.println(  state +  " t:" + t + " sec:" + sucState );

                    // for memory issue , and since it is uniform search ...
                    if ( close.containsKey( sucState ) )
                        continue ;

                    fringe.add( new StateNode( sucState  , costs + energy_matrix[y][x]  , state )  ) ; 
                }    
            }
        }
    }


    private class DepthFirstOrder {
        private boolean[] marked;
        private Stack<Integer> reversePost; // 1

        int V ;
        int width ,height;
        boolean bVertical ; 
        public DepthFirstOrder( int _width , int _height  , boolean _bVertical ) {
            width = _width ;  height = _height ;
            V = width*height ;
            bVertical = _bVertical;

            reversePost = new Stack<Integer>(); //2
            marked = new boolean[V];
            for (int v = 0; v < V; v++)
                if (!marked[v]) dfs( v);
        }

        private void dfs(int v) {
            marked[v] = true;
                
            int x0 = v % width ;
            int y0 = v / width ;
            for(int t=-1;t<2;t++) {
                int x = x0 + (bVertical?t:1 ) ;
                int y = y0 + (bVertical?1:t ) ;
                if ( x<0 || y<0 || x>=width || y>=height) continue ;
                int w = y*width + x   ;
                if (!marked[w]) dfs(w);
            }

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

    private int[] AcyclicSP( Iterable<Integer> source_vertices , boolean bVertical ) {
        int width = width();
        int height = height();
        int V = width*height;
        
        int[] edgeTo = new int[V] ;
        double[] distTo = new double[V];

        for (int v = 0; v < V; v++) {
            distTo[v] = Double.POSITIVE_INFINITY;
            edgeTo[v] = -1 ;
        }

        for(int s: source_vertices)  {
            distTo[s] = 0.0;
        }

        DepthFirstOrder topological = new DepthFirstOrder( width, height, bVertical ) ;
        for ( int v : topological.reversePost() ) {
            int x0 = v % width ;
            int y0 = v / width ;

            for(int t=-1;t<2;t++) {
                int x = x0 + (bVertical?t:1 ) ;
                int y = y0 + (bVertical?1:t ) ;
                if ( x<0 || y<0 || x>=width || y>=height) continue ;
                int w = y*width + x   ;
                // relax ( v->w )
                if (distTo[w] > distTo[v] + energy_matrix[y][x] ) {
                    distTo[w] = distTo[v] + energy_matrix[y][x] ;
                    edgeTo[w] = v;
                }    
            }
        }

        int end_vertex = Integer.MAX_VALUE ;
        if ( bVertical ) {
            for(int i=0;i<width; i++) {
                int v = (height-1) * width + i ;
                if ( end_vertex == Integer.MAX_VALUE || distTo[end_vertex] > distTo[v] ) 
                    end_vertex = v ;  
            }    
        } else {
            for(int i=0;i<height; i++) {
                int v = (i+1)*width -1 ;    
                if ( end_vertex == Integer.MAX_VALUE || distTo[end_vertex] > distTo[v] ) 
                    end_vertex = v ;  
            }
        }

        // pathTo(int v)
        Stack<Integer> path = new Stack<Integer>();
        path.push(end_vertex);
        for (int e = edgeTo[end_vertex]; e != -1; e = edgeTo[e] )
            path.push(e);

        int[] ret = new int[path.size()];
        for( int i=0; i< ret.length ; i++ )
            ret[i] = path.pop();

        return ret; 
    }
    /*
     * edges: array of vertex
     *
     * return: array of seam point , it only include x, or y coordinates
     */
    private  int[] convertEdgeSP(int[] edges, boolean bVertical ) {

        int width = width();
        int height = height();
        //for( int val : path ) 
        for ( int i=0; i< edges.length ; i++ )
        {
            int val = edges[i] ;
            int x = val % width ;
            int y = val / width ; 
            edges[i]  =  bVertical? x : y   ;     
        }   
        return edges ;
    }

    // start 
    private void CheckNullArgument( Object arg ) {
        if (arg ==null) 
            throw new java.lang.IllegalArgumentException("arguments is null");
    }
    private void CheckWrongSeam( int[] seam , boolean bVertical ) {
        // System.out.println( width() + " " + height()  );

        if ( seam.length != ( bVertical ? height() : width() )  )
            throw new java.lang.IllegalArgumentException("wrong length of seam[] " );   
        if ( (bVertical && width() <=1) || (!bVertical && height() <=1)  )
            throw new java.lang.IllegalArgumentException("picture is too  small to carve " ); 

        int max = seam[0] ;  if (max<0) throw new java.lang.IllegalArgumentException("wrong seam data < 0" ); 
        int tmpVal ;
        for(int i=1; i< seam.length; i++) {
            tmpVal = seam[i] ;
            if(tmpVal<0) throw new java.lang.IllegalArgumentException("wrong seam data < 0" );   
            if (  Math.abs( tmpVal - seam[i-1] ) >1  )
                throw new java.lang.IllegalArgumentException("wrong seam data , entries differ > 1 " ); 
        
            max = Math.max( max, tmpVal  ) ;
            
        }

        // if the array is not a valid seam (i.e., either an entry is outside its prescribed range or two adjacent entries differ by more than 1).
        if ( max >= ( !bVertical ? height() : width() )  ) 
            throw new java.lang.IllegalArgumentException("wrong seam data >= width() or height()" );
    }
    // end 

    private int[][] colorMatrix ; 
    private int __width ;
    private int __height ;

    private void updateEnergyMatrix() {
        
        for( int j=0 ; j< __height ; j++ ) {
            for( int i=0; i< __width ; i++  ) {
                energy_matrix[j][i] = energy( i,j ); 
            }
        }
    }

    public SeamCarver( final Picture picture)                // create a seam carver object based on the given picture
    {
        CheckNullArgument(picture) ;
        if ( picture.width() ==0 || picture.height()==0 )
            throw new java.lang.IllegalArgumentException("can not be a empty picture " );

        __width = picture.width();
        __height = picture.height();

        // copy all image pixel into colorMatrix
        colorMatrix = new int[picture.height()][picture.width()];
        for( int j=0 ; j< __height ; j++ ) {
            for( int i=0; i< __width ; i++  ) {
                colorMatrix[j][i] = picture.get( i,j ).getRGB();
            }
        }

        energy_matrix = new double[picture.height()][picture.width()];
        updateEnergyMatrix();


        /*
        for (int row = 0; row < picture.height(); row++) {
            for (int col = 0; col < picture.width(); col++)
                StdOut.printf("%9.2f ", energy_matrix[row][col]  );
            StdOut.println();
        }
        //*/
    }
    public Picture picture()                          // current picture
    {
        int width = width();
        int height = height();
        Picture picture = new Picture(width, height);
        for (int row = 0; row < height; row++) {
            for (int col = 0; col < width; col++) {
                picture.set(col, row, new Color(colorMatrix[row][ col ])  );

            }
        }

        return picture ;    
    }
    public     int width()                            // width of current picture
    {
        return __width ;
    }
    public     int height()                           // height of current picture
    {
        return __height ;
    }

    /*
     * axis_index : 0 for horizontal, 1 for vertical 
     * color_index :   0 for R , 1 for G , 2 for B
     */
    private float CentralDifference( int x, int y , int axis_index ,  int color_index ) {
        int c1 = axis_index ==0 ?  colorMatrix[y][ x+1 ] :colorMatrix[ y+1 ][x] ;
        int c2 = axis_index ==0 ?  colorMatrix[y][ x-1 ] :colorMatrix[ y-1 ][x] ;
        
        
        return ( ( c1 >> ( ( 2-color_index  ) <<3  ) ) & 0xFF  )    
            -  ( ( c2 >> ( ( 2-color_index  ) <<3  ) ) & 0xFF  )   ;
    }
    
    private double energy_matrix[][] ;
    public  double energy(int x, int y)               // energy of pixel at column x and row y
    {
        if ( ( x < 0 || x >= width() ) || ( y < 0 || y >= height() ) )
            throw new java.lang.IllegalArgumentException("x y used for calc energy is out of range of index");
        if ( ( x == 0 || x == width()-1 ) || ( y == 0 || y == height()-1 ) )
            return 1000 ;
        
        float Rx = CentralDifference( x, y , 0, 0) ;
        float Gx = CentralDifference( x, y , 0, 1) ;
        float Bx = CentralDifference( x, y , 0, 2) ;
        float Ry = CentralDifference( x, y , 1, 0) ;
        float Gy = CentralDifference( x, y , 1, 1) ;
        float By = CentralDifference( x, y , 1, 2) ;

        float dx2 = Rx*Rx + Gx*Gx + Bx*Bx ;
        float dy2 = Ry*Ry + Gy*Gy + By*By ;

        return Math.sqrt( dx2 + dy2 ) ;    
    }
    public   int[] findHorizontalSeam()               // sequence of indices for horizontal seam
    {
        int width = width();
        int height = height();
        ArrayList<Integer> source_vertices = new ArrayList<Integer> ();
        for(int i=0;i<height; i++) {
            source_vertices.add(i*width) ;
        }

        int[] edgePath = AcyclicSP(  source_vertices , false );

        return  convertEdgeSP(edgePath , false  ) ;
    }
    public   int[] findVerticalSeam()                 // sequence of indices for vertical seam
    {
        int width = width();
        int height = height();
        ArrayList<Integer> source_vertices = new ArrayList<Integer> ();
        for(int i=0;i<width; i++) {
            source_vertices.add(i) ;
        }

        int[] edgePath = AcyclicSP(  source_vertices ,true);

        return  convertEdgeSP(edgePath , true  ) ;
    }
    public    void removeHorizontalSeam(int[] seam)   // remove horizontal seam from current picture
    {
        CheckNullArgument( seam );
        CheckWrongSeam( seam, false  );

        int height = height();
        for (int j=0; j<seam.length; j++) {  // col
            int index = seam[j] ;  // row index
            
            for( int i= index ; i< height -1 ; i++  ) { // row
                // row i 
                colorMatrix[i][j] = colorMatrix[i+1][j];
            }     
        }        

        __height -- ;
        updateEnergyMatrix();

    }
    public    void removeVerticalSeam(int[] seam)     // remove vertical seam from current picture
    {
        CheckNullArgument( seam );
        CheckWrongSeam( seam, true  );

        for(int i=0;i<seam.length; i++ ) {
            int index = seam[i] ;
            System.arraycopy( colorMatrix[i] , index+1 , colorMatrix[i] , index , colorMatrix[i].length-index-1   );           
        }

        __width -- ;
        updateEnergyMatrix();
    }

}
