GTextField txfSeed;
GButton btnGenerate;
GButton btnGenerateSeed;

GButton btnSeason1;
GButton btnSeason2;
GButton btnSeason3;
GButton btnSeason4;

GButton btnRotateRight;
GButton btnRotateLeft;

GCustomSlider sdrLayers;

GLabel lblSize;
GCustomSlider sdrSize;

void makeGui() {
  txfSeed = new GTextField(this, 0, 0, 256, 24);
  txfSeed.setText("Seed.");
  
  btnGenerate = new GButton(this, 0, 24, 128, 24, "Generate Random");
  btnGenerateSeed = new GButton(this, 128, 24, 128, 24, "Generate w/ Seed");
  
  btnSeason1 = new GButton(this, 0, 56, 64, 24, "Winter");
  btnSeason2 = new GButton(this, 64, 56, 64, 24, "Spring");
  btnSeason3 = new GButton(this, 128, 56, 64, 24, "Summer");
  btnSeason4 = new GButton(this, 192, 56, 64, 24, "Fall");
  
  lblSize = new GLabel(this, width - 256, 0, 128, 16, "Terrain Size:");
  lblSize.setTextAlign(GAlign.LEFT, null);
  
  
  sdrSize = new GCustomSlider(this, width - 256, 16, 256, 48, null);
  sdrSize.setShowDecor(false, false, true, true);
  sdrSize.setLimits(24, 8, 48);
  
  //btnRotateLeft = new GButton(this, width - 256, 0, 128, 24, "Rotate Left");
  //btnRotateRight = new GButton(this, width - 128, 0, 128, 24, "Rotate Right");
  
  /*sdrLayers = new GCustomSlider(this, width - 256, 36, 256, 24, null);
  sdrLayers.setShowDecor(false, true, true, true);
  sdrLayers.setNbrTicks(size);
  sdrLayers.setLimits(0, 0, size);
  sdrLayers.setStickToTicks(true); */
}

void handleButtonEvents(GButton button, GEvent event) {
  if (button == btnGenerate && event == GEvent.CLICKED) {
    txfSeed.setText(str(generateRandom()));
  }
  if (button == btnGenerateSeed && event == GEvent.CLICKED) {
    int seed = int(txfSeed.getText());
    generateWithSeed(seed);
  }
  
  if (button == btnSeason1 && event == GEvent.CLICKED) {
    switchSeason(1);
  }
  if (button == btnSeason2 && event == GEvent.CLICKED) {
    switchSeason(2);
  }
  if (button == btnSeason3 && event == GEvent.CLICKED) {
    switchSeason(3);
  }
  if (button == btnSeason4 && event == GEvent.CLICKED) {
    switchSeason(4);
  }
  
  if (button == btnRotateLeft && event == GEvent.CLICKED) {
    rotateLeft();
  }
  if (button == btnRotateRight && event == GEvent.CLICKED) {
    rotateRight();
  }
}

int getTerrainSize() {
  return sdrSize.getValueI();
}