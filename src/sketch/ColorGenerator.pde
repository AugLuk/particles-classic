class ColorGenerator {
  ArrayList<float[]> cols;
  float hc, sc, bc; // hue, saturation and brightness coefficients for determening how different colors are
  
  ColorGenerator(float hc, float sc, float bc) {
    cols = new ArrayList<float[]>();
    this.hc = hc;
    this.sc = sc;
    this.bc = bc;
  }
  
  ColorGenerator() {
    cols = new ArrayList<float[]>();
    hc = 1;
    sc = 1;
    bc = 1;
  }

  color generate() {
    if (cols.size() == 0) { // if this is this generator's first color, simply returns a random color
      float h = random(0, 1);
      float s = random(0, 1);
      float b = random(0, 1);
      cols.add(new float[]{h, s, b});
      return color(h, s, 0.5 + 0.5 * b);
    } else { // else, generates @n number of random colors and selects the one that is the most different from the previous colors returned by this generator
      int n = 2 * cols.size();
      float[][] colCandids = new float[n][];
      float[] dists = new float[n];

      for (int i = 0; i < n; i++) {
        // generates a candid color
        float h = random(0, 1);
        float s = random(0, 1);
        float b = random(0, 1);
        float[] thisCol = new float[]{h, s, b};
        colCandids[i] = thisCol;

        float[] dists2 = new float[cols.size()];
        for (int j = 0; j < cols.size(); j++) { // finds how different it is
          float hd_ = abs(cols.get(j)[0] - thisCol[0]);
          float hd = hd_ < 0.5 ? hd_ : 1 - hd_;
          hd *= hc;
          float sd = sc * abs(cols.get(j)[1] - thisCol[1]);
          float bd = bc * abs(cols.get(j)[2] - thisCol[2]);
          
          dists2[j] = sqrt(hd*hd + sd*sd + bd*bd);
        }
        dists[i] = dists2[findMin(dists2)];
      }
      
      // finds best color candid out of the bunch
      int idx = findMax(dists);
      
      // returns the result
      float h = colCandids[idx][0];
      float s = colCandids[idx][1];
      float b = colCandids[idx][2];
      cols.add(new float[]{h, s, b});
      return color(h, s, 0.5 + 0.5 * b);
    }
  }
}
