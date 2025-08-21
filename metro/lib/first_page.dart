import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';
import 'package:metro/ride.dart';
import 'package:geolocator/geolocator.dart';
import 'station.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final startStationController = TextEditingController();
  final endStationController = TextEditingController();
  final destinationController = TextEditingController();
  var startStation = ''.obs;
  var endStation = ''.obs;
  var ride = Ride(firstStation: '', secondStation: '');
  var count = 0.obs;
  var time = 0.obs;
  var ticket = 0.obs;
  var nearestStation = ''.obs;
  var startStationEnable = false.obs;
  var endStationEnable = false.obs;
  var isRouteCalculated = false.obs;
  var isDestinationEntered = false.obs;
  var isDarkMode = false.obs;

  final graphs = <String, List<String>>{
    "helwan": ["line_1", "ain helwan", "line_1"],
    "ain helwan": ["line_1", "helwan", "line_1", "helwan university", "line_1"],
    "helwan university": [
      "line_1",
      "ain helwan",
      "line_1",
      "wadi hof",
      "line_1",
    ],
    "wadi hof": [
      "line_1",
      "helwan university",
      "line_1",
      "hadayek helwan",
      "line_1",
    ],
    "hadayek helwan": ["line_1", "wadi hof", "line_1", "elmaasara", "line_1"],
    "elmaasara": [
      "line_1",
      "hadayek helwan",
      "line_1",
      "tora elasmant",
      "line_1",
    ],
    "tora elasmant": ["line_1", "elmaasara", "line_1", "kozzika", "line_1"],
    "kozzika": ["line_1", "tora elasmant", "line_1", "tora elbalad", "line_1"],
    "tora elbalad": [
      "line_1",
      "kozzika",
      "line_1",
      "sakanat elmaadi",
      "line_1",
    ],
    "sakanat elmaadi": ["line_1", "tora elbalad", "line_1", "maadi", "line_1"],
    "maadi": [
      "line_1",
      "sakanat elmaadi",
      "line_1",
      "hadayek elmaadi",
      "line_1",
    ],
    "hadayek elmaadi": ["line_1", "maadi", "line_1", "dar elsalam", "line_1"],
    "dar elsalam": [
      "line_1",
      "hadayek elmaadi",
      "line_1",
      "elzahraa",
      "line_1",
    ],
    "elzahraa": ["line_1", "dar elsalam", "line_1", "mar girgis", "line_1"],
    "mar girgis": ["line_1", "elzahraa", "line_1", "elmalek elsaleh", "line_1"],
    "elmalek elsaleh": [
      "line_1",
      "mar girgis",
      "line_1",
      "alsayeda zeinab",
      "line_1",
    ],
    "alsayeda zeinab": [
      "line_1",
      "elmalek elsaleh",
      "line_1",
      "saad zaghloul",
      "line_1",
    ],
    "saad zaghloul": ["line_1", "alsayeda zeinab", "line_1", "sadat", "line_1"],
    "sadat": [
      "line_1", //more than line unhandeled
      "saad zaghloul",
      "line_1",
      "gamal abdel nasser",
      "line_1",
      "mohamed naguib",
      "line_2",
      "opera",
      "line_2",
    ],
    "gamal abdel nasser": [
      "line_1", //more than line unhandeled
      "sadat",
      "line_1",
      "orabi",
      "line_1",
      "attaba",
      "line_3",
      "maspero",
      "line_3",
    ],
    "orabi": ["line_1", "gamal abdel nasser", "line_1", "alshohadaa", "line_1"],
    "alshohadaa": [
      "line_1", //more than line unhandeled
      "orabi",
      "line_1",
      "ghamra",
      "line_1",
      "masarra",
      "line_2",
      "attaba",
      "line_2",
    ],
    "ghamra": ["line_1", "alshohadaa", "line_1", "eldemerdash", "line_1"],
    "eldemerdash": ["line_1", "ghamra", "line_1", "manshiet elsadr", "line_1"],
    "manshiet elsadr": [
      "line_1",
      "eldemerdash",
      "line_1",
      "kobri elqobba",
      "line_1",
    ],
    "kobri elqobba": [
      "line_1",
      "manshiet elsadr",
      "line_1",
      "hammamat elqobba",
      "line_1",
    ],
    "hammamat elqobba": [
      "line_1",
      "kobri elqobba",
      "line_1",
      "saray elqobba",
      "line_1",
    ],
    "saray elqobba": [
      "line_1",
      "hammamat elqobba",
      "line_1",
      "hadayek elzaitoun",
      "line_1",
    ],
    "hadayek elzaitoun": [
      "line_1",
      "saray elqobba",
      "line_1",
      "helmeyet elzaitoun",
      "line_1",
    ],
    "helmeyet elzaitoun": [
      "line_1",
      "hadayek elzaitoun",
      "line_1",
      "elmatareyya",
      "line_1",
    ],
    "elmatareyya": [
      "line_1",
      "helmeyet elzaitoun",
      "line_1",
      "ain shams",
      "line_1",
    ],
    "ain shams": ["line_1", "elmatareyya", "line_1", "ezbet elnakhl", "line_1"],
    "ezbet elnakhl": ["line_1", "ain shams", "line_1", "elmarg", "line_1"],
    "elmarg": ["line_1", "ezbet elnakhl", "line_1", "new elmarg", "line_1"],
    "new elmarg": ["line_1", "elmarg", "line_1"],
    "shubra elkheima": ["line_2", "kolleyyet elzeraa", "line_2"],
    "kolleyyet elzeraa": [
      "line_2",
      "shubra elkheima",
      "line_2",
      "mezallat",
      "line_2",
    ],
    "mezallat": [
      "line_2",
      "kolleyyet elzeraa",
      "line_2",
      "khalafawy",
      "line_2",
    ],
    "khalafawy": ["line_2", "mezallat", "line_2", "st. teresa", "line_2"],
    "st. teresa": ["line_2", "khalafawy", "line_2", "rod elfarag", "line_2"],
    "rod elfarag": ["line_2", "st. teresa", "line_2", "masarra", "line_2"],
    "masarra": ["line_2", "rod elfarag", "line_2", "alshohadaa", "line_2"],
    "attaba": [
      "line_2", //more than line unhandeled
      "alshohadaa",
      "line_2",
      "mohamed naguib",
      "line_2",
      "bab elshaariya",
      "line_3",
      "gamal abdel nasser",
      "line_3",
    ],
    "mohamed naguib": ["line_2", "attaba", "line_2", "sadat", "line_2"],
    "opera": ["line_2", "sadat", "line_2", "dokki", "line_2"],
    "dokki": ["line_2", "opera", "line_2", "el bohoth", "line_2"],
    "el bohoth": ["line_2", "dokki", "line_2", "cairo university", "line_2"],
    "cairo university": [
      "line_2",
      "el bohoth",
      "line_2",
      "faisal",
      "line_2",
      "boulak el dakrour",
      "line_3",
    ],
    "faisal": ["line_2", "cairo university", "line_2", "giza", "line_2"],
    "giza": ["line_2", "faisal", "line_2", "omm elmasryeen", "line_2"],
    "omm elmasryeen": ["line_2", "giza", "line_2", "sakiat mekky", "line_2"],
    "sakiat mekky": [
      "line_2",
      "omm elmasryeen",
      "line_2",
      "elmounib",
      "line_2",
    ],
    "elmounib": ["line_2", "sakiat mekky", "line_2"],
    "adly mansour": ["line_3", "elhaykestep", "line_3"],
    "elhaykestep": [
      "line_3",
      "adly mansour",
      "line_3",
      "omar ibn elkhattab",
      "line_3",
    ],
    "omar ibn elkhattab": [
      "line_3",
      "elhaykestep",
      "line_3",
      "qubaa",
      "line_3",
    ],
    "qubaa": [
      "line_3",
      "omar ibn elkhattab",
      "line_3",
      "hesham barakat",
      "line_3",
    ],
    "hesham barakat": ["line_3", "qubaa", "line_3", "elnozha", "line_3"],
    "elnozha": [
      "line_3",
      "hesham barakat",
      "line_3",
      "el shams club",
      "line_3",
    ],
    "el shams club": ["line_3", "elnozha", "line_3", "alf masken", "line_3"],
    "alf masken": ["line_3", "el shams club", "line_3", "heliopolis", "line_3"],
    "heliopolis": ["line_3", "alf masken", "line_3", "haroun", "line_3"],
    "haroun": ["line_3", "heliopolis", "line_3", "alahram", "line_3"],
    "alahram": ["line_3", "haroun", "line_3", "koleyet elbanat", "line_3"],
    "koleyet elbanat": ["line_3", "alahram", "line_3", "stadium", "line_3"],
    "stadium": ["line_3", "koleyet elbanat", "line_3", "fair zone", "line_3"],
    "fair zone": ["line_3", "stadium", "line_3", "abbassiya", "line_3"],
    "abbassiya": ["line_3", "fair zone", "line_3", "abdou pasha", "line_3"],
    "abdou pasha": ["line_3", "abbassiya", "line_3", "elgeish", "line_3"],
    "elgeish": ["line_3", "abdou pasha", "line_3", "bab elshaariya", "line_3"],
    "bab elshaariya": ["line_3", "elgeish", "line_3", "attaba", "line_3"],
    "maspero": [
      "line_3",
      "gamal abdel nasser",
      "line_3",
      "safaa hijazy",
      "line_3",
    ],
    "safaa hijazy": ["line_3", "maspero", "line_3", "kit kat", "line_3"],
    "kit kat": [
      "line_3",
      "safaa hijazy",
      "line_3",
      "sudan",
      "line_3",
      "tawfikia",
      "line_3",
    ],
    "sudan": ["line_3", "kit kat", "line_3", "imbaba", "line_3"],
    "imbaba": ["line_3", "sudan", "line_3", "elbohy", "line_3"],
    "elbohy": ["line_3", "imbaba", "line_3", "elqawmia", "line_3"],
    "elqawmia": ["line_3", "elbohy", "line_3", "ring road", "line_3"],
    "ring road": [
      "line_3",
      "elqawmia",
      "line_3",
      "rod elfarag corridor",
      "line_3",
    ],
    "rod elfarag corridor": ["line_3", "ring road", "line_3"],
    "tawfikia": ["line_3", "kit kat", "line_3", "wadi el nile", "line_3"],
    "wadi el nile": [
      "line_3",
      "tawfikia",
      "line_3",
      "gamet el dowal",
      "line_3",
    ],
    "gamet el dowal": [
      "line_3",
      "wadi el nile",
      "line_3",
      "boulak el dakrour",
      "line_3",
    ],
    "boulak el dakrour": [
      "line_3",
      "gamet el dowal",
      "line_3",
      "cairo university",
      "line_3",
    ],
  };
  List<List<String>> paths = [];

  @override
  void dispose() {
    // TODO: implement dispose
    startStationController.dispose(); // Dispose the start station controller
    endStationController.dispose(); // Dispose the end station controller
    destinationController.dispose(); // Dispose the destination controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 16,
            children: [
              Row(
                children: [
                  Obx((){
                    return IconButton(
                      onPressed: () {
                        // Toggle the dark mode
                        isDarkMode.value = !isDarkMode.value;
                        Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
                      },
                      icon: isDarkMode.value ?
                      Icon(
                        Icons.light_mode_outlined,
                        color: Colors.orangeAccent,
                      ) :
                      Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                    );
                  }),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        child: Image.asset('assets/images/background/metro.png'),
                      ),
                    ),
                  ),
                  // Add an invisible IconButton for symmetry (optional)
                  SizedBox(width: 48), // Same width as IconButton
                ],
              ),
              Text(
                'Metro Guide',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Obx((){
                              return DropdownMenu<String>(
                                controller: startStationController,
                                hintText: 'Departure Station',
                                width: double.infinity,
                                enableSearch: true,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                dropdownMenuEntries: [
                                  for (var station in graphs.keys)
                                    if(station != endStation.value) // Avoid showing the end station in the start station dropdown
                                      DropdownMenuEntry(value: station, label: station),
                                ],
                                menuStyle: MenuStyle(
                                  maximumSize: WidgetStateProperty.all<Size>(
                                    Size(300, 400),
                                  ), // width, height
                                ),
                                onSelected: (String? text) {
                                  startStation.value = startStationController.text;
                                  if(startStation.value != '' && graphs.containsKey(startStation.value)) {
                                    startStationEnable.value = startStationController.text.isNotEmpty;
                                  } else {
                                    startStationEnable.value = false;

                                    // Clear the controller and reset the value and wait till this frame finishes rendering
                                    // not using WidgetsBinding here will cause the controller to not clear
                                    // till selecting the invalid text for the second time
                                    // and the value will not reset immediately
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      startStationController.clear();
                                      startStation.value = '';
                                    });
                                    Get.snackbar('Error', 'Invalid station selected');
                                  }
                                },
                              );
                            }),
                          ),
                          Obx(() {
                            return AnimatedOpacity(
                              opacity: startStationEnable.value ? 1.0 : 0.4,
                              duration: Duration(milliseconds: 300),
                              child: IconButton(
                                  onPressed: startStationEnable.value ? () {
                                    Station currentStation = Station.findStationByName(startStation.value,);
                                    final url = Uri.parse('geo:0,0?q=${currentStation.latitude},${currentStation.longitude}');
                                    // Open the URL in the default browser
                                    launchUrl(url);
                                  } : null,
                                  icon: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.green,
                                  )
                              ),
                            );
                          }),
                        ],
                      ),

                      Obx((){
                        return AnimatedOpacity(
                          opacity: (startStationEnable.value && endStationEnable.value) ? 1.0 : 0.4,
                          duration: Duration(milliseconds: 300),
                          child: IconButton(
                              onPressed: (startStationEnable.value && endStationEnable.value) ? () {
                                // Swap the values of the two stations
                                String temp = startStation.value;
                                startStation.value = endStation.value;
                                endStation.value = temp;

                                // Update the controllers
                                startStationController.text = startStation.value;
                                endStationController.text = endStation.value;
                              } : null,
                              icon: Icon(
                                Icons.swap_calls_rounded,
                              )
                          ),
                        );
                      }),

                      Row(
                        spacing: 8,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Obx((){
                              return DropdownMenu<String>(
                                controller: endStationController,
                                hintText: 'Arrival Station',
                                width: double.infinity,
                                enableSearch: true,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                dropdownMenuEntries: [
                                  for (var station in graphs.keys)
                                    if(station != startStation.value) // Avoid showing the start station in the end station dropdown
                                      DropdownMenuEntry(value: station, label: station),
                                ],
                                menuStyle: MenuStyle(
                                  maximumSize: WidgetStateProperty.all<Size>(
                                    Size(300, 400),
                                  ), // width, height
                                ),
                                onSelected: (String? text) {
                                  endStation.value = endStationController.text;
                                  if(endStation.value != '' && graphs.containsKey(endStation.value)) {
                                    endStationEnable.value = endStationController.text.isNotEmpty;
                                  } else {
                                    endStationEnable.value = false;

                                    // Clear the controller and reset the value and wait till this frame finishes rendering
                                    // not using WidgetsBinding here will cause the controller to not clear
                                    // till selecting the invalid text for the second time
                                    // and the value will not reset immediately
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      endStationController.clear();
                                      endStation.value = '';
                                    });
                                    Get.snackbar('Error', 'Invalid station selected');
                                  }
                                },
                              );
                            }),
                          ),
                          Obx(() {
                            return AnimatedOpacity(
                              opacity: endStationEnable.value ? 1.0 : 0.4,
                              duration: Duration(milliseconds: 300),
                              child: IconButton(
                                  onPressed: endStationEnable.value ? () {
                                    Station currentStation = Station.findStationByName(endStation.value,);
                                    final url = Uri.parse('geo:0,0?q=${currentStation.latitude},${currentStation.longitude}');
                                    // Open the URL in the default browser
                                    launchUrl(url);
                                  } : null,
                                  icon: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.green,
                                  )
                              ),
                            );
                          }),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() {
                            return AnimatedOpacity(
                              opacity: (startStationEnable.value && endStationEnable.value) ? 1.0 : 0.4,
                              duration: Duration(milliseconds: 300),
                              child: ElevatedButton(
                                onPressed:
                                (startStationEnable.value && endStationEnable.value)
                                    ? () {
                                  isRouteCalculated.value = true;
                                  ride = Ride(
                                    firstStation: startStation.value,
                                    secondStation: endStation.value,
                                  );

                                  ride.findPaths(
                                    startStation.value,
                                    endStation.value,
                                    graphs,
                                  );

                                  paths = ride.getAllPaths;
                                  time.value = ride.getTime;
                                  count.value = ride.getCount;
                                  ticket.value = ride.getTicket;
                                  // nearestStation.value = ride.getNearestStation;
                                  findNearStation(false);
                                }
                                    : null,
                                child: Text('Find Route'),
                              ),
                            );
                          }),
                          ElevatedButton(
                            onPressed: () {
                              // will change the first drop down to the nearest station to the user
                              findNearStation(true);
                            },
                            child: Text('Nearest Station'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Shortest Path info\n'
                                      'Time: $time\n'
                                      'Count: $count\n'
                                      'Ticket: $ticket\n'
                                      'Nearest Station: $nearestStation',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          Align(
                            alignment: Alignment.center,
                            child: Obx(() {
                              return AnimatedOpacity(
                                opacity: isRouteCalculated.value ? 1.0 : 0.4,
                                duration: Duration(milliseconds: 300),
                                child: ElevatedButton(
                                  onPressed: isRouteCalculated.value
                                      ? () {
                                    Get.to(
                                      SecondPage(),
                                      arguments: ride,
                                      transition: Transition.rightToLeft,
                                    );
                                  } : null,
                                  child: Row(
                                    spacing: 8,
                                    children: [
                                      Text('more'),
                                      Icon(Icons.arrow_circle_right_outlined),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Row(
                          spacing: 8,
                          children: [
                            Flexible(
                              flex: 1, // takes 2 parts of the available space
                              child: TextField(
                                controller: destinationController,
                                decoration: InputDecoration(
                                  labelText: 'Enter your Destination',
                                ),
                                onChanged: (String? x) {
                                  isDestinationEntered.value = x != null && x.isNotEmpty;
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Obx(() {
                              return AnimatedOpacity(
                                opacity: isDestinationEntered.value ? 1.0 : 0.4,
                                duration: Duration(milliseconds: 300),
                                child: ElevatedButton(
                                  onPressed: isDestinationEntered.value
                                      ? () {
                                    // find the nearest station
                                    findDestination(destinationController.text);
                                  }
                                      : null,
                                  child: Text('Nearest Metro'),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get location permission
  Future<void> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.snackbar('Error', 'Location services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Get.snackbar('Error', 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.snackbar(
        'Error',
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return;
    }
  }

  Future<void> findNearStation(bool edit) async {
    getLocationPermission();
    //1- get current location
    final pos = await Geolocator.getCurrentPosition();
    //2- loop on all station and find the min distance
    double minDistance = double.infinity;
    double distance = 0.0;
    String nearestStation = '';
    for (var station in stationsCoordinates) {
      //find min distance with function
      distance = Geolocator.distanceBetween(
        pos.latitude,
        pos.longitude,
        station.latitude,
        station.longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station.name;
      }
    }
    if (edit) {
      startStationController.text = nearestStation;
      startStation.value = nearestStation;
      startStationEnable.value = true;
    }
    this.nearestStation.value = nearestStation;
  }

  Future<void> findDestination(String Address) async {
    getLocationPermission();

    final locations = await locationFromAddress(Address);

    double minDistance = double.infinity;
    double distance = 0.0;
    String nearestStation = '';
    for (var station in stationsCoordinates) {
      //find min distance with function
      distance = Geolocator.distanceBetween(
        locations.first.latitude,
        locations.first.longitude,
        station.latitude,
        station.longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station.name;
      }
    }
    endStationController.text = nearestStation;
    endStation.value = nearestStation;
    endStationEnable.value = endStationController.text.isNotEmpty;
  }
}
