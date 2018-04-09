Facade<Element> elements = new Facade();


void setup() {
    size(700, 700, P2D);
}

void draw() {
    background(255);
    for(Element m : elements) {
        m.update(elements);
        m.draw();
    }
}


void mousePressed() {
    elements.add(new Vehicle(elements.count(), mouseX, mouseY, 6, 2, 1));
}
