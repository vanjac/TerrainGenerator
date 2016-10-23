interface TerrainCreator {
  int[][][] createTerrain(TerrainInfo tInfo, SeasonInfo sInfo);
}

class ClassicTerrainCreator implements TerrainCreator{
  int[][][] terrain;
  int size;
  boolean desert;
  boolean glacier;
  int season;
  boolean snow;
  TerrainInfo tInfo;
  SeasonInfo sInfo;
  int[] erosionDepth;
  int[][] heightMap;
  int waterLevel;
  
  ClassicTerrainCreator() {
    createErosionDepth();
  }
  
  int[][][] createTerrain(TerrainInfo tInfo, SeasonInfo sInfo) {
    heightMap = tInfo.getHeightMap();
    size = tInfo.getSize();
    terrain = new int[size][size][size];
    desert = tInfo.hotDesertClimate();
    glacier = tInfo.getClimate().coldDesertClimate();
    season = sInfo.getSeason();
    snow = sInfo.getWeather().snow();
    waterLevel = tInfo.getWaterLevel();
    this.tInfo = tInfo;
    this.sInfo = sInfo;
    
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        int z = heightMap[x][y] + (size / 2);
        addDirt(x, y, z);
        
        if(z > waterLevel + 1) {
          addPlant(x, y, z);
        }
        
        addWater(x, y);
        if(z <= waterLevel && !glacier){
          addErosion(x, y, z);
        }
        
        if(snow) {
          addSnow(x, y); //Bug: Snow won't draw under z = 0;
        }
      }
    }
    
    return terrain;
  }
  
  void setBlock(int x, int y, int z, int value) {
    if(x >= size || x < 0 || y >= size || y < 0 || z >= size || z < 0) {
      return;
    }
    
    terrain[x][y][z] = value;
  }
  
  int getBlock(int x, int y, int z) {
    if(x >= size || x < 0 || y >= size || y < 0 || z >= size || z < 0) {
      return 0;
    }
    
    return terrain[x][y][z];
  }
  
  void addDirt(int x, int y, int level) {
    int middleBlock;
    int bottomBlock = MAT_STONE;
    if(glacier) {
      middleBlock = MAT_ICE;
    } else if (desert) {
      middleBlock = MAT_SAND;
    } else {
      middleBlock = MAT_DIRT;
    }
    
    for(int currentLevel = level ; currentLevel >= 0; currentLevel--) {
      int difference = level - currentLevel;
      
      if(difference == 0) {
        //Used to place grass/sand
      } else if(difference == 1) {
        setBlock(x, y, currentLevel, middleBlock);
      } else if(difference < 9) {
        boolean dirt = tInfo.getDirt(x, y)[difference - 2];
        if(dirt) {
          setBlock(x, y, currentLevel, middleBlock);
        } else {
          setBlock(x, y, currentLevel, bottomBlock);
        }
      } else {
        setBlock(x, y, currentLevel, bottomBlock);
      }
    }
  }
  
  void addPlant(int x, int y, int z) {
    Plant currentPlant = tInfo.getPlant(x, y);
    if(currentPlant == null) {
      return;
    }
    
    currentPlant.drawPlant(terrain, x, y, z, sInfo);
  }
  
  void createErosionDepth() {
    erosionDepth = new int[13];
    erosionDepth[MAT_STONE] = 3;
    erosionDepth[MAT_GRASS] = 1;
    erosionDepth[MAT_DIRT] = 4;
    erosionDepth[MAT_SAND] = 4;
    erosionDepth[MAT_CLAY] = 3;
  }
  
  void addWater(int x, int y) {
    for(int z = 0; z < waterLevel; z++) {
      int currentBlock = terrain[x][y][z];
      if(currentBlock == MAT_EMPTY) {
        terrain[x][y][z] = MAT_WATER;
      }
    }
    
    if(snow && waterLevel != 0) {
      int z = waterLevel - 1;
      if(terrain[x][y][z] == MAT_WATER) {
        terrain[x][y][z] = MAT_ICE;
      }
    }
  }
  
  void addErosion(int x, int y, int z) {
    int currentErosion = tInfo.getErosion(x, y);
    int currentErosionDepth = erosionDepth[currentErosion];
    for(int currentZ = z; currentZ > 0 && z - currentZ < currentErosionDepth; currentZ--) {
      terrain[x][y][currentZ] = currentErosion;
    }
  }
  
  void addSnow(int x, int y) {
    for(int level = size - 1; level >= 0; level--) {
      int currentBlock = terrain[x][y][level];
      if(currentBlock != MAT_EMPTY) {
        if(currentBlock != MAT_WATER && level < size - 1) {
          terrain[x][y][level + 1] = MAT_SNOW;
        }
        break;
      }
    }
  }
}