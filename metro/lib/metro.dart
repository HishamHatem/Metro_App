import 'dart:collection';

class OptimizedMetro {
  // Each station maps to its adjacent stations only
  static const Map<String, List<String>> adjacencyList = {
    // Line 1 (Sequential connections)
    "helwan": ["ain helwan"],
    "ain helwan": ["helwan", "helwan university"],
    "helwan university": ["ain helwan", "wadi hof"],
    "wadi hof": ["helwan university", "hadayek helwan"],
    "hadayek helwan": ["wadi hof", "elmaasara"],
    "elmaasara": ["hadayek helwan", "tora elasmant"],
    "tora elasmant": ["elmaasara", "kozzika"],
    "kozzika": ["tora elasmant", "tora elbalad"],
    "tora elbalad": ["kozzika", "sakanat elmaadi"],
    "sakanat elmaadi": ["tora elbalad", "maadi"],
    "maadi": ["sakanat elmaadi", "hadayek elmaadi"],
    "hadayek elmaadi": ["maadi", "dar elsalam"],
    "dar elsalam": ["hadayek elmaadi", "elzahraa"],
    "elzahraa": ["dar elsalam", "mar girgis"],
    "mar girgis": ["elzahraa", "elmalek elsaleh"],
    "elmalek elsaleh": ["mar girgis", "alsayeda zeinab"],
    "alsayeda zeinab": ["elmalek elsaleh", "saad zaghloul"],
    "saad zaghloul": ["alsayeda zeinab", "sadat"],
    "sadat": ["saad zaghloul", "gamal abdel nasser", "mohamed naguib", "opera"],
    "gamal abdel nasser": ["sadat", "orabi", "attaba", "maspero"],
    "orabi": ["gamal abdel nasser", "alshohadaa"],
    "alshohadaa": ["orabi", "ghamra", "masarra", "attaba"],
    "ghamra": ["alshohadaa", "eldemerdash"],
    "eldemerdash": ["ghamra", "manshiet elsadr"],
    "manshiet elsadr": ["eldemerdash", "kobri elqobba"],
    "kobri elqobba": ["manshiet elsadr", "hammamat elqobba"],
    "hammamat elqobba": ["kobri elqobba", "saray elqobba"],
    "saray elqobba": ["hammamat elqobba", "hadayek elzaitoun"],
    "hadayek elzaitoun": ["saray elqobba", "helmeyet elzaitoun"],
    "helmeyet elzaitoun": ["hadayek elzaitoun", "elmatareyya"],
    "elmatareyya": ["helmeyet elzaitoun", "ain shams"],
    "ain shams": ["elmatareyya", "ezbet elnakhl"],
    "ezbet elnakhl": ["ain shams", "elmarg"],
    "elmarg": ["ezbet elnakhl", "new elmarg"],
    "new elmarg": ["elmarg"],

    // Line 2
    "shubra elkheima": ["kolleyyet elzeraa"],
    "kolleyyet elzeraa": ["shubra elkheima", "mezallat"],
    "mezallat": ["kolleyyet elzeraa", "khalafawy"],
    "khalafawy": ["mezallat", "st. teresa"],
    "st. teresa": ["khalafawy", "rod elfarag"],
    "rod elfarag": ["st. teresa", "masarra"],
    "masarra": ["rod elfarag", "alshohadaa"],
    "attaba": [
      "alshohadaa",
      "mohamed naguib",
      "bab elshaariya",
      "gamal abdel nasser",
    ],
    "mohamed naguib": ["attaba", "sadat"],
    "opera": ["sadat", "dokki"],
    "dokki": ["opera", "el bohoth"],
    "el bohoth": ["dokki", "cairo university"],
    "cairo university": ["el bohoth", "faisal", "boulak el dakrour"],
    "faisal": ["cairo university", "giza"],
    "giza": ["faisal", "omm elmasryeen"],
    "omm elmasryeen": ["giza", "sakiat mekky"],
    "sakiat mekky": ["omm elmasryeen", "elmounib"],
    "elmounib": ["sakiat mekky"],

    // Line 3
    "adly mansour": ["elhaykestep"],
    "elhaykestep": ["adly mansour", "omar ibn elkhattab"],
    "omar ibn elkhattab": ["elhaykestep", "qubaa"],
    "qubaa": ["omar ibn elkhattab", "hesham barakat"],
    "hesham barakat": ["qubaa", "elnozha"],
    "elnozha": ["hesham barakat", "el shams club"],
    "el shams club": ["elnozha", "alf masken"],
    "alf masken": ["el shams club", "heliopolis"],
    "heliopolis": ["alf masken", "haroun"],
    "haroun": ["heliopolis", "alahram"],
    "alahram": ["haroun", "koleyet elbanat"],
    "koleyet elbanat": ["alahram", "stadium"],
    "stadium": ["koleyet elbanat", "fair zone"],
    "fair zone": ["stadium", "abbassiya"],
    "abbassiya": ["fair zone", "abdou pasha"],
    "abdou pasha": ["abbassiya", "elgeish"],
    "elgeish": ["abdou pasha", "bab elshaariya"],
    "bab elshaariya": ["elgeish", "attaba"],
    "maspero": ["gamal abdel nasser", "safaa hijazy"],
    "safaa hijazy": ["maspero", "kit kat"],
    "kit kat": ["safaa hijazy", "sudan", "tawfikia"],
    "sudan": ["kit kat", "imbaba"],
    "imbaba": ["sudan", "elbohy"],
    "elbohy": ["imbaba", "elqawmia"],
    "elqawmia": ["elbohy", "ring road"],
    "ring road": ["elqawmia", "rod elfarag corridor"],
    "rod elfarag corridor": ["ring road"],
    "tawfikia": ["kit kat", "wadi el nile"],
    "wadi el nile": ["tawfikia", "gamet el dowal"],
    "gamet el dowal": ["wadi el nile", "boulak el dakrour"],
    "boulak el dakrour": ["gamet el dowal", "cairo university"],
  };

