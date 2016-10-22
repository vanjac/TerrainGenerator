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
int[][][] model = null;
int size = 24;
int cubeSize = 12;

Render3d renderer3d;


void setup() {
  makeGui();
}

void settings() {
  if(displayHeight >= 832) {
    size(768, 768, P3D);
    cubeSize = 12;
  } else {
    size(512, 512, P3D);
    cubeSize = 8;
  }
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
  
  setupRenderer();
}

void createRenderTerrain(SeasonInfo sInfo) {
  TerrainCreator creator = new ClassicTerrainCreator();
  model = creator.createTerrain(tInfo, sInfo);
  guiSetSeason(sInfo.getSeason());
}

void setupRenderer() {
  renderer3d = new PeasyRender(this, cubeSize, size);
}

void renderDraw() {
  if(renderer3d == null)
    setupRenderer();
  
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
  if(tInfo != null) {
    SeasonInfo sInfo = new SeasonInfo(tInfo, season);
    sInfo.printInfo();
    createRenderTerrain(sInfo);
  }
}

void drawBlockTest() {
  model = new int[size][size][size];
  for(int z = 0; z < NUM_MATERIALS; z++) {
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        model[x][y][z] = z;
      }
    }
  }
}

void draw() {
  if(model == null) {
    background(224);
    return;
  }
  renderDraw();
}