void simulate() {
  for (int i = 0; i < particleCount; i++) {
    for (int j = i+1; j < particleCount; j++) {
      Particle p1 = particles[i];
      Particle p2 = particles[j];
      
      float p1radius = particleTypes[p1.type].forceRadii[p2.type];
      float p2radius = particleTypes[p2.type].forceRadii[p1.type];
      float p1force = particleTypes[p1.type].forces[p2.type];
      float p2force = particleTypes[p2.type].forces[p1.type];
      
      float dist = dist(p1.x, p1.y, p2.x, p2.y);
      
      if (dist < p1radius) {
        float a = p1force * (1 - (dist / p1radius)); // acceleration
        if (dist < 1) {
          a -= 0.1 * (1 - dist);
        }
        
        float distX = p2.x - p1.x;
        float distY = p2.y - p1.y;
        
        p1.ax += distX / dist * a;
        p1.ay += distY / dist * a;
      }
      
      if (dist < p2radius) {
        float a = p2force * (1 - (dist / p2radius)); // acceleration
        if (dist < 1) {
          a -= 0.1 * (1 - dist);
        }
        
        float distX = p1.x - p2.x;
        float distY = p1.y - p2.y;
        
        p2.ax += distX / dist * a;
        p2.ay += distY / dist * a;
      }
    }
  }
  
  for (int i = 0; i < particleCount; i++) {
    Particle p = particles[i];
    
    if (p.x < wallSize) {
      p.ax += wallCoef * (wallSize - p.x);
    } else if (p.x > scale-wallSize) {
      p.ax -= wallCoef * (p.x - (scale-wallSize));
    }
    if (p.y < wallSize) {
      p.ay += wallCoef * (wallSize - p.y);
    } else if (p.y > scale-wallSize) {
      p.ay -= wallCoef * (p.y - (scale-wallSize));
    }
    
    p.vx += p.ax;
    p.vy += p.ay;
    
    p.ax = 0;
    p.ay = 0;
  }
  
  for (int i = 0; i < particleCount; i++) {
    Particle p = particles[i];
    
    p.x += p.vx;
    p.y += p.vy;
    
    p.vx *= 1-drag;
    p.vy *= 1-drag;
    
    if (p.x < 0 || p.x > scale || p.y < 0 || p.y > scale) {
      p.x = scale / 2;
      p.y = scale / 2;
      p.vx = (float)(Math.random()) - 0.5;
      p.vy = (float)(Math.random()) - 0.5;
    }
  }
}
