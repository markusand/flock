Facade<Element> elements = new Facade();


void setup() {
    size(700, 700, P2D);
    elements.add( new Wall(0, new PVector(30,10), new PVector(width-30, 10), new PVector(width-10, 30), new PVector(width-10, height-30), new PVector(width-30, height-10), new PVector(30, height-10), new PVector(10, height-30), new PVector(10, 30), new PVector(30, 10)));
}

void draw() {
    background(0);
    for(Iterator i = elements.iterator(); i.hasNext();) {
        Element e = (Element) i.next();
        e.update(elements);
        e.draw();
        if(e.suicide) i.remove();
    }
}


void mousePressed() {
    switch(key) {
        case 'v':
            elements.add(new Prey(elements.count(), mouseX, mouseY, 6, 2, 1));
            break;
        case 'p':
            elements.add(new Predator(elements.count(), mouseX, mouseY, 9, 3, 1));
            break;
        case 't':
            elements.add(new Target(elements.count(), mouseX, mouseY));
            break;
        case 'o':
            elements.add(new Obstacle(elements.count(), mouseX, mouseY, 30));
            break;
        case 'a':
            elements.add(new Attractor(elements.count(), mouseX, mouseY, (int)random(10, 50)));
            break;
    }
}
