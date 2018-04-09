public class Obstacle extends Element {
    
    public Obstacle(int id, int x, int y, int R) {
        super(id, x, y, R, R);
    }

    
    @Override
    public void update(Facade<Element> elements) {
    }
    
    
    @Override
    public PVector interact(Element e) {
        PVector force = new PVector();
        if(e instanceof Mover) {
            Mover m = (Mover) e;
            for(PVector feeler : m.getFeelers()) {
                PVector spearhead = PVector.add(m.getPosition(), feeler);
                PVector[] collisions = Geometry.intersectionLineCircle(m.getPosition(), spearhead, position, R);
                if(collisions.length > 0) {
                    force.add(PVector.mult(m.getVelocity(), -1)); // Breaking force
                    float penetration = PVector.sub(spearhead, collisions[0]).mag();
                    PVector reaction = position.dist(m.getPosition()) > R ?
                        PVector.sub(collisions[0], position) :
                        PVector.sub(position, collisions[0]);
                    force.add(reaction.setMag(penetration));
                }
            }
        }
        return force;
    }
    
    @Override
    public void draw() {
        noFill(); stroke(#555555);
        ellipse(position.x, position.y, 2*R, 2*R);
    }
    
}
