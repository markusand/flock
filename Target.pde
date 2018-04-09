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
