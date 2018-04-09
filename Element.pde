public abstract class Element {
    
    protected final int ID;
    protected final int MASS;
    protected final int R;
    
    protected PVector position;
    protected boolean suicide;
    
    public Element(int id, int x, int y, int mass, int r) {
        ID = id;
        position = new PVector(x, y);
        MASS = mass;
        R = r;
    }
    
    public PVector getPosition() {
        return position;
    }
    
    public void draw() {
        noFill(); stroke(#FFFFFF); strokeWeight(2);
        point(position.x, position.y);
    }
    
    public abstract void update(Facade<Element> elements);
    public abstract PVector interact(Element e);
}
