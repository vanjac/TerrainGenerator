GTextField txfSeed;
GButton btnGenerate;
GButton btnGenerateSeed;

GButton btnSeason1;
GButton btnSeason2;
GButton btnSeason3;
GButton btnSeason4;

GLabel lblSize;
GCustomSlider sdrSize;

final color defaultSeasonButtonColor = color(63, 127, 191);
final color selectedSeasonButtonColor = color(0, 255, 0);

void makeGui() {
  txfSeed = new GTextField(this, 0, 0, 256, 24);
  txfSeed.setText("Seed.");
  
  btnGenerate = new GButton(this, 0, 24, 128, 24, "Generate Random");
  btnGenerateSeed = new GButton(this, 128, 24, 128, 24, "Generate w/ Seed");
  
  btnSeason1 = new GButton(this, 0, 56, 64, 24, "Winter");
  btnSeason2 = new GButton(this, 64, 56, 64, 24, "Spring");
  btnSeason3 = new GButton(this, 128, 56, 64, 24, "Summer");
  btnSeason4 = new GButton(this, 192, 56, 64, 24, "Fall");
  clearSeasonButtonColors();
  
  lblSize = new GLabel(this, width - 256, 0, 128, 16, "Terrain Size:");
  lblSize.setTextAlign(GAlign.LEFT, null);
  
  
  sdrSize = new GCustomSlider(this, width - 256, 16, 256, 48, null);
  sdrSize.setShowDecor(false, false, true, true);
  sdrSize.setLimits(24, 8, 64);
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
    switchSeason(SEASON_WINTER);
  }
  if (button == btnSeason2 && event == GEvent.CLICKED) {
    switchSeason(SEASON_SPRING);
  }
  if (button == btnSeason3 && event == GEvent.CLICKED) {
    switchSeason(SEASON_SUMMER);
  }
  if (button == btnSeason4 && event == GEvent.CLICKED) {
    switchSeason(SEASON_FALL);
  }
}

int getTerrainSize() {
  return sdrSize.getValueI();
}

void guiSetSeason(int season) {
  clearSeasonButtonColors();
  switch(season) {
    case SEASON_WINTER:
      btnSeason1.setLocalColor(4, selectedSeasonButtonColor);
      break;
    case SEASON_SPRING:
      btnSeason2.setLocalColor(4, selectedSeasonButtonColor);
      break;
    case SEASON_SUMMER:
      btnSeason3.setLocalColor(4, selectedSeasonButtonColor);
      break;
    case SEASON_FALL:
      btnSeason4.setLocalColor(4, selectedSeasonButtonColor);
      break;
  }
}

void clearSeasonButtonColors() {
  btnSeason1.setLocalColor(4, defaultSeasonButtonColor);
  btnSeason2.setLocalColor(4, defaultSeasonButtonColor);
  btnSeason3.setLocalColor(4, defaultSeasonButtonColor);
  btnSeason4.setLocalColor(4, defaultSeasonButtonColor);
}