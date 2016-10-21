interface Randomizer {
  void randomize(TerrainInfo tInfo);
}

class ClassicRandomizer implements Randomizer {
  final int dirtHeight = 7;
  
  int size;
  Climate climate;
  TerrainInfo tInfo;
  HeightMapGenerator hmGenerate;
  
  int[] erosionTable;
  void makeErosionTable() {
    erosionTable = new int[9];
    erosionTable[0] = MAT_STONE;
    erosionTable[1] = MAT_GRASS;
    erosionTable[2] = MAT_DIRT;
    erosionTable[3] = MAT_SAND;
    erosionTable[4] = MAT_SAND;
    erosionTable[5] = MAT_SAND;
    erosionTable[6] = MAT_DIRT;
    erosionTable[7] = MAT_CLAY;
    erosionTable[8] = MAT_CLAY;
  }
  
  ClassicRandomizer(HeightMapGenerator hmGenerate) {
    this.hmGenerate = hmGenerate;
    makeErosionTable();
  }
  
  void randomize(TerrainInfo tInfo) {
    this.tInfo = tInfo;
    size = tInfo.getSize();
    
    randomClimate();
    randomWaterLevel();
    randomHeightMap();
    randomDirt();
    randomPlants();
    randomErosion();
  }
  
  void randomClimate() {
    climate = new Climate();
    randomTemperature();
    randomHumidity();
    tInfo.setClimate(climate);
  }
  
  void randomTemperature() {
    climate.setTemperature(random(0, 32) + random(0, 32) - 16);
  }
  
  void randomHumidity() {
//    climate.setHumidity(random(0, 8) + random(0, 8));
    climate.setHumidity(random(0, 16));
  }
  
  void randomWaterLevel() {
    tInfo.setWaterLevel(round(random(size/2)));
  }
  
  void randomHeightMap() {
    float hills = random(0.5);
    println("Hills: " + hills);
    tInfo.setHeightMap(hmGenerate.generate(size, size, hills));
  }
  
  void randomDirt() {
    boolean[][][] dirt = new boolean[size][size][dirtHeight];
    
    for(int z = 0; z < dirtHeight; z++) {
      for(int y = 0; y < size; y++) {
        for(int x = 0; x < size; x++) {
          if(round(random(6)) == 0) {
            dirt[x][y][z] = false;
          } else {
            dirt[x][y][z] = true;
          }
        }
      }
    }
    
    tInfo.setAllDirt(dirt);
  }
  
  void randomPlants() {
    Plant[][] plants = new Plant[size][size];
    
    float grassProb = tInfo.grassProb();
    float bushProb = tInfo.bushProb();
    float treeProb = tInfo.treeProb();
    float flowerProb = tInfo.flowerProb();
    float cactusProb = tInfo.cactusProb();
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        if(random(1) <= treeProb) {
          plants[x][y] = new Tree(climate);
        } else
        if(random(1) <= cactusProb) {
          plants[x][y] = new Cactus();
        } else
        if(random(1) <= bushProb) {
          plants[x][y] = new Bush();
        } else
        if(random(1) <= flowerProb) {
          plants[x][y] = new Flower();
        } else
        if(random(1) <= grassProb) {
          plants[x][y] = new Grass();
        } else
        
        {}
      }
    }
    
    tInfo.setAllPlants(plants);
  }
  
  void randomErosion() {
    int[][] erosion = new int[size][size];
    
    int[][] heightMap = hmGenerate.generate(size, 8, random(0.5));
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        int erosionTableLevel = round(heightMap[x][y]) + 4;
        if(erosionTableLevel > 7) { // TODO: Magic number; change to 8?
          erosionTableLevel = 7;
        } else if (erosionTableLevel < 0) {
          erosionTableLevel = 0;
        }
        
        erosion[x][y] = erosionTable[erosionTableLevel];
      }
    }
    
    tInfo.setAllErosion(erosion);
  }
}