Particle[] particles;
ParticleType[] particleTypes;

int particleCount = 500;
float scale = 150;
float drag = 0.04;
int typeCount = 3;
float maxForce = 0.002;
float minDist = 2;
float maxDist = 15;
int iterationsPerFrame = 3;
float wallSize = 10;
float wallStrength = 0.005;
float decompForce = 0.1; // decompression force. if 2 particles are closer that 1 unit apart, this force activates

float wallCoef;

void setup() {
  size(1000, 1000); // square
  colorMode(HSB, 1);
  
  wallCoef = wallStrength / wallSize;
  
  particleTypes = new ParticleType[typeCount];
  ColorGenerator cg = new ColorGenerator(1, 1, 0.5);
  for (int i = 0; i < typeCount; i++) {
    ParticleType pt = new ParticleType();
    
    pt.col = cg.generate();
    
    println("Particle #" + i);
    
    println("  Forces:");
    pt.forces = new float[typeCount];
    for (int j = 0; j < typeCount; j++) {
      pt.forces[j] = random(-maxForce, maxForce);
      println("    " + pt.forces[j]);
    }
    
    println("  Radii:");
    pt.forceRadii = new float[typeCount];
    for (int j = 0; j < typeCount; j++) {
      pt.forceRadii[j] = random(minDist, maxDist);
      println("    " + pt.forceRadii[j]);
    }
    
    particleTypes[i] = pt;
  }
  
  particles = new Particle[particleCount];
  for (int i = 0; i < particleCount; i++) {
    Particle p = new Particle();
    
    float r = (scale/4) * sqrt(random(0, 1));
    float phi = random(0, TWO_PI);
    p.x = scale/2 + r * cos(phi);
    p.y = scale/2 + r * sin(phi);
    p.vx = 0;
    p.vy = 0;
    p.ax = 0;
    p.ay = 0;
    
    p.type = floor(random(0, typeCount));
    
    particles[i] = p;
  }
}
