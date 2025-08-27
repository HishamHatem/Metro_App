import 'package:flutter/material.dart';
import 'dart:collection';

// Ultra-lightweight Metro data using only arrays and indices
class UltraLightMetro {
  // Station names array - indices are used everywhere
  static const List<String> stationNames = [
    // Line 1 (indices 0-34)
    "helwan", "ain helwan", "helwan university", "wadi hof", "hadayek helwan",
    "elmaasara", "tora elasmant", "kozzika", "tora elbalad", "sakanat elmaadi",
    "maadi", "hadayek elmaadi", "dar elsalam", "elzahraa", "mar girgis",
    "elmalek elsaleh",
    "alsayeda zeinab",
    "saad zaghloul",
    "sadat",
    "gamal abdel nasser",
    "orabi", "alshohadaa", "ghamra", "eldemerdash", "manshiet elsadr",
    "kobri elqobba", "hammamat elqobba", "saray elqobba", "hadayek elzaitoun",
    "helmeyet elzaitoun",
    "elmatareyya",
    "ain shams",
    "ezbet elnakhl",
    "elmarg",
    "new elmarg",

    // Line 2 (indices 35-49)
    "shubra elkheima",
    "kolleyyet elzeraa",
    "mezallat",
    "khalafawy",
    "st. teresa",
    "rod elfarag", "masarra", "attaba", "mohamed naguib", "opera",
    "dokki", "el bohoth", "cairo university", "faisal", "giza",
    "omm elmasryeen", "sakiat mekky", "elmounib",

    // Line 3 (indices 50-77)
    "adly mansour",
    "elhaykestep",
    "omar ibn elkhattab",
    "qubaa",
    "hesham barakat",
    "elnozha", "el shams club", "alf masken", "heliopolis", "haroun",
    "alahram", "koleyet elbanat", "stadium", "fair zone", "abbassiya",
    "abdou pasha", "elgeish", "bab elshaariya", "maspero", "safaa hijazy",
    "kit kat", "sudan", "imbaba", "elbohy", "elqawmia",
    "ring road",
    "rod elfarag corridor",
    "tawfikia",
    "wadi el nile",
    "gamet el dowal",
    "boulak el dakrour",
  ];

  // Station lines (same order as stationNames)
  static const List<int> stationLines = [
    // Line 1 (indices 0-34)
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    // Line 2 (indices 35-49) - note: some are transfer stations
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    // Line 3 (indices 50-77)
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
  ];

