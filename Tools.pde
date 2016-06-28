class Coordinate3d {
  int x;
  int y;
  int z;
  
  Coordinate3d(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  Coordinate3d() {
    x = 0;
    y = 0;
    z = 0;
  }
}


ArrayList<Coordinate3d> lowestPoints(int[][][] model) {
  int xLength = model.length;
  int yLength = model[0].length;
  int zLength = model[0][0].length;
  
  boolean lowestPointFound = false;
  
  ArrayList lowestPoints = new ArrayList<Coordinate3d>();
  
  for(int z = 0; z < xLength; z++) {
    for(int y = 0; y < xLength; y++) {
      for(int x = 0; x < xLength; x++) {
        if(model[x][y][z] != 0) {
          lowestPointFound = true;
          lowestPoints.add(new Coordinate3d(x, y, z));
        }
      }
    }
    if(lowestPointFound) {
      break;
    }
  }
  
  return lowestPoints;
}

void setBlock(int[][][] terrain, float x, float y, float z, int value) {
  if(round(x) >= terrain.length || round(x) < 0 || round(y) >= terrain[0].length || round(y) < 0 || round(z) >= terrain[0][0].length || round(z) < 0) {
   return;
  }
  
  terrain[round(x)][round(y)][round(z)] = value;
}

void setBlockWithoutReplace(int[][][] terrain, float x, float y, float z, int value) {
  if(round(x) >= terrain.length || round(x) < 0 || round(y) >= terrain[0].length || round(y) < 0 || round(z) >= terrain[0][0].length || round(z) < 0) {
   return;
  }
  
  if(getBlock(terrain, x, y, z) != 0) {
    return;
  }
  
  terrain[round(x)][round(y)][round(z)] = value;
}

int getBlock(int[][][] terrain, float x, float y, float z) {
  if(round(x) >= terrain.length || round(x) < 0 || round(y) >= terrain[0].length || round(y) < 0 || round(z) >= terrain[0][0].length || round(z) < 0) {
    return 0;
  }
  
  return terrain[round(x)][round(y)][round(z)];
}

void drawBlockBlock(int[][][] terrain, int block, float startX, float startY, float startZ, float stopX, float stopY, float stopZ) {
  for(float z = startZ; z <= stopZ; z++) {
    for(float y = startY; y <= stopY; y++) {
      for(float x = startX; x <= stopX; x++) {
        setBlock(terrain, x, y, z, block);
      }
    }
  }
}
