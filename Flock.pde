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
    switch(key) {
        case 'v':
            elements.add(new Vehicle(elements.count(), mouseX, mouseY, 6, 2, 1));
            break;
        case 't':
            elements.add(new Target(elements.count(), mouseX, mouseY));
            break;
    }
}
