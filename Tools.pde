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