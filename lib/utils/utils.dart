class Utils {
  int dayParser(String date) {
    return DateTime.parse(date).day;
  }

  String convertTimeToHoursMins(double totalMins) {
    int totalMinutesInt = totalMins.toInt();
    int hours = totalMinutesInt ~/ 60;
    int minutes = totalMinutesInt % 60;

    String hoursPart = hours > 0 ? '$hours hour${hours > 1 ? 's' : ''}' : '';
    String minsPart =
        minutes > 0 ? '$minutes min${minutes > 1 ? 's' : ''}' : '';

    if (hoursPart.isNotEmpty && minsPart.isNotEmpty) {
      return '$hoursPart $minsPart';
    } else if (hoursPart.isNotEmpty) {
      return hoursPart;
    } else {
      return minsPart;
    }
  }
}
