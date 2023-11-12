  String getFormattedTime(Duration d) {
    return d.toString().split('.').first.padLeft(8, "0");
  }