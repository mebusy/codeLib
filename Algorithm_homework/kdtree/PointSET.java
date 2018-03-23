
import edu.princeton.cs.algs4.Point2D;
import edu.princeton.cs.algs4.RectHV;
import edu.princeton.cs.algs4.StdDraw;
import edu.princeton.cs.algs4.StdOut;
import java.util.TreeSet; 

public class PointSET {
    private TreeSet<Point2D> rbTree ;
    public         PointSET()                               // construct an empty set of points 
    {
        rbTree = new TreeSet<Point2D>();
    }
    public           boolean isEmpty()                      // is the set empty? 
    {
        return rbTree.isEmpty() ;
    }
    public               int size()                         // number of points in the set 
    {
        return rbTree.size();
    }
    public              void insert(Point2D p)              // add the point to the set (if it is not already in the set)
    {
        if (p==null)   
            throw new java.lang.NullPointerException();

        rbTree.add( p ) ;
    }
    public           boolean contains(Point2D p)            // does the set contain point p? 
    {
        if (p==null)   
            throw new java.lang.NullPointerException();
        return rbTree.contains( p );
    }
    public              void draw()                         // draw all points to standard draw 
    {
        java.util.Iterator<Point2D> iter = rbTree.iterator();
        while( iter.hasNext() ) {
            iter.next().draw();
        }

    }
    public Iterable<Point2D> range(RectHV rect)             // all points that are inside the rectangle 
    {
        if (rect==null)   
            throw new java.lang.NullPointerException();

        java.util.ArrayList<Point2D> list = new java.util.ArrayList<Point2D>();
         
        java.util.Iterator<Point2D> iter = rbTree.iterator();
        while( iter.hasNext() ) {
            Point2D pt = iter.next() ;
            if ( rect.contains( pt ) )  list.add( pt ) ;
        }
        return list ;
    }
    public           Point2D nearest(Point2D p)             // a nearest neighbor in the set to point p; null if the set is empty 
    {
        if (p==null)   
            throw new java.lang.NullPointerException();

        Point2D ptNearest = null ;
        double minDist = -1 ; 
        java.util.Iterator<Point2D> iter = rbTree.iterator();
        while( iter.hasNext() ) {
            Point2D pt = iter.next() ;
            double dist = p.distanceSquaredTo(pt) ;
            if ( minDist < 0 || dist < minDist  ) {
                minDist = dist ;
                ptNearest = pt ;     
            }
        }
        return ptNearest  ; 
    }

    public static void main(String[] args)                  // unit testing of the methods (optional) 
    {
    }
}

