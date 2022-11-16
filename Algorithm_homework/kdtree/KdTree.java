
import edu.princeton.cs.algs4.Point2D;
import edu.princeton.cs.algs4.RectHV;
import edu.princeton.cs.algs4.StdDraw;
import edu.princeton.cs.algs4.StdOut;

public class KdTree{
    // private int debug_cnt = 0 ;
	private static class Node {
		public Point2D p;      // the point
		public RectHV rect;    // the axis-aligned rectangle corresponding to this node
		public Node lb;        // the left/bottom subtree
		public Node rt;        // the right/top subtree

        public Node( Point2D pt , RectHV rect  ) {
            this.p = pt ; 
            this.rect = rect ; 
            this.lb = null ;
            this.rt = null ;    
        }
	}

    private Node root ;
    private int size ; 
    public KdTree()                               // construct an empty set of points 
    {
        root = null ;
        size = 0 ;
    }
    public           boolean isEmpty()                      // is the set empty? 
    {
        return root == null   ;
    }
    public               int size()                         // number of points in the set 
    {
        return size ; 
    }
    public              void insert(Point2D p)              // add the point to the set (if it is not already in the set)
    {
        if (p==null)   
            throw new java.lang.NullPointerException();
        
        
        // for dup key
        if ( root !=null &&  contains(p) ) {
            return ;
        } 
        root = put( root ,  p  , new RectHV(0,0,1,1) , 0 ) ;
    }

    private Node put( Node x , Point2D p , RectHV rect,  int level  ) {
        if ( x == null ) {
            size++ ; 
            return new Node( p ,rect ) ;
        }   
             
        double key2insert , key2compare;
        double x0,y0,x1,y1 ;
        double xm , ym ;
        x0 = x.rect.xmin();
        y0 = x.rect.ymin();
        x1 = x.rect.xmax();
        y1 = x.rect.ymax();
        
        if ((level&1)==0) {
            key2insert = p.x();
            key2compare= x.p.x(); 

            if ( key2insert < key2compare) x.lb = put( x.lb , p , x.lb!=null ? x.lb .rect : new RectHV(x0,y0, key2compare  ,y1)    , level+1)  ;
            else x.rt = put(x.rt , p,  x.rt !=null? x.rt.rect :new RectHV( key2compare , y0, x1  ,y1)  ,  level+1)  ;
        } else {
            key2insert = p.y();
            key2compare= x.p.y(); 

            if ( key2insert < key2compare) x.lb = put( x.lb , p ,  x.lb!=null?x.lb.rect :new RectHV(x0,y0, x1  , key2compare  )    , level+1)  ;
            else x.rt = put(x.rt , p,  x.rt!=null?x.rt .rect :new RectHV( x0 , key2compare  , x1  ,y1)  ,  level+1)  ;
        } 

        return x ; 
    }
    


    public           boolean contains(Point2D p)            // does the set contain point p? 
    {
        if (p==null)   
            throw new java.lang.NullPointerException();

        Node node =  get(root, p , 0) ;
        return node != null ;
    }
    
    private Node get( Node x , Point2D p , int level )  {
        if ( x==null ) return null ;
               
        double key2insert , key2compare;
        if ((level&1)==0) {
            key2insert = p.x();
            key2compare= x.p.x(); 
        } else {
            key2insert = p.y();
            key2compare= x.p.y(); 
        }
        if ( key2insert < key2compare)  return get( x.lb , p , level+1 );
        else {
            if ( key2insert == key2compare &&  x.p.equals(p) ) 
                return x ; 
            return get(x.rt , p, level+1) ;
        }

    }


    public              void draw()                         // draw all points to standard draw 
    {
        drawSquare( root , 0 ) ;
    }
    private void drawSquare( Node x , int level ) {
            
        if (x==null) return ;

        if ( (level&1) ==0 ) {
            StdDraw.setPenColor(StdDraw.RED) ;
            StdDraw.setPenRadius() ;
            StdDraw.line( x.p.x() , x.rect.ymin(), x.p.x(), x.rect.ymax());
        }else {
            StdDraw.setPenColor(StdDraw.BLUE)    ;
            StdDraw.setPenRadius() ;  
            StdDraw.line(  x.rect.xmin(), x.p.y(), x.rect.xmax() , x.p.y() );
        }
        StdDraw.setPenColor(StdDraw.BLACK) ;
        StdDraw.setPenRadius(0.01) ;
        x.p.draw();

        drawSquare( x.lb , level+1 );
        drawSquare( x.rt , level+1 );
    }

