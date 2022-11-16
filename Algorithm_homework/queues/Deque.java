import java.util.Iterator ;
import java.lang.* ;
public class Deque<Item> implements Iterable<Item> {
	private class Node
	{
		Item item;
		Node next; 
        Node prev ; 
        int index ;
	}
	private Node first = null;
	private Node last = null ;


	public Deque()                           // construct an empty deque
	{
	}
	public boolean isEmpty()                 // is the deque empty?
	{
		return first == null ;
	}
	public int size()                        // return the number of items on the deque
    {
        if (first ==null || last == null )
            return 0;
        else 
            return last.index - first.index + 1;
    }
	public void addFirst(Item item)          // add the item to the front
    {
        if (item == null) throw new java.lang.NullPointerException();
        Node oldfirst = first;
        first = new Node();
        first.item = item;
        first.next = oldfirst;  if(oldfirst !=null)  oldfirst.prev = first ;
        first.index = oldfirst== null ? 0:oldfirst.index -1 ;
        if(last ==null) last = first ;
    }
	public void addLast(Item item)           // add the item to the end
    {
        if (item == null) throw new java.lang.NullPointerException();
        if (0==size() ) {
            addFirst( item );
            return ;   
        }
    
        // non-empty list 
        Node oldlast = last;
        last = new Node();
        last.item = item;
        last.next = null;
        
        last.index = oldlast.index +1 ;
        oldlast.next = last;    last.prev = oldlast ; 
    }
	public Item removeFirst()                // remove and return the item from the front
    {
        if (0==size() ) throw new java.util.NoSuchElementException();

        Item item = first.item;
        first = first.next; if(first!=null)  first.prev = null ;
        if (0==size()) { first = null ; last = null; }
        return item;   
    }
	public Item removeLast()                 // remove and return the item from the end
    {
        if (0==size() ) throw new java.util.NoSuchElementException();
        if (size()==1) 
            return removeFirst ();
    
        Item item = last.item ;
        last = last.prev ;  
        if (0==size()) {first = null ; last = null ; }
        return item ;
    }
    private class ListIterator implements Iterator<Item> {
        private Node current = first ; 
        public boolean hasNext() {
            return current != null ;   
        }   
        public void remove() {
            throw new java.lang.UnsupportedOperationException();    
        };
        public Item next() {
            if(!hasNext()) throw new java.util.NoSuchElementException();
            Item item = current.item ;
            current = current.next;   
            return item;
        }
    }
	public Iterator<Item> iterator()         // return an iterator over items in order from front to end
    {
        return new ListIterator();
    }
	public static void main(String[] args)   // unit testing (optional)
    {
    }
}


