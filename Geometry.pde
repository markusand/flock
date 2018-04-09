public static class Geometry {

    public static PVector[] intersectionLineCircle(PVector lineOrigin, PVector lineEnd, PVector center, float radius) {
        PVector line = PVector.sub(lineEnd, lineOrigin);
        PVector f = PVector.sub(lineOrigin, center);
        float a = line.dot(line);
        float b = 2 * f.dot(line);
        float c = f.dot(f) - radius * radius;
        float disc = b * b - 4 * a * c;
        if(disc < 0) return new PVector[0];
        else {
            disc = sqrt(disc);
            float t1 = (-b - disc)/(2*a);
            float t2 = (-b + disc)/(2*a);
            PVector int1 = PVector.add(lineOrigin, PVector.mult(line, t1));
            PVector int2 = PVector.add(lineOrigin, PVector.mult(line, t2));
            boolean t1_0_1 = t1 >= 0 && t1 <= 1;
            boolean t2_0_1 = t2 >= 0 && t2 <= 1;
            if(t1_0_1) {
                if(t2_0_1) return new PVector[] {int1, int2};
                return new PVector[] {int1};
            } else if(t2_0_1) return new PVector[] {int2};
            return new PVector[0];
        }
    }
    
    public static PVector linesIntersection(PVector line1Origin, PVector line1End, PVector line2Origin, PVector line2End) {
        float uA = ((line2End.x-line2Origin.x)*(line1Origin.y-line2Origin.y) - (line2End.y-line2Origin.y)*(line1Origin.x-line2Origin.x)) / ((line2End.y-line2Origin.y)*(line1End.x-line1Origin.x) - (line2End.x-line2Origin.x)*(line1End.y-line1Origin.y));
        float uB = ((line1End.x-line1Origin.x)*(line1Origin.y-line2Origin.y) - (line1End.y-line1Origin.y)*(line1Origin.x-line2Origin.x)) / ((line2End.y-line2Origin.y)*(line1End.x-line1Origin.x) - (line2End.x-line2Origin.x)*(line1End.y-line1Origin.y));
        if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
            return new PVector(line1Origin.x + (uA * (line1End.x-line1Origin.x)), line1Origin.y + (uA * (line1End.y-line1Origin.y)));
        }
        return null;
    }

}
