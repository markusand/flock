public class Mover extends Element {
    
    protected final float MAX_SPEED;
    protected final float MAX_FORCE;
    
    protected PVector velocity = new PVector();
    protected PVector acceleration = new PVector();
    
    protected PVector[] feelers;
    
    public Mover(int id, int x, int y, int mass, int R, float maxSpeed, float maxForce) {
        super(id, x, y, mass, R);
        MAX_SPEED = maxSpeed;
        MAX_FORCE = maxForce;
    }
    
    
    public void update() {
        PVector force = new PVector(0,1);
        applyForce(force);
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
    
    public void draw() {
        fill(0);
        ellipse(position.x, position.y, 2*R, 2*R);
    }

}
