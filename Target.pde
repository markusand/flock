public class Target extends Element {
    
    public Target(int id, int x, int y) {
        super(id, x, y, 10, 10);
    }
    
    
    @Override
    public void draw() {
        stroke(#00FF00); noFill();
        ellipse(position.x, position.y, R, R);
    } 

    
    @Override
    public void update(Facade elements) {
    }
    
    
    @Override
    public PVector interact(Element e) {
        return new PVector();
    }
    
}



public class Attractor extends Element {

    private final float GRAVITY = 0.006674;
    private int size;
    
    public Attractor(int id, int x, int y, int mass) {
        super(id, x, y, mass, mass);
    }
    
    
    @Override 
    public void update(Facade elements) {
    }
    
    
    @Override
    public PVector interact(Element e) {
        float d = position.dist(e.getPosition());
        if(d < R) e.suicide = true;
        return PVector.sub(position, e.getPosition()).setMag(GRAVITY * MASS * e.MASS / d * d);
    }
    
    
    @Override
    public void draw() {
        size = (size + 1) % R;
        float opacity = 255 - (float)size * 255 / R;
        stroke(#888888); fill(#888888, opacity);
        ellipse(position.x, position.y, 2*size, 2*size);
        ellipse(position.x, position.y, 2*R, 2*R);
    }
    
}
