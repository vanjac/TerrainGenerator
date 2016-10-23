GTextField txfSeed;
GButton btnGenerateRandom;
GButton btnGenerateSeed;

GButton btnSeasonWinter;
GButton btnSeasonSpring;
GButton btnSeasonSummer;
GButton btnSeasonFall;

GLabel lblSize;
GCustomSlider sdrSize;

final color defaultSeasonButtonColor = color(63, 127, 191);
final color selectedSeasonButtonColor = color(0, 255, 0);

void makeGui() {
  txfSeed = new GTextField(this, 0, 0, 256, 24);
  txfSeed.setText("Seed.");
  
  btnGenerateRandom = new GButton(this, 0, 24, 128, 24, "Generate Random");
  btnGenerateSeed = new GButton(this, 128, 24, 128, 24, "Generate w/ Seed");
  
  btnSeasonWinter = new GButton(this, 0, 56, 64, 24, "Winter");
  btnSeasonSpring = new GButton(this, 64, 56, 64, 24, "Spring");
  btnSeasonSummer = new GButton(this, 128, 56, 64, 24, "Summer");
  btnSeasonFall = new GButton(this, 192, 56, 64, 24, "Fall");
  btnSeasonWinter.setVisible(false);
  btnSeasonSpring.setVisible(false);
  btnSeasonSummer.setVisible(false);
  btnSeasonFall.setVisible(false);
  clearSeasonButtonColors();
  
  lblSize = new GLabel(this, width - 256, 0, 128, 16, "Terrain Size:");
  lblSize.setTextAlign(GAlign.LEFT, null);
  
  
  sdrSize = new GCustomSlider(this, width - 256, 16, 256, 48, null);
  sdrSize.setShowDecor(false, false, true, true);
  sdrSize.setLimits(24, 8, 128);
}

void handleButtonEvents(GButton button, GEvent event) {
  if (button == btnGenerateRandom && event == GEvent.CLICKED) {
    generateRandom();
  }
  if (button == btnGenerateSeed && event == GEvent.CLICKED) {
    int seed = int(txfSeed.getText());
    generateWithSeed(seed);
  }
  
  if (button == btnSeasonWinter && event == GEvent.CLICKED) {
    switchSeason(SEASON_WINTER);
  }
  if (button == btnSeasonSpring && event == GEvent.CLICKED) {
    switchSeason(SEASON_SPRING);
  }
  if (button == btnSeasonSummer && event == GEvent.CLICKED) {
    switchSeason(SEASON_SUMMER);
  }
  if (button == btnSeasonFall && event == GEvent.CLICKED) {
    switchSeason(SEASON_FALL);
  }
}

int guiGetTerrainSize() {
  return sdrSize.getValueI();
}

void guiSetSeason(int season) {
  clearSeasonButtonColors();
  btnSeasonWinter.setVisible(true);
  btnSeasonSpring.setVisible(true);
  btnSeasonSummer.setVisible(true);
  btnSeasonFall.setVisible(true);
  switch(season) {
    case SEASON_WINTER:
      btnSeasonWinter.setLocalColor(4, selectedSeasonButtonColor);
      break;
    case SEASON_SPRING:
      btnSeasonSpring.setLocalColor(4, selectedSeasonButtonColor);
      break;
    case SEASON_SUMMER:
      btnSeasonSummer.setLocalColor(4, selectedSeasonButtonColor);
      break;
    case SEASON_FALL:
      btnSeasonFall.setLocalColor(4, selectedSeasonButtonColor);
      break;
  }
}

void clearSeasonButtonColors() {
  btnSeasonWinter.setLocalColor(4, defaultSeasonButtonColor);
  btnSeasonSpring.setLocalColor(4, defaultSeasonButtonColor);
  btnSeasonSummer.setLocalColor(4, defaultSeasonButtonColor);
  btnSeasonFall.setLocalColor(4, defaultSeasonButtonColor);
}

void guiSetSeed(long seed) {
  println("Seed: " + seed);
  txfSeed.setText(String.format("%d", seed));
}