class TemperatureMonitor {
  int highLimit;
  int lowLimit;
  bool highOn;
  bool lowOn;
  bool isF;

  TemperatureMonitor({
    this.highLimit = 30,
    this.lowLimit = 20,
    this.highOn = false,
    this.lowOn = false,
    this.isF = false,
  });

  String get hightLimitText {
    String tempValue = !isF ? '$highLimit' : '${(highLimit * 1.8).round() + 32}';
    String unit = !isF ? '℃': '℉';
    return tempValue + unit;
  }

  String get lowLimitText {
    String tempValue = !isF ? '$lowLimit' : '${(lowLimit * 1.8).round() + 32}';
    String unit = !isF ? '℃': '℉';
    return tempValue + unit;
  }
}