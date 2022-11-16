import edu.princeton.cs.algs4.StdIn;
import java.lang.* ; 
import java.util.Iterator ;
public class Permutation {
    public static void main(String[] args) {
        RandomizedQueue<String> rq = new  RandomizedQueue<String>();
        int k = Integer.parseInt( args[0])  ;

        while (!StdIn.isEmpty()) {
            String s = StdIn.readString();
            rq.enqueue( s ) ;   
            // System.out.println( "enquene: " + s  );
        }



        Iterator<String > itor = rq.iterator();

        for (int i=0;i<k ; i++) {
            System.out.println( itor.next() );   
        }
        
    }
}