    public Iterable<Point2D> range(RectHV rect)             // all points that are inside the rectangle 
    {
        if (rect==null)   
            throw new java.lang.NullPointerException();

        java.util.ArrayList<Point2D> list = new java.util.ArrayList<Point2D>();

        rangeSearch( root, rect  , list  ) ;
         
        return list ;
    }

    private void rangeSearch( Node x, RectHV rect , java.util.ArrayList<Point2D> list  ) {
        if (x == null) return ;

        // double x0,y0,x1,y1 ;
        // x0 = x.rect.xmin();
        // y0 = x.rect.ymin();
        // x1 = x.rect.xmax();
        // y1 = x.rect.ymax();
        // System.out.println( "Range:" + x0 + "," + y0 + "," + x1  + "," + y1 + "  " + x.p.x() + "-" + x.p.y()   );
        if( x.rect.intersects(rect)  )  {
            if (rect.contains(x.p)  )
                list.add( x.p ); 
        }
        else 
            return ;
        rangeSearch( x.lb , rect, list ) ;
        rangeSearch( x.rt , rect, list ) ; 
    }


    public           Point2D nearest(Point2D p)             // a nearest neighbor in the set to point p; null if the set is empty 
    {
        if (p==null)   
            throw new java.lang.NullPointerException();

        double[] minDist = new double[1] ;
        minDist[0] = Double.MAX_VALUE  ;
        Point2D result =  nearestSearch( root  , p , 0, minDist  )  ; 
        
        // System.out.println( "api call : "  + debug_cnt  );
        return result ; 
    }

    private Point2D  nearestSearch( Node x , Point2D p ,int level ,  double[] minDist  ) {
        if (x==null) return null ;
        
        if ( minDist[0] <= x.rect.distanceSquaredTo( p )  )  return null ;
        // debug_cnt ++ ;
        

        Point2D nearestPt = null  ;
        
        double dist = x.p.distanceSquaredTo( p ) ;
        if( dist < minDist[0]  ) {
            nearestPt = x.p ; 
            minDist[0] = dist  ; 
        }
        

        // when there are two possible subtrees to go down
        //  choose the subtree that is on the same side of the splitting line as the query point as the first subtree to explore
        
        Node firstSubtree = x.lb ;
        Node secondSubtree = x.rt ;
        
        if (  ((level&1)==0 && p.x() >=  x.p.x()) || ((level&1)==1 && p.y() >=  x.p.y())  )
        {
           firstSubtree = x.rt ; 
           secondSubtree = x.lb ;     
        }

        Point2D  nearestPtSub = nearestSearch( firstSubtree  , p, level+1,  minDist) ;
        if (nearestPtSub!=null) {
            nearestPt = nearestPtSub  ; 
        } 
          
        nearestPtSub = nearestSearch( secondSubtree  , p, level+1,  minDist) ;
        if (nearestPtSub!=null) {
            nearestPt = nearestPtSub  ; 
        }
        
        return nearestPt ;  
    }

    public static void main(String[] args)                  // unit testing of the methods (optional) 
    {
        KdTree kdtree = new KdTree();
        int n = 10000 ;
        for(int i=0;i<10000;i++) {
            double x = edu.princeton.cs.algs4.StdRandom.uniform() ;
            double y = edu.princeton.cs.algs4.StdRandom.uniform() ;
            Point2D p = new Point2D(x, y);
            kdtree.insert(p);
        }
        // kdtree.range( new RectHV( 0.4,0.4, 0.6,0.6 ) ) ;
        kdtree.nearest( new Point2D( 0.4,0.6 ) ) ;

    }
}