  // Adjacency list using indices only (MUCH faster)
  static const List<List<int>> connections = [
    // Line 1 connections (indices 0-34)
    [1], // 0: helwan
    [0, 2], // 1: ain helwan
    [1, 3], // 2: helwan university
    [2, 4], // 3: wadi hof
    [3, 5], // 4: hadayek helwan
    [4, 6], // 5: elmaasara
    [5, 7], // 6: tora elasmant
    [6, 8], // 7: kozzika
    [7, 9], // 8: tora elbalad
    [8, 10], // 9: sakanat elmaadi
    [9, 11], // 10: maadi
    [10, 12], // 11: hadayek elmaadi
    [11, 13], // 12: dar elsalam
    [12, 14], // 13: elzahraa
    [13, 15], // 14: mar girgis
    [14, 16], // 15: elmalek elsaleh
    [15, 17], // 16: alsayeda zeinab
    [16, 18], // 17: saad zaghloul
    [17, 19, 43, 44], // 18: sadat (TRANSFER: Line 1->2)
    [18, 20, 42, 68], // 19: gamal abdel nasser (TRANSFER: Line 1->3)
    [19, 21], // 20: orabi
    [20, 22, 41, 42], // 21: alshohadaa (TRANSFER: Line 1->2)
    [21, 23], // 22: ghamra
    [22, 24], // 23: eldemerdash
    [23, 25], // 24: manshiet elsadr
    [24, 26], // 25: kobri elqobba
    [25, 27], // 26: hammamat elqobba
    [26, 28], // 27: saray elqobba
    [27, 29], // 28: hadayek elzaitoun
    [28, 30], // 29: helmeyet elzaitoun
    [29, 31], // 30: elmatareyya
    [30, 32], // 31: ain shams
    [31, 33], // 32: ezbet elnakhl
    [32, 34], // 33: elmarg
    [33], // 34: new elmarg
    // Line 2 connections (indices 35-49)
    [36], // 35: shubra elkheima
    [35, 37], // 36: kolleyyet elzeraa
    [36, 38], // 37: mezallat
    [37, 39], // 38: khalafawy
    [38, 40], // 39: st. teresa
    [39, 41], // 40: rod elfarag
    [40, 21], // 41: masarra (connects to alshohadaa)
    [21, 43, 67, 19], // 42: attaba (TRANSFER: Line 2->3)
    [42, 18], // 43: mohamed naguib (connects to sadat)
    [18, 45], // 44: opera (connects to sadat)
    [44, 46], // 45: dokki
    [45, 47], // 46: el bohoth
    [46, 48, 78], // 47: cairo university (TRANSFER: Line 2->3)
    [47, 49], // 48: faisal
    [48, 50], // 49: giza (Note: adjusted index)
    [49, 51], // 50: omm elmasryeen (Note: adjusted index)
    [50, 52], // 51: sakiat mekky (Note: adjusted index)
    [51], // 52: elmounib (Note: adjusted index)
    // Line 3 connections (indices 50-77) - ADJUSTED INDICES
    [54], // 53: adly mansour (was 50, now 53)
    [53, 55], // 54: elhaykestep
    [54, 56], // 55: omar ibn elkhattab
    [55, 57], // 56: qubaa
    [56, 58], // 57: hesham barakat
    [57, 59], // 58: elnozha
    [58, 60], // 59: el shams club
    [59, 61], // 60: alf masken
    [60, 62], // 61: heliopolis
    [61, 63], // 62: haroun
    [62, 64], // 63: alahram
    [63, 65], // 64: koleyet elbanat
    [64, 66], // 65: stadium
    [65, 67], // 66: fair zone
    [66, 68], // 67: abbassiya
    [67, 69], // 68: abdou pasha
    [68, 70], // 69: elgeish
    [69, 42], // 70: bab elshaariya (connects to attaba)
    [19, 71], // 71: maspero (connects to gamal abdel nasser) - ADJUSTED
    [71, 72], // 72: safaa hijazy - ADJUSTED
    [72, 73, 79], // 73: kit kat (branch point) - ADJUSTED
    [73, 74], // 74: sudan - ADJUSTED
    [74, 75], // 75: imbaba - ADJUSTED
    [75, 76], // 76: elbohy - ADJUSTED
    [76, 77], // 77: elqawmia - ADJUSTED
    [77, 78], // 78: ring road - ADJUSTED
    [78], // 79: rod elfarag corridor - ADJUSTED
    [73, 80], // 80: tawfikia (branch from kit kat) - ADJUSTED
    [80, 81], // 81: wadi el nile - ADJUSTED
    [81, 82], // 82: gamet el dowal - ADJUSTED
    [82, 47], // 83: boulak el dakrour (connects to cairo university) - ADJUSTED
  ];

  // Quick lookups (much faster than Map lookups)
  static int getStationIndex(String stationName) {
    // Simple linear search - still faster than Map with string keys for small arrays
    for (int i = 0; i < stationNames.length; i++) {
      if (stationNames[i] == stationName) return i;
    }
    return -1;
  }

  static String getStationName(int index) {
    return index >= 0 && index < stationNames.length ? stationNames[index] : '';
  }

  static int getStationLine(int index) {
    return index >= 0 && index < stationLines.length ? stationLines[index] : 0;
  }

  static List<int> getConnections(int stationIndex) {
    return stationIndex >= 0 && stationIndex < connections.length
        ? connections[stationIndex]
        : [];
  }

  // Get all stations for dropdown (return indices for even faster processing)
  static List<int> getAllStationIndices() {
    return List.generate(stationNames.length, (index) => index);
  }

