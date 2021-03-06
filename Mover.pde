public abstract class Mover extends Element {
    
    protected final float MAX_SPEED;
    protected final float MAX_FORCE;
    
    protected final int FEELERS_NUM = 3; // ODD VALUE SUGGESTED
    protected final int FEELERS_LENGTH = 10;
    protected final float FEELERS_ANGLE = HALF_PI;
    protected PVector[] feelers;
    
    protected PVector velocity = new PVector();
    protected PVector acceleration = new PVector();
    
    protected Facade<Element> objectives = new Facade();
    protected Steering steering;
    
    public Mover(int id, int x, int y, int mass, int R, float maxSpeed, float maxForce) {
        super(id, x, y, mass, R);
        MAX_SPEED = maxSpeed;
        MAX_FORCE = maxForce;
        steering = Steering.WANDER;
    }
    
    
    public PVector getVelocity() {
        return velocity;
    }
    
    
    @Override
    public void update(Facade<Element> elements) {
        decideSteering(elements);
        PVector force = steering.interact(this, objectives);
        updateFeelers();
        for(Element e : elements) {
            force.add(e.interact(this));
        }
        applyForce(force);
    }
    
    
    @Override
    public PVector interact(Element e) {
        PVector union = PVector.sub(e.getPosition(), position);
        float d = union.mag();
        float minD = R + e.R;
        if(d < minD) return union.setMag(minD - d);
        return new PVector();
    }
    
    
    public void applyForce(PVector force) {
        //force.limit(MAX_FORCE);
        acceleration.add(force.div(MASS));
        velocity.add(acceleration);
        velocity.limit(MAX_SPEED);
        position.add(velocity);
        acceleration.mult(0);
        if(position.x > width) position.x = 0;
        else if(position.x < 0) position.x = width;
        if(position.y > height) position.y = 0;
        else if(position.y < 0) position.y = height;
    }
    
    
    protected void updateFeelers() {
        feelers = new PVector[FEELERS_NUM];
        float angle = -FEELERS_ANGLE / 2;
        float dAngle = FEELERS_ANGLE / (FEELERS_NUM - 1);
        for(int i = 0; i < FEELERS_NUM; i++) {
            feelers[i] = PVector.mult(velocity, FEELERS_LENGTH).rotate(angle);
            angle += dAngle;
        }
    }
    
    
    protected PVector[] getFeelers() {
        return feelers;
    }
    
    public abstract void decideSteering(Facade<Element> elements);

}


public class Prey extends Mover {
    
    private final PShape ASPECT;

    public Prey(int id, int x, int y, int radius, float maxSpeed, float maxForce) {
        super(id, x, y, radius, radius, maxSpeed, maxForce);
        ASPECT = createShape();
        ASPECT.beginShape();
            ASPECT.vertex(0, -R);
            ASPECT.vertex(-R/2, R);
            ASPECT.vertex(R/2, R);
        ASPECT.endShape(CLOSE);
        ASPECT.setFill(#00FF00);
        ASPECT.setStroke(false);
    }

    
    @Override
    public void draw() {
        float dir = velocity.heading() + HALF_PI;
        fill(#FF0000); noStroke();
        pushMatrix();
            translate(position.x, position.y);
            rotate(dir);
            shape(ASPECT);
        popMatrix();
    }
    
    
    @Override
    public void decideSteering(Facade<Element> elements) {
        steering = Steering.WANDER;
        objectives = elements.filter(Filters.closeInstance(Predator.class, Steering.FLEE_DISTANCE, position));
        if(objectives.count() > 0) steering = Steering.FLEE;
        else {
            objectives = elements.filter(Filters.closeInstance(Target.class, Steering.SEEK_DISTANCE, position));
            if(objectives.count() > 0) steering = Steering.ARRIVE;
        }
    }

}


public class Predator extends Mover {
    
    private final PShape ASPECT;

    public Predator(int id, int x, int y, int radius, float maxSpeed, float maxForce) {
        super(id, x, y, radius, radius, maxSpeed, maxForce);
        ASPECT = createShape();
        ASPECT.beginShape();
            ASPECT.vertex(0, -R);
            ASPECT.vertex(-R/2, R);
            ASPECT.vertex(R/2, R);
        ASPECT.endShape(CLOSE);
        ASPECT.setFill(#FF0000);
        ASPECT.setStroke(false);
    }


    public void decideSteering(Facade<Element> elements) {
        objectives = elements.filter(Filters.closeInstance(Prey.class, Steering.SEEK_DISTANCE, position));
        if(objectives.count() > 0) steering = Steering.SEEK;
        else steering = Steering.WANDER;
    }

    
    @Override
    public PVector interact(Element e) {
        if(e instanceof Prey && position.dist(e.getPosition()) <= R + e.R) e.suicide = true; // Kill prey
        return super.interact(e);
    }
    

    @Override
    public void draw() {
        float dir = velocity.heading() + HALF_PI;
        fill(#FF0000); noStroke();
        pushMatrix();
            translate(position.x, position.y);
            rotate(dir);
            shape(ASPECT);
        popMatrix();
    }

}
