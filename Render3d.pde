color[] cubeColors;

void initCubeColors() {
    cubeColors = new color[32];
    cubeColors[1] = color(0, 0, 255);     //Water
    cubeColors[2] = color(95, 95, 95);    //Stone
    cubeColors[3] = color(111, 55, 0);    //Wood
    cubeColors[4] = color(0, 127, 0);     //Leaves
    cubeColors[5] = color(0, 191, 0);     //Grass
    cubeColors[6] = color(127, 79, 0);    //Dirt
    cubeColors[7] = color(255, 255, 255); //Snow
    cubeColors[8] = color(191, 255, 255); //Ice
    cubeColors[9] = color(191, 191, 63); //Dead Grass
//    cubeColors[10] = color(255, 0, 0);    //Lava (unused)
    cubeColors[11] = color(255, 191, 0);  //Sand
    cubeColors[12] = color(143, 143, 143);//Clay
//    cubeColors[13] = color(255, 127, 0);  //Fire (unused)
    cubeColors[14] = color(255, 0, 0);    //Red flower (not working, unused)
    cubeColors[15] = color(255, 255, 0);  //Yellow flower (not working, unused)
    cubeColors[16] = color(191, 127, 0);  //Dead leaves
    cubeColors[17] = color(0, 127, 0);    //Cactus (same as leaves, unused)
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