  static List<String> getAllStationNames() {
    return List.from(stationNames);
  }
}

// Ultra-fast PathFinder using only integer operations
class UltraFastPathFinder {
  int count = 0;
  int time = 0;
  int ticket = 0;
  List<List<int>> allPaths =
      []; // Store as indices, convert to names only when needed

  void findPaths(int startIndex, int endIndex) {
    allPaths.clear();

    if (startIndex < 0 ||
        endIndex < 0 ||
        startIndex >= UltraLightMetro.stationNames.length ||
        endIndex >= UltraLightMetro.stationNames.length) {
      return;
    }

    if (startIndex == endIndex) {
      allPaths.add([startIndex]);
      count = 0;
      time = 0;
      ticket = 8;
      return;
    }

    Queue<List<int>> queue = Queue<List<int>>();
    List<List<int>> foundPaths = [];

    queue.add([startIndex]);

    while (queue.isNotEmpty) {
      List<int> path = queue.removeFirst();
      int currentStation = path.last;

      if (currentStation == endIndex) {
        foundPaths.add(List.from(path));
        continue;
      }

      if (path.length >= 50) continue; // Prevent infinite loops

      List<int> neighbors = UltraLightMetro.getConnections(currentStation);

      for (int neighborIndex in neighbors) {
        if (!path.contains(neighborIndex)) {
          List<int> newPath = List.from(path);
          newPath.add(neighborIndex);
          queue.add(newPath);
        }
      }
    }

    foundPaths.sort((a, b) => a.length.compareTo(b.length));

    if (foundPaths.isNotEmpty) {
      List<int> shortestPath = foundPaths[0];
      this.count = shortestPath.length - 1;
      this.time = _calculateTravelTime(shortestPath);
      this.ticket = _calculateTicketPrice(this.count);
    }

    this.allPaths = foundPaths;
  }

  int _calculateTravelTime(List<int> path) {
    if (path.length <= 1) return 0;

    int totalTime = 0;
    int previousLine = UltraLightMetro.getStationLine(path[0]);

    for (int i = 1; i < path.length; i++) {
      int currentLine = UltraLightMetro.getStationLine(path[i]);

      if (previousLine != currentLine) {
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

    List<int> path = allPaths[index];
    if (path.isEmpty) return "Invalid path!";

    if (path.length == 1) {
      String stationName = UltraLightMetro.getStationName(path[0]);
      return "You are already at $stationName!";
    }

    String result = "";
    int startStationIndex = path[0];
    String startStationName = UltraLightMetro.getStationName(startStationIndex);
    int startLine = UltraLightMetro.getStationLine(startStationIndex);

    result += "🚇 Start from $startStationName (Line $startLine)\n\n";

    int previousLine = startLine;
    int totalMinutes = 0;
    int lineChanges = 0;

    for (int i = 1; i < path.length; i++) {
      int currentStationIndex = path[i];
      String currentStationName = UltraLightMetro.getStationName(
        currentStationIndex,
      );
      int currentLine = UltraLightMetro.getStationLine(currentStationIndex);

      if (previousLine != currentLine) {
        result +=
            "🔄 Transfer at $currentStationName: Line $previousLine → Line $currentLine\n";
        totalMinutes += 5;
        lineChanges++;
      } else {
        result += "➡️  Continue to $currentStationName (Line $currentLine)\n";
        totalMinutes += 2;
      }

      previousLine = currentLine;
    }

    String finalStationName = UltraLightMetro.getStationName(path.last);
    result += "\n🎯 Arrived at $finalStationName\n\n";
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
      List<int> path = allPaths[i];
      int time = _calculateTravelTime(path);
      summary += "Path ${i + 1}: ${path.length} stations, $time min\n";

      List<String> stationNames = path
          .map((index) => UltraLightMetro.getStationName(index))
          .toList();
      summary += "${stationNames.join(' → ')}\n\n";
    }

    if (allPaths.length > 5) {
      summary += "... and ${allPaths.length - 5} more paths";
    }

    return summary;
  }
}
