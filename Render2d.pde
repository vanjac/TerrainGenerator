interface Render2d {
  void render(int[][] render, int size, int depth);
}

class BWRender implements Render2d {
  public void render(int[][] render, int size, int depth) {
    background(255);
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        float c = (render[x][y] + depth / 2) * 256 / depth;
        if (c < 0) {c = 0;}
        stroke(c);
        point(x, y);
      }
    }
  }
}