class ChairState {
  List<int> value;
  int stateInt;

  ChairState(List<int> rawValue)
      : assert(rawValue != null),
        assert(rawValue.length == 6) {
    this.value = rawValue;
    this.stateInt = rawValue[2];
  }

  int get battery => value[4];
  int get temperature => value[3];
  int get version => value[1];

  bool get allClear => stateInt == 63;
  bool get leg => (stateInt >> 5) % 2 == 1;
  bool get rfix => (stateInt >> 4) % 2 == 1;
  bool get lfix => (stateInt >> 3) % 2 == 1;
  bool get routation => (stateInt >> 2) % 2 == 1;
  bool get pad => (stateInt >> 1) % 2 == 1;
  bool get buckle => stateInt % 2 == 1;
}

enum AlertType {
  babyInCarWhenLeaving,
  installErr,
  lowBattery,
  highTemp,
  lowTemp,
}