  // Line information for each station
  static const Map<String, int> stationLines = {
    // Line 1 stations
    "helwan": 1, "ain helwan": 1, "helwan university": 1, "wadi hof": 1,
    "hadayek helwan": 1, "elmaasara": 1, "tora elasmant": 1, "kozzika": 1,
    "tora elbalad": 1, "sakanat elmaadi": 1, "maadi": 1, "hadayek elmaadi": 1,
    "dar elsalam": 1, "elzahraa": 1, "mar girgis": 1, "elmalek elsaleh": 1,
    "alsayeda zeinab": 1, "saad zaghloul": 1, "orabi": 1, "ghamra": 1,
    "eldemerdash": 1,
    "manshiet elsadr": 1,
    "kobri elqobba": 1,
    "hammamat elqobba": 1,
    "saray elqobba": 1, "hadayek elzaitoun": 1, "helmeyet elzaitoun": 1,
    "elmatareyya": 1,
    "ain shams": 1,
    "ezbet elnakhl": 1,
    "elmarg": 1,
    "new elmarg": 1,

    // Line 2 stations
    "shubra elkheima": 2, "kolleyyet elzeraa": 2, "mezallat": 2, "khalafawy": 2,
    "st. teresa": 2, "rod elfarag": 2, "masarra": 2, "opera": 2, "dokki": 2,
    "el bohoth": 2, "faisal": 2, "giza": 2, "omm elmasryeen": 2,
    "sakiat mekky": 2, "elmounib": 2,

    // Line 3 stations
    "adly mansour": 3, "elhaykestep": 3, "omar ibn elkhattab": 3, "qubaa": 3,
    "hesham barakat": 3, "elnozha": 3, "el shams club": 3, "alf masken": 3,
    "heliopolis": 3, "haroun": 3, "alahram": 3, "koleyet elbanat": 3,
    "stadium": 3, "fair zone": 3, "abbassiya": 3, "abdou pasha": 3,
    "elgeish": 3, "safaa hijazy": 3, "sudan": 3, "imbaba": 3, "elbohy": 3,
    "elqawmia": 3, "ring road": 3, "rod elfarag corridor": 3, "tawfikia": 3,
    "wadi el nile": 3, "gamet el dowal": 3,

    // Transfer stations
    "sadat": 1, "gamal abdel nasser": 1, "alshohadaa": 1, "attaba": 2,
    "mohamed naguib": 2, "cairo university": 2, "bab elshaariya": 3,
    "maspero": 3, "kit kat": 3, "boulak el dakrour": 3,
  };

  // Utility methods
  static List<String>? getConnections(String station) {
    return adjacencyList[station];
  }

  static int? getLine(String station) {
    return stationLines[station];
  }

  // Get all station names for dropdown
  static List<String> getAllStations() {
    return stationLines.keys.toList()..sort();
  }
}

// Metro PathFinder class
class MetroPathFinder {
  int count = 0;
  int time = 0;
  int ticket = 0;
  String nearestStation = "";
  List<List<String>> allPaths = [];

