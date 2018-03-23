import java.lang.String ;
import java.util.LinkedList;
import edu.princeton.cs.algs4.StdRandom;


public class Test {
    
    public static void main(String[] args)
    {
        for (int j=0 ; j<1000 ; j++) {
            System.out.println("test: "+ j );
            
            LinkedList<String> lst = new LinkedList<String>();
            Deque<String> dq = new Deque<String>();
            for (int i=0 ; i< 100 ; i++) {
                
                int operation= StdRandom.uniform(4) ; // 0,1,2,3  
                
                String operand = "" + StdRandom. uniform(100) ;
                switch (operation) {
                    case 0:
                        dq.addFirst( operand  )   ;
                        lst.addFirst( operand  )   ;
                        break ;
                    case 1:
                        dq.addLast( operand  ); 
                        lst.addLast( operand  ); 
                        break ;
                    case 2:
                        if ( dq.isEmpty() ) continue ; 
                        dq.removeFirst();
                        lst.removeFirst();
                        break ;
                    case 3:
                        if ( dq.isEmpty() ) continue ; 
                        dq.removeLast();
                        lst.removeLast();
                        break; 
                        
                }               

                // System.out.println( i + " : " + operation + " :: " + dq.size() + " -  " + lst.size() + " " + (dq.isEmpty()? "isEmpty" : "not empty") );

            }      // end 1 test case 
            if ( dq.size() != lst.size()  ) {
                throw new java.util.NoSuchElementException () ;
           }
        }
    }                                         
}
