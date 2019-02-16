class Particle {
  float x, y, z;
  float startx, starty;
  float maxDist;
  float velx, vely, velo;
  float O = 255.0;
  float minO = 10.0;
  boolean hitMax = false;
  color c1, c2;
  Particle(float xx, float yy, float ex, float ey, float steps, color cc1, color cc2) {
    x = xx;
    y = yy;
    startx = x;
    starty = y;
    c1 = cc1;
    c2 = cc2;
    maxDist = (ex-x)*(ex-x) + (ey-y)*(ey-y);
    velx = (ex-x)/(steps);
    vely = (ey - y)/(steps);
    velo = (255.0 - minO)/(steps);
  }
  float getDist() {
    return (startx-x)*(startx-x) + (starty-y)*(starty-y);
  }
  void move() {
    x += velx;
    y += vely;
    if (getDist() >= maxDist) {
      hitMax = true;
    }
  }
  color updateColor() {
    float maxmaxDist = 1.5*maxDist;
    color c =  lerpColor(c1, c2, getDist()/maxmaxDist);
    return color(getRed(c), getGreen(c), getBlue(c), O);
  }
  int getRed(color c) {
    return (c & (255 << 16))>>16;
  }
  int getGreen(color c) {
    return (c & (255 << 8))>>8;
  }
  int getBlue(color c) {
    return c & 255;
  }
  boolean display(PShape s) {
    //fill(color(255, 255, 255, O));
    //stroke(color(0, 0, 0, O));
    if (hitMax) { 
      O -= velo;
    }
    if (O > minO) {
      //ellipse(x, y, 5, 5);
      PShape e = createShape(ELLIPSE, x, y, 5, 5);
      e.setFill(updateColor());
      //stroke(color(0, 0, 0, O));
      e.setStroke(false);
      s.addChild(e);
    }
    return O <= minO;
  }
  boolean run(PShape s) {
    move();
    return display(s);
  }
}
