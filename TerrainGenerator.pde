import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import g4p_controls.*;

// ..::Features to add::..
// Elevation stored in climate, affecting temperature and plant growth
// Randomizer randomizing climate
// GrowingConditions takes climate as argument
// Different climate zones
// Tall Grass, dead grass
// More tree types - Evergreen
// Fractional seasons
// Humidity affected by temerature
// Block textures
// Oceans without ice
// Variable snowfall
// Volcanoes
// Make all-dirt terrains less likely
// Variable dirt depths
// More realistic deserts?
// Water simulation, including...
//   Erosion and exposed rock
//   Rivers and waterfalls
//   Lakes above ocean level
//   Water springs
//   Snowmelt
//   Rain simulation


// ..::Bugs::..
// Grass below rendered area doesn't have snow
// Floating trees can occur, and trees can form below ground level

TerrainInfo tInfo;
int[][][] model;
int size = 24;
int cubeSize = 12;

Render3d renderer3d;


void setup() {
  model = new int[0][0][0];
  //if(displayHeight >= 832) {
    size(768, 768, P3D);
    cubeSize = 12;
  //} else {
    //size(512, 512, P3D);
    //cubeSize = 8;
  //}
  
  makeGui();
  //handleButtonEvents(btnGenerate, GEvent.CLICKED);
}

void generateWithSeed(long seed) {
  randomSeed(seed);
  println("Seed: " + seed);
  generateTerrain();
}

int generateRandom() {
  int seed = (int)random(-2147483648, 2147483647);
  generateWithSeed(seed);
  return seed;
}

void generateTerrain() {
  println("\n");
  
  size = getTerrainSize();
  
  tInfo = new TerrainInfo(size);
  Randomizer randomizer = new ClassicRandomizer(new MidpointDisplacement());
  randomizer.randomize(tInfo);
  tInfo.printInfo();
  
  SeasonInfo sInfo = new SeasonInfo(tInfo, round(random(1, 4)));
  sInfo.printInfo();
  
  createRenderTerrain(sInfo);
  //drawLogo();
}

void createRenderTerrain(SeasonInfo sInfo) {
  TerrainCreator creator = new ClassicTerrainCreator();
  model = creator.createTerrain(tInfo, sInfo);
  
  render3d();
}

void render3d() {
  //Render3d renderer3d = new IsometricRender();
  renderer3d = new PeasyRender(this, cubeSize, size);
  renderDraw();
}

void renderDraw() {
  //hint(DISABLE_DEPTH_TEST);
  //hint(ENABLE_DEPTH_TEST);
  //PJOGL pgl;
  //GL gl;
  //pgl = (PJOGL) beginPGL();
  //gl = pgl.gl.getGL();
  //gl.glClear(GL.GL_DEPTH_BUFFER_BIT);
  //gl.glEnable(GL.GL_DEPTH_TEST);
  //endPGL();
  renderer3d.render(model, cubeSize, size);
}

void switchSeason(int season) {
  SeasonInfo sInfo = new SeasonInfo(tInfo, season);
  sInfo.printInfo();
  createRenderTerrain(sInfo);
}

void rotateRight() {
  int modelLength = model.length;
  
  int[][][] newModel = new int[modelLength][modelLength][modelLength];
  
  for(int z = 0; z < modelLength; z++) {
    for(int y = 0; y < modelLength; y++) {
      for(int x = 0; x < modelLength; x++) {
        newModel[y][(modelLength - 1) - x][z] = model[x][y][z];
      }
    }
  }
  model = newModel;
  
  render3d();
}

void rotateLeft() {
  int modelLength = model.length;
  
  int[][][] newModel = new int[modelLength][modelLength][modelLength];
  
  for(int z = 0; z < modelLength; z++) {
    for(int y = 0; y < modelLength; y++) {
      for(int x = 0; x < modelLength; x++) {
        newModel[(modelLength - 1) - y][x][z] = model[x][y][z];
      }
    }
  }
  model = newModel;
  
  render3d();
}

void drawLogo() {
  model = new int[size][size][size];
  new Tree(new Climate()).drawPlant(model, size / 2, size / 2, 0, new SeasonInfo(new TerrainInfo(size), 2));
  
  render3d();
}

void drawBlockTest() {
  model = new int[size][size][size];
  for(int z = 0; z < 18; z++) {
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        model[x][y][z] = z;
      }
    }
  }
  
  render3d();
}

void draw() {
  if(renderer3d == null) {
    background(224);
    return;
  }
  renderDraw();
}