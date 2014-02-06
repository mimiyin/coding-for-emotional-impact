class Dartboard {
  float [] zones;
  float min, max;

  Dartboard(int numZones, float _max) {
    zones = new float[numZones];
    float offset = 0;
    print("ZONES: ");
    for (int i = 0; i < numZones; i++) {
      offset += random(1);
      zones[i] = offset;
      // Print out the values all in one line
      print(i + ": " + zones[i] + "\t");
    }
    print("\n");
    max = _max < 0 ? offset : _max;
  }

  int fire() {
    float dart = random(min, max); 
    
    for (int i = 0; i < zones.length; i++) {
      if ( dart <= zones[i]) {
        return i;
      }
    }
    return -1;
  }
}