  void findPaths(String start, String end) {
    // Reset previous results
    allPaths.clear();

    // Validate stations exist
    if (!OptimizedMetro.adjacencyList.containsKey(start) ||
        !OptimizedMetro.adjacencyList.containsKey(end)) {
      print('quit early');
      return;
    }

    // If start and end are the same
    if (start == end) {
      print('start=end');
      allPaths.add([start]);
      count = 0;
      time = 0;
      ticket = 8; // Minimum ticket price
      return;
    }

    Queue<List<String>> queue = Queue<List<String>>();
    List<List<String>> foundPaths = [];

    queue.add([start]);

    while (queue.isNotEmpty) {
      List<String> path = queue.removeFirst();
      String currentStation = path.last;

      if (currentStation == end) {
        foundPaths.add(List.from(path));
        continue;
      }

      if (path.length >= 50) continue; // Prevent infinite loops

      List<String>? neighbors = OptimizedMetro.getConnections(currentStation);
      if (neighbors == null) continue;

      for (String neighborStation in neighbors) {
        if (!path.contains(neighborStation)) {
          List<String> newPath = List.from(path);
          newPath.add(neighborStation);
          queue.add(newPath);
        }
      }
    }

    foundPaths.sort((a, b) => a.length.compareTo(b.length));

    if (foundPaths.isNotEmpty) {
      List<String> shortestPath = foundPaths[0];
      this.count = shortestPath.length - 1;
      this.time = _calculateTravelTime(shortestPath);
      this.ticket = _calculateTicketPrice(this.count);
    }

    this.allPaths = foundPaths;
  }

  int _calculateTravelTime(List<String> path) {
    if (path.length <= 1) return 0;

    int totalTime = 0;
    int? previousLine = OptimizedMetro.getLine(path[0]);

    for (int i = 1; i < path.length; i++) {
      String currentStation = path[i];
      int? currentLine = OptimizedMetro.getLine(currentStation);

      if (previousLine != null &&
          currentLine != null &&
          previousLine != currentLine) {
        totalTime += 5; // Transfer time
      } else {
        totalTime += 2; // Normal travel time
      }

      previousLine = currentLine;
    }

    return totalTime;
  }

  int _calculateTicketPrice(int stationCount) {
    if (stationCount <= 9) {
      return 8;
    } else if (stationCount > 23) {
      return 20;
    } else {
      return 10 + 5 * ((stationCount - 9) ~/ 7);
    }
  }

  String printSinglePath(int index) {
    if (allPaths.isEmpty || index >= allPaths.length) {
      return "No path found or invalid index!";
    }

    List<String> path = allPaths[index];
    if (path.length < 1) return "Invalid path!";

    if (path.length == 1) {
      return "You are already at ${path[0]}!";
    }

    String result = "";
    String startStation = path[0];
    int? startLine = OptimizedMetro.getLine(startStation);

    result += "🚇 Start from $startStation (Line $startLine)\n\n";

    int? previousLine = startLine;
    int totalMinutes = 0;
    int lineChanges = 0;

    for (int i = 1; i < path.length; i++) {
      String currentStation = path[i];
      int? currentLine = OptimizedMetro.getLine(currentStation);

      if (previousLine != null &&
          currentLine != null &&
          previousLine != currentLine) {
        result +=
            "🔄 Transfer at $currentStation: Line $previousLine → Line $currentLine\n";
        totalMinutes += 5;
        lineChanges++;
      } else {
        result += "➡️  Continue to $currentStation (Line $currentLine)\n";
        totalMinutes += 2;
      }

      previousLine = currentLine;
    }

    String finalStation = path.last;
    result += "\n🎯 Arrived at $finalStation\n\n";
    result += "📊 Journey Summary:\n";
    result += "• Stations: ${path.length}\n";
    result += "• Line changes: $lineChanges\n";
    result += "• Time: $totalMinutes minutes\n";
    result += "• Ticket: ${_calculateTicketPrice(path.length - 1)} EGP";

    return result;
  }

  String getAllPathsSummary() {
    if (allPaths.isEmpty) {
      return "No paths found!";
    }

    String summary = "🚇 Found ${allPaths.length} possible path(s):\n\n";

    for (int i = 0; i < allPaths.length && i < 5; i++) {
      List<String> path = allPaths[i];
      int time = _calculateTravelTime(path);
      summary += "Path ${i + 1}: ${path.length} stations, $time min\n";
      summary += "${path.join(' → ')}\n\n";
    }

    // if (allPaths.length > 5) {
    //   summary += "... and ${allPaths.length - 5} more paths";
    // }

    return summary;
  }
}
