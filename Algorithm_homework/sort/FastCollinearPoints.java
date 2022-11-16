
import  java.util.ArrayList ;
import  java.util.Arrays ; 
import java.io.* ;
import edu.princeton.cs.algs4.StdDraw;
import edu.princeton.cs.algs4.In ;
import edu.princeton.cs.algs4.StdOut ; 

public class FastCollinearPoints {
   private Point[] points ;
   private ArrayList<LineSegment> collinear_segements = new ArrayList<LineSegment>();
   

   private boolean checkDup( Point origin , Point toCheck ) {
       boolean result =  toCheck.compareTo( origin ) < 0 ;
       // if (result ) 
       //     System.out.println( " dup !! " );
       return result ;
   }
   public FastCollinearPoints(Point[] points) {
        this.points  = new  Point[ points.length ]  ; 
        System.arraycopy(  points , 0 ,  this.points , 0 ,  points.length  );
        Arrays.sort( this.points  ) ;
        ArrayList<Point> points_array = new ArrayList<Point> (  );
         
        int n = this.points.length ;
        for ( int i=0 ; i< n ; i++ ) {
            points_array.add( this.points[i] );       
        } 

        for ( int i=0 ; i< n ; i++ ) {
            Point[] pts = points_array.toArray( new Point[0] );                           
            
            // System.out.println( "sort points by coords" );
            // for (int z = 0 ; z < n ; z++)
            //     System.out.println( z  + " -> " + pts[z].toString ()  );
            
            Point origin = pts[i] ;
            Arrays.sort( pts ,  origin. slopeOrder() ) ;

            // System.out.println( "sort points by slope with point " + i );
            // for (int z = 0 ; z < n ; z++)
            //     System.out.println( z  + " -> " + pts[z].toString ()+ " " + pts[0].slopeTo( pts[z] )  );
            
            Point startPt = pts[0] ;

            double currentSlope = startPt.slopeTo( pts[1] );
            int ptCnt = 2 ;
            boolean bDup = checkDup( origin , pts[1] );
            for ( int j = 2 ; j< n ; j++  ) {
                // System.out.println( i + " " + j + " " + startPt.slopeTo( pts[j] ) + " cur slope: " + currentSlope );
                if ( currentSlope == startPt.slopeTo( pts[j] )   ) {
                    ptCnt ++ ;   
                    if(!bDup )
                        bDup = checkDup( origin , pts[j] );

                } 
                
                // break 
                if ( currentSlope != startPt.slopeTo( pts[j] ) || j==n-1   ) {
                 
                 
                    int lastIndex = j-1 ;
                    
                    // last point is a legal point  
                    if ( currentSlope == startPt.slopeTo( pts[j] ) && j==n-1 )
                        lastIndex = j ;


                    // System.out.println( "   break: " +  i + " " + j + " " + ptCnt+ " cur slope: " + currentSlope  );
                    if ( ptCnt >=4 && !bDup  ) {
                        LineSegment seg = new LineSegment( startPt , pts[ lastIndex  ]  ) ;
                        collinear_segements.add(  seg );    
                        // System.out.println( "segment found !!! " +  seg.toString()  );
                    } 
                    
                    bDup = false ;
                    currentSlope = startPt.slopeTo( pts[j] ); 
                    ptCnt = 2 ;    
                    if(!bDup )
                        bDup = checkDup( origin , pts[j] );
                }
            }
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
		FastCollinearPoints  collinear = new FastCollinearPoints (points);
		for (LineSegment segment : collinear.segments()) {
			StdOut.println(segment);
			segment.draw();
		}
		StdDraw.show();
	}
}



