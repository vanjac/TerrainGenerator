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
    int bottomBlock = 2; //Stone
    if(glacier) {
      middleBlock = 8; //Ice
    } else if (desert) {
      middleBlock = 11; //Sand
    } else {
      middleBlock = 6; //Dirt
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
    
    //if(snow) {
    //  terrain[x][y][level + 1] = 7; //Snow
    //}
  }
  
  void addPlant(int x, int y, int z) {
    Plant currentPlant = tInfo.getPlant(x, y);
    if(currentPlant == null) {
      return;
    }
    
    currentPlant.drawPlant(terrain, x, y, z, sInfo);
    
//    int[][][] plantModel = currentPlant.drawPlant(season);
//    int plantXLength = plantModel.length;
//    int plantYLength = plantModel[0].length;
//    int plantZLength = plantModel[0][0].length;
//    
//    if(plantXLength > 1 || plantYLength > 1) { //Reposition the plant so it is on the ground
//      ArrayList<Coordinate3d> lowestPoints = lowestPoints(plantModel);
//      int highestX = lowestPoints.get(0).x;
//      int highestY = lowestPoints.get(0).y;
//      int highestZ = lowestPoints.get(0).z;
//      for(int i = 0; i < lowestPoints.size(); i++) {
//        Coordinate3d point = lowestPoints.get(i);
//        
//        if(false) {
//          
//       }
//      }
//    }
//    
//    for(int plantZ = 0; plantZ < plantZLength; plantZ++) {
//      for(int plantY = 0; plantY < plantYLength; plantY++) {
//        for(int plantX = 0; plantX < plantXLength; plantX++) {
//          int currentX = plantX + x;
//          int currentY = plantY + y;
//          int currentZ = plantZ + z;
//          if(getBlock(currentX, currentY, currentZ) == 0) {
//            setBlock(currentX, currentY, currentZ, plantModel[plantX][plantY][plantZ]);
//            
//            if(plantZ == 0 && plantModel[plantX][plantY][plantZ] != 0
//              && getBlock(currentX, currentY, currentZ - 1) == 0){ //If there is empty space under the plant
//              println("Dirt fill start");
//              for(int z1 = currentZ - 1; z1 >= 0; z1--) { //Fill the empty space with dirt
//                if(getBlock(currentX, currentY, z1) != 0) {
//                  break;
//                }
//                
//                setBlock(currentX, currentY, z1, 6); //Dirt
//                println("dirt");
//              }
//            }
//            
//          }
//        }
//      }
//    }
  }
  
  void createErosionDepth() {
    erosionDepth = new int[13];
    erosionDepth[2] = 3; //Stone
    erosionDepth[5] = 1; //Grass
    erosionDepth[6] = 4; //Dirt
    erosionDepth[11] = 4;//Sand
    erosionDepth[12] = 3;//Clay
  }
  
  void addWater(int x, int y) {
    for(int z = 0; z < waterLevel; z++) {
      int currentBlock = terrain[x][y][z];
      if(currentBlock == 0) {
        terrain[x][y][z] = 1; //Water
      }
    }
    
    if(snow && waterLevel != 0) {
      int z = waterLevel - 1;
      if(terrain[x][y][z] == 1) {
        terrain[x][y][z] = 8; //Ice
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
      if(currentBlock != 0) { //Nothing
        if(currentBlock != 1 && level < size - 1) { //Water
          terrain[x][y][level + 1] = 7; //Snow
        }
        break;
      }
    }
  }
}
