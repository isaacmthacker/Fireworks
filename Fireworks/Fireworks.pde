ArrayList<Firework> fireworks;

ArrayList<Particle> points;

float px;
float py;

int last = 0;

void setup() {
  size(1000, 750);
  fireworks = new ArrayList<Firework>();
  fireworks.add(new Firework(width/2.0, height/2.0));
  px = width/2.0;
  py = height/2.0;
}

void draw() {
  drawBackground();
  ArrayList<Firework> toDelete = new ArrayList<Firework>();
  for (Firework f : fireworks) {
    if (f.run()) {
      toDelete.add(f);
    }
  }
  if (toDelete.size() > 0) {
    for (Firework f : toDelete) {
      fireworks.remove(f);
    }
  }
}


void mousePressed() {
  println(mouseX, mouseY);
  fireworks.add(new Firework(mouseX, mouseY));
}
void keyPressed() {
  if (last != 0 && last >= 12) {
    if (keyCode == 32) {
      fireworks.add(new Firework(random(0, width), random(0, height)));
      last = 1;
    }
  } 
  ++last;
}

void drawBackground() {
  background(color(0, 0, 100));
}
