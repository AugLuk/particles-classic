void draw() {
  background(0);
  
  for (int i = 0; i < particleCount; i++) {
    Particle p = particles[i];
    float x = p.x / scale * width;
    float y = p.y / scale * width;
    float diameter = width / scale;
    fill(particleTypes[p.type].col);
    noStroke();
    ellipse(x, y, diameter, diameter);
  }
  
  for (int i = 0; i < iterationsPerFrame; i++) {
    simulate();
  }
}
