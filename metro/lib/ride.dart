import 'dart:collection';

class Ride {
  late final String firstStation;
  late final String secondStation;
  var listOfNamesAndLines = <String, List<String>>{};
  var time = 0;
  var count = 0;
  var ticket = 0;
  var nearestStation = '';

  Ride({required this.firstStation, required this.secondStation});
  //getters and setters
  String get getFirstStation => firstStation;
  String get getSecondStation => secondStation;
  Map<String, List<String>> get getListOfNamesAndLines => listOfNamesAndLines;
  int get getTime => time;
  int get getCount => count;
  int get getTicket => ticket;
  String get getNearestStation => nearestStation;

  set setFirstStation(String station) {
    firstStation = station;
  }

  set setSecondStation(String station) {
    secondStation = station;
  }

  set setListOfNamesAndLines(Map<String, List<String>> namesAndLines) {
    listOfNamesAndLines = namesAndLines;
  }

  set setTime(int t) {
    time = t;
  }

  set setCount(int c) {
    count = c;
  }

  set setTicket(int t) {
    ticket = t;
  }

  set setNearestStation(String station) {
    nearestStation = station;
  }

  // read json file
  void readJson() {
    // Implement the logic to read a JSON file
    // This could involve using the 'dart:convert' library to parse JSON data
    // and storing it in a suitable data structure.
  }
  // find the possible paths and the other data required (time, count, ticket, nearest station)
  List<List<String>> findPaths(
    Map<String, List<String>> jsonData,
    String startStation,
    String endStation,
  ) {
    Queue<List<String>> queue = Queue<List<String>>();
    List<List<String>> allPaths = [];

    // Get the starting line for the start station
    String startLine = jsonData[startStation]![0];

    // Start with the station and its line
    queue.add([startStation, startLine]);

    while (queue.isNotEmpty) {
      List<String> path = queue.removeFirst();
      String currentStation = path[path.length - 2]; // Last station
      // String currentLine = path[path.length - 1];    // Current line

      if (currentStation == endStation) {
        allPaths.add(path);
        continue;
      }

      // Get neighbors for current station
      List<String> stationData = jsonData[currentStation] ?? [];
      if (stationData.isEmpty) continue;

      // Process neighbors (pairs: station, line, station, line, ...)
      for (int i = 1; i < stationData.length; i += 2) {
        if (i + 1 < stationData.length) {
          String neighborStation = stationData[i];
          String neighborLine = stationData[i + 1];

          // Check if neighbor is already visited (avoid loops)
          bool alreadyVisited = false;
          for (int j = 0; j < path.length; j += 2) {
            if (path[j] == neighborStation) {
              alreadyVisited = true;
              break;
            }
          }

          if (!alreadyVisited) {
            List<String> newPath = List.from(path);
            newPath.add(neighborStation);
            newPath.add(neighborLine);
            queue.add(newPath);
          }
        }
      }
    }

    // Sort paths by length (shortest first)
    allPaths.sort((a, b) => a.length.compareTo(b.length));
    return allPaths;
  }
}
