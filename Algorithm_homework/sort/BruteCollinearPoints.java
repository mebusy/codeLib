import  java.util.ArrayList ;
import  java.util.Arrays ; 
import java.io.* ;
import edu.princeton.cs.algs4.StdDraw;
import edu.princeton.cs.algs4.In ;
import edu.princeton.cs.algs4.StdOut ; 

public class BruteCollinearPoints {

   private Point[] points ;
   private ArrayList<LineSegment> collinear_segements = new ArrayList<LineSegment>();
   public BruteCollinearPoints(Point[] points)    // finds all line segments containing 4 points
   {
        this.points = new Point[ points.length ] ;
        System.arraycopy(  points , 0 ,  this.points , 0 ,  points.length  );
        Arrays.sort( this.points  );
        
        
        // apparently this solution has problem , it can not handle that case: 
        // p1,p2,p3,p4, and , p1, p2,p3 ,p5 has the sampe slope          
        int n = this.points.length ;
        for (int i=0; i<n-3 ; i++ ) 
            for ( int j= i+1 ; j < n-2 ; j++  )
                for ( int k = j+1 ; k < n-1 ; k++   )
                    for ( int l = k+1 ; l<n ; l++  )
                    {
                        Point p1 = this.points[i] ;
                        Point p2 = this.points[j] ;
                        Point p3 = this.points[k] ;
                        Point p4 = this.points[l] ;
                        
                        double s = p1.slopeTo(p2) ;
                        if ( s == p2.slopeTo(p3) && s== p3.slopeTo(p4)  ) 
                            collinear_segements.add( new LineSegment( p1 , p4  )  );
                                                
                    }
   }
   public int numberOfSegments()        // the number of line segments
   {
        return collinear_segements.size() ;   
   }
   public LineSegment[] segments()                // the line segments
   {
        return collinear_segements.toArray( new LineSegment[0] ) ;    
   }

   public static void main(String[] args) {

		// read the n points from a file
		In in = new In(args[0]);
		int n = in.readInt();
		Point[] points = new Point[n];
		for (int i = 0; i < n; i++) {
			int x = in.readInt();
			int y = in.readInt();
			points[i] = new Point(x, y);
		}

		// draw the points
		StdDraw.enableDoubleBuffering();
		StdDraw.setXscale(0, 32768);
		StdDraw.setYscale(0, 32768);
		for (Point p : points) {
			p.draw();
		}
		StdDraw.show();

		// print and draw the line segments
		BruteCollinearPoints collinear = new BruteCollinearPoints(points);
		for (LineSegment segment : collinear.segments()) {
			StdOut.println(segment);
			segment.draw();
		}
		StdDraw.show();
	}
 

}



