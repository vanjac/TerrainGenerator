static color[] cubeColors;

static {
    cubeColors = new color[NUM_MATERIALS];
    cubeColors[MAT_WATER] = #0000FF;
    cubeColors[MAT_STONE] = #5F5F5F;
    cubeColors[MAT_WOOD] = #6F3700;
    cubeColors[MAT_LEAVES] = #007F00;
    cubeColors[MAT_GRASS] = #00BF00;
    cubeColors[MAT_DIRT] = #7F4F00;
    cubeColors[MAT_SNOW] = #FFFFFF;
    cubeColors[MAT_ICE] = #BFFFFF;
    cubeColors[MAT_DEAD_GRASS] = #BFBF3F;
    cubeColors[MAT_SAND] = #FFBF00;
    cubeColors[MAT_CLAY] = #8F8F8F;
    cubeColors[MAT_RED_FLOWER] = #FF0000;
    cubeColors[MAT_YELLOW_FLOWER] = #FFFF00;
    cubeColors[MAT_DEAD_LEAVES] = #BF7F00;
    cubeColors[MAT_CACTUS] = #007F00;
}

interface Render3d {
  void render(int[][][] render, int renderSize);
  void destroy();
}

class IsometricRender implements Render3d {
  float cubeSize;
  
  IsometricRender(float cubeSize) {
    this.cubeSize = cubeSize;
  }
  
  void destroy() {
    
  }
  
  public void render(int[][][] render, int renderSize) {
    background(255);
    for(int z = 0; z < renderSize; z++) {
      for(int y = 0; y < renderSize; y++) {
        for(int x = 0; x < renderSize; x++) {
          int currentBlock = render[x][y][z];
          if(currentBlock != 0) {
            
            if(isSmallBlock(currentBlock)) {
              drawSmallCube3d(x, y, z, cubeSize, cubeColors[currentBlock]);
            } else {
              drawCube3d(x, y, z, cubeSize, cubeColors[currentBlock]);
            }
          }
        }
      }
    }
  }
  
  void drawCube(int x, int y, float size, color c) {
    if(c == 0) {
      return;
    }
    
    stroke(0);
    fill(c);
    
    float b = size / 2 * sqrt(3);
    
    quad(x, y,
    -b + x, (size / -2) + y,
    x, y - size,
    b + x, (size / -2) + y);
    
    quad(x, y,
    -b + x, (size / -2) + y,
    -b + x, (size / 2) + y,
    x, y + size);
    
    quad(x, y,
    b + x, (size / -2) + y,
    b + x, (size / 2) + y,
    x, y + size);
  }
  
  void drawCube3d(int x, int y, int z, float size, color c) {
    float b = size / 2 * sqrt(3);
    
    drawCube((int)(width/2 + b*y - b*x),
    (int)(height/2 - z*size + size*x/2 + size*y/2),
    size, c);
  }
  
  void drawSmallCube3d(int x, int y, int z, float size, color c) {
    float b = size / 2 * sqrt(3);
    
    drawCube((int)(width/2 + b*y - b*x),
    (int)(height/2 - z*size + size*x/2 + size*y/2),
    size / 2, c);
  }
}



class PeasyRender implements Render3d {
  PeasyCam cam;
  float cubeSize;
  
  PeasyRender(processing.core.PApplet applet, int renderSize) {
    cubeSize = 12;
    cam = new PeasyCam(applet, 3 * renderSize * cubeSize);
    cam.setMinimumDistance(renderSize * cubeSize);
    cam.setMaximumDistance(12 * renderSize * cubeSize);
    cam.setActive(true);
    
    cam.rotateY(0.5);
    cam.rotateX(0.75);
  }
  
  void destroy() {
    cam.setActive(false);
  }
  
  public void render(int[][][] render, int renderSize) {
    background(160,160,160);
    noStroke();
    directionalLight(255,255,255,-.5,1,-.2);
    ambientLight(192,192,192);
    for(int z = 0; z < renderSize; z++) {
      for(int y = 0; y < renderSize; y++) {
        for(int x = 0; x < renderSize; x++) {
          int currentBlock = render[x][y][z];
          // check if the block exists and there is an open space on one side (it is visible)
          if( currentBlock != 0 &&
              ((!isFullBlock(getBlock(render, x-1, y, z))) ||
               (!isFullBlock(getBlock(render, x+1, y, z))) ||
               (!isFullBlock(getBlock(render, x, y-1, z))) ||
               (!isFullBlock(getBlock(render, x, y+1, z))) ||
               (!isFullBlock(getBlock(render, x, y, z-1))) ||
               (!isFullBlock(getBlock(render, x, y, z+1))) ) ) {
            
            if(isSmallBlock(currentBlock)) {
              drawSmallCube3d(x, y, z, cubeSize, cubeColors[currentBlock]);
            } else {
              drawCube3d(x, y, z, cubeSize, cubeColors[currentBlock]);
            }
          }
        }
      }
    }
    
    noLights();
  }
  
  void drawCube3d(int x, int y, int z, float size, color c) {
    fill(c);
    pushMatrix();
    translate(x * size, (0 - z) * size, y * size);
    box(size);
    popMatrix();
  }
  
  void drawSmallCube3d(int x, int y, int z, float size, color c) {
    fill(c);
    pushMatrix();
    translate(x * size, (0 - z) * size + (size/4), y * size);
    box(size / 2);
    popMatrix();
  }
}

class PointCloudRender implements Render3d {
  PeasyCam cam;
  float cubeSize;
  
  PointCloudRender(processing.core.PApplet applet, int renderSize) {
    cubeSize = 4;
    cam = new PeasyCam(applet, 3 * renderSize * cubeSize);
    cam.setMinimumDistance(renderSize * cubeSize);
    cam.setMaximumDistance(12 * renderSize * cubeSize);
    cam.setActive(true);
    
    cam.rotateY(0.5);
    cam.rotateX(0.75);
  }
  
  void destroy() {
    cam.setActive(false);
  }
  
  public void render(int[][][] render, int renderSize) {
    background(160,160,160);
    directionalLight(255,255,255,-.5,1,-.2);
    ambientLight(192,192,192);
    strokeWeight(4);
    for(int z = 0; z < renderSize; z++) {
      for(int y = 0; y < renderSize; y++) {
        for(int x = 0; x < renderSize; x++) {
          int currentBlock = render[x][y][z];
          if( currentBlock != 0 &&
              ((!isFullBlock(getBlock(render, x-1, y, z))) ||
               (!isFullBlock(getBlock(render, x+1, y, z))) ||
               (!isFullBlock(getBlock(render, x, y-1, z))) ||
               (!isFullBlock(getBlock(render, x, y+1, z))) ||
               (!isFullBlock(getBlock(render, x, y, z-1))) ||
               (!isFullBlock(getBlock(render, x, y, z+1))) ) ) {
            
            if(isSmallBlock(currentBlock)) {
              drawSmallCube3d(x, y, z, cubeSize, cubeColors[currentBlock]);
            } else {
              drawCube3d(x, y, z, cubeSize, cubeColors[currentBlock]);
            }
          }
        }
      }
    }
    
    noLights();
  }
  
  void drawCube3d(int x, int y, int z, float size, color c) {
    stroke(c);
    pushMatrix();
    translate(x * size, (0 - z) * size, y * size);
    point(0,0,0);
    popMatrix();
  }
  
  void drawSmallCube3d(int x, int y, int z, float size, color c) {
    stroke(c);
    pushMatrix();
    translate(x * size, (0 - z) * size + (size/4), y * size);
    point(0,0,0);
    popMatrix();
  }
}