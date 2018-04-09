import java.util.Iterator;

public class Facade<T extends Element> implements Iterable<T> {

    private ArrayList<T> items = new ArrayList();
    
    
    private void add(T... newItems) {
        for(T item : newItems) items.add(item);
    }


    public int count() {
        return items.size();
    }
    
    
    public Facade<T> filter(Filter<T> filter) {
        Facade<T> filtered = new Facade();
        for(T item : items) {
            if(filter.evaluate(item)) filtered.add(item);
        }
        return filtered;
    }
    
    
    @Override
    public Iterator<T> iterator() {
        return items.iterator();
    }
    
}


public interface Filter<T> {
    public boolean evaluate(T item);
}


public static class Filters {
    
    public static <T extends Element> Filter<T> closeInstance(final Class c, final int d, final PVector pos) {
        return new Filter<T>() {
            @Override
            public boolean evaluate(T e) {
                return c.isInstance(e) && pos.dist(e.getPosition()) < d;
            }
        };
    }
    
};
