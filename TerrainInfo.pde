class TerrainInfo {
  int size;
  int getSize() {
    return size;
  }
  
  int[][] heightMap;
  int[][] getHeightMap() {
    return heightMap;
  }
  void setHeightMap(int[][] heightMap) {
    this.heightMap = heightMap;
  }
  
  
  Climate climate;
  Climate getClimate() {
    return climate;
  }
  void setClimate(Climate c) {
    climate = c;
  }
  
  
  int waterLevel;
  int getWaterLevel() {
    return waterLevel;
  }
  void setWaterLevel(int level) {
    waterLevel = level;
  }
  
  
  boolean[][][] dirt;
  boolean[] getDirt(int x, int y) {
    return dirt[x][y];
  }
  boolean[][][] getAllDirt() {
    return dirt;
  }
  void setAllDirt(boolean[][][] value) {
    dirt = value;
  }
  
  
  int[][] erosion;
  int getErosion(int x, int y) {
    return erosion[x][y];
  }
  int[][] getAllErosion() {
    return erosion;
  }
  void setAllErosion(int[][] value) {
    erosion = value;
  }
  
  
  Plant[][] plants;
  Plant getPlant(int x, int y) {
    return plants[x][y];
  }
  Plant[][] getAllPlants() {
    return plants;
  }
  void setAllPlants(Plant[][] value) {
    plants = value;
  }
  
  
  boolean hotDesertClimate() {
    return grassProb() < 0.25 && climate.getTemperature() >= 24;
  }
  
  TerrainInfo(int size) {
    this.size = size;
  }
  
  float grassProb() {
    GrowingConditions plant = new GrowingConditions(1, 36, 0, 30, 4,
      16, 2, 16, 4);
    return plant.conditions(climate);
  }
  
  float treeProb() {
    GrowingConditions plant = new GrowingConditions(0.03125, 32, 4, 20, 20,
      16, 4, 10, 10);
    return plant.conditions(climate);
  }
  
  float flowerProb() {
    GrowingConditions plant = new GrowingConditions(1, 36, 0, 28, 8,
      16, 2, 16, 6);
    return plant.conditions(climate);
  }
  
  float cactusProb() {
    GrowingConditions plant = new GrowingConditions(0.03125, 48, 28, 44, 36,
      6, 0, 2, 2);
    return plant.conditions(climate);
  }
  
  float bushProb() {
    GrowingConditions plant = new GrowingConditions(1.0 / 128.0, 36, 0, 30, 4,
      16, 2, 16, 4);
    return plant.conditions(climate);
  }
  
  void printInfo() {
    println("..:: TerrainInfo ::..");
    climate.printClimate();
    println("WaterLevel: " + waterLevel);
    println("grassProb: " + grassProb());
    println("bushProb: " + bushProb());
    println("treeProb: " + treeProb());
    println("flowerProb: " + flowerProb());
    println("cactusProb: " + cactusProb());
    if(hotDesertClimate()) {
      println("Hot desert climate.");
    }
  }
  
}



class SeasonInfo {
  int season;
  int getSeason() {
    return season;
  }
  
  Weather weather;
  Weather getWeather() {
    return weather;
  }
  
  SeasonInfo(TerrainInfo info, int season) {
    this.season = season;
    weather = new Weather(season, info.getClimate());
  }
  
  void printInfo() {
    println("..:: SeaonInfo ::..");
    weather.printWeather();
    println("Season: " + season);
  }
}
