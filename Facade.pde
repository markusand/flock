import java.util.Iterator;

public class Facade<T extends Element> implements Iterable<T> {

    private ArrayList<T> items = new ArrayList();
    
    private void add(T... newItems) {
        for(T item : newItems) items.add(item);
    }

    public int count() {
        return items.size();
    }
    
    @Override
    public Iterator<T> iterator() {
        return items.iterator();
    }
    
}
