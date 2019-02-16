class Firework {
  ArrayList<Particle> points;
  ArrayList<Particle> toDelete = new ArrayList<Particle>();
  int csize = 7;
  color[] colors;
  float x, y;
  int step = 0;
  int steps;
  Firework(float xx, float yy) {
    //println("constructor");
    colors = new color[] {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
      color(255, 255, 255), color(255, 255, 0), color(255, 0, 255), 
      color(0, 255, 255)};  
    x = xx;
    y = yy;
    points = new ArrayList<Particle>();
    int maxLevels = 20;
    int levels = int(random(maxLevels/2.0, maxLevels));
    float maxr = random(50, 100.0);
    float rstep = maxr/levels;
    float r = rstep;
    steps = int(random(50, 75));
    color c1 = getC1();
    color c2 = getC2(c1);
    for (int i = 0; i < levels; ++i) {
      int pointsPerLevel = int(random(20, 30));
      float angle = random(0, 2*PI);
      float step = 2*PI/pointsPerLevel;
      for (int j = 0; j < pointsPerLevel; ++j) {
        float endX = r*cos(angle)+x;
        float endY = r*sin(angle)+y;
        points.add(new Particle(x, y, endX, endY, float(steps), c1, c2));
        angle += step;
      }
      r += rstep;
    }
  }
  boolean run() {
    PShape s = createShape(GROUP);
    for (Particle p : points) {
      boolean delete = p.run(s);
      if (delete) {
        toDelete.add(p);
      }
      //p.display(s);
      //++step;
    }
    shape(s, 0, 0);
    deletePoints();
    return false;
    //return step >= 1.5*steps;
  }
  void deletePoints() {
    for (Particle p : toDelete) {
      points.remove(p);
    }
    toDelete.clear();
  }
  color getC1() {
    return colors[int(random(0, csize))];
  }
  color getC2(color c1) {
    int index = int(random(0, csize));
    while (colors[index] == c1) {
      index = int(random(0, csize));
    }
    return colors[index];
  }
}
