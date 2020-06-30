class ChairState {
  List<int> value;
  int stateInt;

  ChairState(List<int> rawValue)
      : assert(rawValue != null),
        assert(rawValue.length == 6) {
    this.value = rawValue;
    this.stateInt = rawValue[2];
    // battery
    if (this.value[4]<0) this.value[4] = 0;
    else if (this.value[4] > 100) this.value[4] = 100;
    //temperature
    if (this.value[3] < 0) this.value[3] = 0;
    else if (this.value[3] > 100) this.value[3] = 100;
    //stateInt
    if (this.stateInt < 0) this.stateInt = 0;
    else if (this.stateInt > 63) this.stateInt = 63;
  }

  int get battery => value[4];
  int get temperature => value[3];
  int get version => value[1];

  // bool get allClear => stateInt == 63;
  bool get allClear => stateInt >= 60;
  
  bool get leg => (stateInt >> 5) % 2 == 1;
  bool get rfix => (stateInt >> 4) % 2 == 1;
  bool get lfix => (stateInt >> 3) % 2 == 1;
  bool get routation => (stateInt >> 2) % 2 == 1;
  bool get pad => (stateInt >> 1) % 2 == 1;
  bool get buckle => stateInt % 2 == 1;

  bool get babyInCar => pad;
}

enum AlertType {
  babyInCarWhenLeaving,
  installErr,
  lowBattery,
  highTemp,
  lowTemp,
}