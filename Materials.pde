static final int MAT_EMPTY = 0;
static final int MAT_WATER = 1;
static final int MAT_STONE = 2;
static final int MAT_WOOD = 3;
static final int MAT_LEAVES = 4;
static final int MAT_GRASS = 5;
static final int MAT_DIRT = 6;
static final int MAT_SNOW = 7;
static final int MAT_ICE = 8;
static final int MAT_DEAD_GRASS = 9;

static final int MAT_SAND = 11;
static final int MAT_CLAY = 12;

static final int MAT_RED_FLOWER = 14;
static final int MAT_YELLOW_FLOWER = 15; // these NEED to be next to each other, see Flower.drawPlant() and Cactus.drawPlant()
static final int MAT_DEAD_LEAVES = 16;
static final int MAT_CACTUS = 17;

static final int NUM_MATERIALS = 18;

boolean isSmallBlock(int mat) {
  return mat == MAT_RED_FLOWER || mat == MAT_YELLOW_FLOWER;
}

boolean isFullBlock(int mat) {
  return mat != 0 && !isSmallBlock(mat);
}