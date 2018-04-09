public enum Steering {

    WANDER() {
        @Override
        public PVector interact(Mover mover, Facade<Element> elements) {
            PVector random = PVector.random2D().setMag(WANDER_RADIUS);
            PVector force = mover.getVelocity().setMag(WANDER_DISTANCE).add(random);
            force.limit(mover.MAX_FORCE);
            return new PVector();
        }
    },
    
    SEEK() {
        @Override
        public PVector interact(Mover mover, Facade<Element> targets) {
            Element target = null;
            float minD = SEEK_DISTANCE;
            for(Element t : targets) {
                float d = mover.getPosition().dist(t.getPosition()); 
                if(d < minD) {
                    target = t;
                    minD = d;
                }
            }
            if(target != null) {
                PVector desired = PVector.sub(target.getPosition(), mover.getPosition());
                desired.setMag(mover.MAX_SPEED);
                return PVector.sub(desired, mover.getVelocity());
            } else return new PVector();
        }
    };
    
    /* STEERING PARAMETERS */
    final static int WANDER_RADIUS = 3;
    final static int WANDER_DISTANCE = 20;
    final static int SEEK_DISTANCE = 200;
    
    public abstract PVector interact(Mover self, Facade<Element> objectives);

}
