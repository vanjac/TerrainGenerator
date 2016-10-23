interface HeightMapGenerator {
  int[][] generate(int size, float depth, float hills);
}

class MidpointDisplacement implements HeightMapGenerator {
  int size;
  float depth;
  float hills;
  float[][] heightMap;
  
  
  int[][] generate(int startSize, float depth, float hills) {
    this.depth = depth;  
    this.hills = hills;
    for(size = 2; size < startSize; size *= 2){}
    heightMap = new float[size + 1][size + 1];
    
    float error = depth * hills;
    float offset = random(-depth/4, depth/4);
    heightMap[0][0] = random(-error, error) + offset;
    heightMap[size][0] = random(-error, error) + offset;
    heightMap[0][size] = random(-error, error) + offset;
    heightMap[size][size] = random(-error, error) + offset;
    
    generateRecursive(0, size, 0, size);
    
    int[][] newHeightMap = new int[size + 1][size + 1];
    
    for(int y = 0; y < size; y++) {
      for(int x = 0; x < size; x++) {
        newHeightMap[x][y] = round(heightMap[x][y]);
      }
    }
    
    return newHeightMap;
  }
  
  void generateRecursive(int x1, int x2, int y1, int y2) {
    int sectionSize = x2 - x1;
    if (sectionSize < 2) {
      return;
    }
    
    float error = sectionSize * (depth / size) * hills;
    
    float heightX1Y1 = heightMap[x1][y1];
    float heightX2Y1 = heightMap[x2][y1];
    float heightX1Y2 = heightMap[x1][y2];
    float heightX2Y2 = heightMap[x2][y2];
    
    heightMap[(x1 + x2) / 2][y1] = (heightX1Y1 + heightX2Y1) / 2;
    heightMap[(x1 + x2) / 2][y2] = (heightX1Y2 + heightX2Y2) / 2;
    heightMap[x1][(y1 + y2) / 2] = (heightX1Y1 + heightX1Y2) / 2;
    heightMap[x2][(y1 + y2) / 2] = (heightX2Y1 + heightX2Y2) / 2;
    heightMap[(x1 + x2) / 2][(y1 + y2) / 2] = (heightX1Y1 + heightX2Y1 + heightX1Y2 + heightX2Y2) / 4 + random(-error, error);
    
    generateRecursive(x1, (x1 + x2) / 2, y1, (y1 + y2) / 2);
    generateRecursive((x1 + x2) / 2, x2, y1, (y1 + y2) / 2);
    generateRecursive(x1, (x1 + x2) / 2, (y1 + y2) / 2, y2);
    generateRecursive((x1 + x2) / 2, x2, (y1 + y2) / 2, y2);
  }
  
}