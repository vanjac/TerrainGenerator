color[] cubeColors;

void initCubeColors() {
    cubeColors = new color[NUM_MATERIALS];
    cubeColors[MAT_WATER] = color(0, 0, 255);
    cubeColors[MAT_STONE] = color(95, 95, 95);
    cubeColors[MAT_WOOD] = color(111, 55, 0);
    cubeColors[MAT_LEAVES] = color(0, 127, 0);
    cubeColors[MAT_GRASS] = color(0, 191, 0);
    cubeColors[MAT_DIRT] = color(127, 79, 0);
    cubeColors[MAT_SNOW] = color(255, 255, 255);
    cubeColors[MAT_ICE] = color(191, 255, 255);
    cubeColors[MAT_DEAD_GRASS] = color(191, 191, 63);
    cubeColors[MAT_SAND] = color(255, 191, 0);
    cubeColors[MAT_CLAY] = color(143, 143, 143);
    cubeColors[MAT_RED_FLOWER] = color(255, 0, 0);
    cubeColors[MAT_YELLOW_FLOWER] = color(255, 255, 0);
    cubeColors[MAT_DEAD_LEAVES] = color(191, 127, 0);
    cubeColors[MAT_CACTUS] = color(0, 127, 0);
}

interface Render3d {
  void render(int[][][] render, float cubeSize, int renderSize);
}

class IsometricRender implements Render3d {
  IsometricRender() {
    initCubeColors();
  }
  
  public void render(int[][][] render, float cubeSize, int renderSize) {
    background(255);
    for(int z = 0; z < renderSize; z++) {
      for(int y = 0; y < renderSize; y++) {
        for(int x = 0; x < renderSize; x++) {
          int currentBlock = render[x][y][z];
          if(currentBlock != 0) {
            
            if(currentBlock == 14 || currentBlock == 15) {
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
  
  PeasyRender(processing.core.PApplet applet, float cubeSize, int renderSize) {
    cam = new PeasyCam(applet, 3 * renderSize * cubeSize);
    cam.setMinimumDistance(renderSize * cubeSize);
    cam.setMaximumDistance(12 * renderSize * cubeSize);
    cam.setActive(true);
    
    cam.rotateY(0.5);
    cam.rotateX(0.75);
    
    initCubeColors();
  }
  
  public void render(int[][][] render, float cubeSize, int renderSize) {
    background(160,160,160);
    noStroke();
    directionalLight(255,255,255,-.5,1,-.2);
    ambientLight(192,192,192);
    for(int z = 0; z < renderSize; z++) {
      for(int y = 0; y < renderSize; y++) {
        for(int x = 0; x < renderSize; x++) {
          int currentBlock = render[x][y][z];
          if(currentBlock != 0) {
            
            if(currentBlock == 14 || currentBlock == 15) {
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