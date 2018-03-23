import java.util.Iterator ; 
import java.lang.* ;
import edu.princeton.cs.algs4.StdRandom;


public class RandomizedQueue<Item> implements Iterable<Item> {
    private Item[] a;         // array of items
    private int n;            // number of elements on stack



    public RandomizedQueue()                 // construct an empty randomized queue
    {
        a = (Item[]) new Object[2];
        n = 0;   
    }
    public boolean isEmpty()                 // is the queue empty?
    {
        return n == 0;   
    }
    public int size()                        // return the number of items on the queue
    {
        return n ;    
    }

// resize the underlying array holding the elements
    private void resize(int capacity) {
        assert capacity >= n;

        // textbook implementation
        Item[] temp = (Item[]) new Object[capacity];
        for (int i = 0; i < n; i++) {
            temp[i] = a[i];
        }
        a = temp;

       // alternative implementation
       // a = java.util.Arrays.copyOf(a, capacity);
    }

    public void enqueue(Item item)           // add the item
	{	
		if (item ==null) throw new java.lang.NullPointerException();
		if (n == a.length) resize(2*a.length);    // double size of array if necessary
        a[n++] = item;  
        // for (int i=0 ; i< n ; i++)
        //     System.out.println( i + ":" + a[i]  );
	}

    public Item dequeue()                    // remove and return a random item
	{
		if (isEmpty()) throw new java.util.NoSuchElementException() ;
        int index = StdRandom.uniform(n) ;
        Item item = a[index] ;
        a[index] = a[n-1] ;
        a[n-1] = item ; 

        // Item item = a[n-1];
        a[n-1] = null;                              // to avoid loitering
        n--;
        // shrink size of array if necessary
        if (n > 0 && n == a.length/4) resize(a.length/2);
        return item;	
	}
    public Item sample()                     // return (but do not remove) a random item
	{
		if (isEmpty()) throw new java.util.NoSuchElementException() ;
        int index = StdRandom.uniform(n) ;
        return a[index]; 
	}
    public Iterator<Item> iterator()         // return an independent iterator over items in random order
	{
        return new ReverseArrayIterator();

    }

// an iterator, doesn't implement remove() since it's optional
    private class ReverseArrayIterator implements Iterator<Item> {
        private int i;
        private int randIndeces[] ;
        public ReverseArrayIterator() {
            i = n-1;
            randIndeces = StdRandom.  permutation(n);
        }

        public boolean hasNext() {
            return i >= 0;
        }

        public void remove() {
            throw new java.lang.UnsupportedOperationException();
        }

        public Item next() {
            if (!hasNext()) throw new java.util.NoSuchElementException() ;
            return a[ randIndeces[ i--] ] ;
        }
    }

    public static void main(String[] args)   // unit testing (optional)
	{}

}


