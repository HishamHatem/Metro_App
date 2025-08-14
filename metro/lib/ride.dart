import 'dart:collection';

class Ride {
  late final String firstStation;
  late final String secondStation;
  var listOfNamesAndLines = <String, List<String>>{};
  List<List<String>> allPaths = [];
  var time = 0;
  var count = 4;
  var ticket = 0;
  var nearestStation = '';

  Ride({required this.firstStation, required this.secondStation});
  //getters and setters
  String get getFirstStation {
    return firstStation;
  }
  String get getSecondStation {
    return secondStation;
  }
  Map<String, List<String>> get getListOfNamesAndLines {
    return listOfNamesAndLines;
  }
  int get getTime {
    return time;
  }
  int get getCount {
    return count;
  }
  int get getTicket {
    return ticket;
  }
  String get getNearestStation {
    return nearestStation;
  }
  List<List<String>> get getAllPaths {
    return allPaths;
  }

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

  set setAllPaths(List<List<String>> paths) {
    allPaths = paths;
  }

  // read json file
  void readJson() {
    // Implement the logic to read a JSON file
    // This could involve using the 'dart:convert' library to parse JSON data
    // and storing it in a suitable data structure.
  }
  // find the possible paths and the other data required (time, count, ticket, nearest station)
  void findPaths(
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
    this.allPaths = allPaths;
  }

  String printSinglePath(int index, List<List<String>> paths){
    String result = "";
    if (paths.isEmpty) {
      return "No path found!";
    }

    // for (int pathIndex = 0; pathIndex < paths.length; pathIndex++) {
      var path = paths[index];

      // Start station
      result += "\nYou will start from ${path[0]} in ${path[1]}";

      String previousLine = path[1]; // First line
      int totalMinutes = 0;
      int stationCount = 1; // Starting station counts
      int linesCount = 1; // Starting line counts

      // Process the path
      for (int i = 2; i < path.length; i += 2) {
        if (i + 1 < path.length) {
          String currentStation = path[i];
          String currentLine = path[i + 1];

          stationCount++;

          if (previousLine != currentLine) {
            // Line change - transfer
            result += "\nContinue to $currentStation You will change from $previousLine to $currentLine";
            totalMinutes += 5; // Transfer takes 5 minutes
            linesCount++;
          } else {
            // Same line
            result += "\nContinue to $currentStation in the same line ";
            totalMinutes += 2; // Normal travel takes 2 minutes
          }

          previousLine = currentLine;
        }
      }

      result += "\nYou arrived to your destination ${path[path.length - 2]}";
    // }
    return result;
  }

  String printPaths(List<List<String>> paths) {
    String result = "";
    if (paths.isEmpty) {
      return "No path found!";
    }
    int shortest_lines = 100;
    int shortest_path_index = 0;
    for (int pathIndex = 0; pathIndex < paths.length; pathIndex++) {
      var path = paths[pathIndex];

      if (pathIndex != 0) {
        result += "\nPath ${pathIndex + 1}:";
      } else {
        result += "The shortest path according to number of stations is:";
      }

      // Start station
      result += "\nYou will start from ${path[0]} in ${path[1]}";

      String previousLine = path[1]; // First line
      int totalMinutes = 0;
      int stationCount = 1; // Starting station counts
      int linesCount = 1; // Starting line counts

      // Process the path
      for (int i = 2; i < path.length; i += 2) {
        if (i + 1 < path.length) {
          String currentStation = path[i];
          String currentLine = path[i + 1];

          stationCount++;

          if (previousLine != currentLine) {
            // Line change - transfer
            result += "\nContinue to $currentStation You will change from $previousLine to $currentLine";
            totalMinutes += 5; // Transfer takes 5 minutes
            linesCount++;
          } else {
            // Same line
            result += "\nContinue to $currentStation in the same line ";
            totalMinutes += 2; // Normal travel takes 2 minutes
          }

          previousLine = currentLine;
        }
      }

      result += "\nYou arrived to your destination ${path[path.length - 2]}";

      // Calculate ticket cost
      int ticket;
      if (stationCount <= 9) {
        ticket = 8;
      } else if (stationCount > 23) {
        ticket = 20;
      } else {
        ticket = 10 + 5 * ((stationCount - 9) ~/ 7);
      }

      // Display summary
      // print("\nTotal stations: $stationCount, Ticket cost: $ticket L.E.");

      if (totalMinutes >= 60) {
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;
        print("Average time: $hours hours and $minutes minutes");
      } else {
        print("Average time: $totalMinutes minutes");
      }

      if(linesCount < shortest_lines) {
        shortest_lines = linesCount;
        shortest_path_index = pathIndex;
      }

      if (pathIndex < paths.length - 1) {
        print("\n" + "="*50);
      }
    }
    print("\nThe shortest path according to number of lines is Path ${shortest_path_index + 1}, and has ${shortest_lines - 1} transitions.");
    return result;
  }
}
