ArrayList<Mover> movers = new ArrayList();


void setup() {
    size(700, 700, P2D);
}

void draw() {
    background(255);
    for(Mover m : movers) {
        m.update();
        m.draw();
    }
}


void mousePressed() {
    movers.add(new Mover(movers.size(), mouseX, mouseY, 3, (int)random(4, 10), 2, 0.1));
}