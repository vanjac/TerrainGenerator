interface Plant {
  void drawPlant(int[][][] terrain, int x, int y, int z, SeasonInfo season);
}

class GrowingConditions {
  float maxProb;
  
  float tempMax;
  float tempMin;
  float bestTempMax;
  float bestTempMin;
  
  float humidMax;
  float humidMin;
  float bestHumidMax;
  float bestHumidMin;
  
  GrowingConditions(float maxProb, float tMax, float tMin, float btMax, float btMin,
    float hMax, float hMin, float bhMax, float bhMin) {
    this.maxProb = maxProb;
      
    tempMax = tMax;
    tempMin = tMin;
    bestTempMax = btMax;
    bestTempMin = btMin;
  
    humidMax = hMax;
    humidMin = hMin;
    bestHumidMax = bhMax;
    bestHumidMin = bhMin;
  }
  
  float conditions(Climate climate) {
    return maxProb * maxMinTest(climate.getTemperature(), tempMin, tempMax, bestTempMin, bestTempMax) * maxMinTest(climate.getHumidity(), humidMin, humidMax, bestHumidMin, bestHumidMax);
  }
  
  float maxMinTest(float value, float min, float max, float bestMin, float bestMax) {
    if (value >= min) {
      if (value >= bestMin) {
        if (value > bestMax) {
          if (value > max) {
            //value > max
            return 0;
          } else {
            //bestMax <= value < max
            return 1 - ((value - bestMax) / (max - bestMax));
          }
        } else {
          //best range
          return 1;
        }
      } else {
        //min <= value < bestMin
        return (bestMin - value) / (bestMin - min);
      }
    } else {
      //value < min
      return 0;
    }
  }
}


class Grass implements Plant {
  void drawPlant(int[][][] terrain, int x, int y, int z, SeasonInfo season) {
    if(season.getWeather().getTemperature() > 32) {
      setBlockWithoutReplace(terrain, x, y, z, 9); //Dead Grass
    } else {
      setBlockWithoutReplace(terrain, x, y, z, 5); //Grass
    }
  }
}

class Bush implements Plant {
  void drawPlant(int[][][] terrain, int x, int y, int z, SeasonInfo season) {
    new Grass().drawPlant(terrain, x, y, z, season);
    setBlockWithoutReplace(terrain, x, y, z + 1, 4); //Leaves
  }
}

class Tree implements Plant {
  int x, y, z;
  int leavesWidth;
  int leavesHeight;
  int trunkWidth;
  int trunkHeight;
  
  int leaves;
  
  int[][][] terrain;
  float center;
  
  Tree(Climate climate) {
    trunkWidth = 1;
    trunkHeight = (int)random(6, 10);
    leavesWidth = 3;
    leavesHeight = 3;
  }
  
  void drawPlant(int[][][] terrain, int x, int y, int z, SeasonInfo season) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.terrain = terrain;
    //center = ((float)leavesWidth - 1) / 2;
    center = 0;
    if(season.getSeason() == 4) {
      leaves = 16; //Dead leaves
    } else {
      leaves = 4; //Leaves
    }
    if(season.getSeason() != 1) {
      drawLowerLeaves();
    }
    drawTrunk();
    if(season.getSeason() != 1) {
      drawUpperLeaves();
    }
    
    
  }
  
  void drawTrunk() {
    float start = center - (((float)trunkWidth - 1) / 2);
    float stop = center + (((float)trunkWidth - 1) / 2);
    
    drawBlockBlock(terrain, 3, start + x, start + y, (float)z, stop + x, stop + y, (float)(z + trunkHeight - 1)); //Wood
  }
  
  void drawLowerLeaves() {
    float start = center - (((float)leavesWidth - 1) / 2);
    float stop = center + (((float)leavesWidth - 1) / 2);
    
    float startZ = z + trunkHeight - ((float)leavesHeight * (2.0 / 3.0));
    float stopZ = z + trunkHeight - 1;
    
    drawBlockBlock(terrain, leaves, start + x, start + y, startZ, stop + x, stop + y, stopZ);
  }
  
  void drawUpperLeaves() {
    float start = center - (((float)leavesWidth / 2 - 1) / 2);
    float stop = center + (((float)leavesWidth / 2 - 1) / 2);
    
    float startZ = z + trunkHeight;
    float stopZ = z + trunkHeight + ((float)leavesHeight / 3) - 1;
    
    drawBlockBlock(terrain, leaves, start + x, start + y, startZ, stop + x, stop + y, stopZ);
  }
}

class Flower implements Plant {
  void drawPlant(int[][][] terrain, int x, int y, int z, SeasonInfo season) {
    new Grass().drawPlant(terrain, x, y, z, season);
    if(season.getSeason() == 1) {
      return;
    }
    
    if(season.getSeason() == 2) {
      if(random(1) <= 0.0625) {
        setBlockWithoutReplace(terrain, x, y, z + 1, round(random(14, 15))); //Red / Yellow flower
      }
    } else {
      if(random(1) <= 0.03125) {
        setBlockWithoutReplace(terrain, x, y, z + 1, round(random(14, 15)));//Red / Yellow flower
      }
    }
    
  }
}

class Cactus implements Plant {
  boolean flowering;
  int cactusHeight;
  
  Cactus() {
    flowering = random(1) <= 0.25;
    cactusHeight = round(random(2, 3));
  }
  
  void drawPlant(int[][][] terrain, int x, int y, int z, SeasonInfo season) {
    drawBlockBlock(terrain, 17, x, y, z, x, y, z + cactusHeight - 1); //Cactus
    if(flowering && season.getSeason() == 2) {
      setBlockWithoutReplace(terrain, x, y, z + cactusHeight, round(random(14, 15))); //Red / Yellow flower
    }
  }
}
