class Climate {
  float temperature; //in Celcius
  float getTemperature() {
    return temperature;
  }
  void setTemperature(float temp) {
    temperature = temp;
    if(temperature > 48) {
      temperature = 48;
    }
    if(temperature < -16) {
      temperature = -16;
    }
  }
  
  
  float humidity; //0: Very dry  15: Very humid
  float getHumidity() {
    return humidity;
  }
  void setHumidity(float humid) {
    humidity = humid;
    if(humidity > 16) {
      humidity = 16;
    }
    if(humidity < 0) {
      humidity = 0;
    }
  }
  
  
  Climate() {
    
  }
  Climate(float temperature, float humidity) {
    setTemperature(temperature);
    setHumidity(humidity);
  }
  
  
  void printClimate() {
    println("Temperature: " + temperature);
    println("Humidity: " + humidity);
    if(coldDesertClimate()) {
      println("Cold desert climate.");
    }
  }
  
  boolean coldDesertClimate() {
    return temperature <= 0 && humidity < 4;
  }
}



class Weather {
  float temperature; //in Celcius
  float getTemperature() {
    return temperature;
  }

  float humidity; //0: Very dry  15: Very humid
  float getHumidity() {
    return humidity;
  }
  
  int season;
  
  
  Weather(int season, Climate climate) {
    this.season = season;
    humidity = climate.getHumidity();
    temperature = climate.getTemperature();
    if(season == SEASON_WINTER) {
      temperature -= 16;
    } else if (season == SEASON_SUMMER) {
      temperature += 16;
    }
  }
  
  boolean snow() {
    return temperature <= 0 && humidity >= 4;
  }
  
  void printWeather() {
    println("Temperature: " + temperature);
    println("Humidity: " + humidity);
    if(snow()) {
      println("Snow!");
    }
  }
}