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



public class Wall extends Obstacle {

    private final PVector[] SEGMENTS;
    
    public Wall(int id, PVector... segments) {
        super(id, 0, 0, 0);
        SEGMENTS = segments;
    }
    
    
    @Override
    public PVector interact(Element e) {
        PVector force = new PVector();
        if(e instanceof Mover) {
            Mover m = (Mover) e;
            PVector pos = m.getPosition();
            for(int i = 1; i < SEGMENTS.length; i++) {
                for(PVector feeler : m.getFeelers()) {
                    PVector spearhead = PVector.add(pos, feeler);
                    PVector collision = Geometry.linesIntersection(pos, spearhead, SEGMENTS[i-1], SEGMENTS[i]);
                    if(collision != null) {
                        float side = (SEGMENTS[i].x - SEGMENTS[i-1].x)*(pos.y - SEGMENTS[i-1].y) - (SEGMENTS[i].y - SEGMENTS[i-1].y)*(pos.x - SEGMENTS[i-1].x);
                        force.add(PVector.mult(m.getVelocity(), -1)); // Breaking force
                        float penetration = PVector.sub(spearhead, collision).mag();
                        PVector reaction = PVector.sub(SEGMENTS[i], SEGMENTS[i-1]).rotate(side < 0 ? -HALF_PI : HALF_PI);
                        force.add(reaction.setMag(penetration));
                    }
                }
            }
        }
        return force;
    }
    
    
    @Override
    public void draw() {
        for(int i = 1; i < SEGMENTS.length; i++) {
            stroke(#AAAAAA);
            line(SEGMENTS[i-1].x, SEGMENTS[i-1].y, SEGMENTS[i].x, SEGMENTS[i].y);
        }
    }
    
}
