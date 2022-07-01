String formattedTime(int secTime) {
  String getParsedTime(String time) {
    if (time.length <= 1) return "0$time";
    return time;
  }

  int min = secTime ~/ 60;
  int sec = secTime % 60;

  String parsedTime =
      getParsedTime(min.toString()) + ":" + getParsedTime(sec.toString());

  return parsedTime;
}
