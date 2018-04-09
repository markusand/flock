public enum Steering {

    WANDER() {
        @Override
        public PVector interact(Mover mover) {
            PVector random = PVector.random2D().setMag(WANDER_RADIUS);
            PVector force = mover.getVelocity().setMag(WANDER_DISTANCE).add(random);
            force.limit(mover.MAX_FORCE);
            return new PVector();
        }
    };
    
    /* STEERING PARAMETERS */
    final static int WANDER_RADIUS = 3;
    final static int WANDER_DISTANCE = 20;
    
    public abstract PVector interact(Mover self);

}
