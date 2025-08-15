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
  var firstStation = ''.obs;
  var secondStation = ''.obs;
  var ride = Ride(firstStation: '', secondStation: '');
  var count = 0.obs;
  var time = 0.obs;
  var ticket = 0.obs;
  var nearestStation = ''.obs;
  var showButtonEnable1 = false.obs;
  var showButtonEnable2 = false.obs;
  var enabled_3 = false.obs;
  var enabled_4 = false.obs;
  var map_enabled_1 = false.obs;
  var map_enabled_2 = false.obs;

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 16,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/background/metro.png'),
              ),
              Text(
                'Metro Guide',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // use ListTile for each DropdownMenu
              ListTile(
                title: Row(
                  spacing: 8,
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownMenu<String>(
                        controller: startStationController,
                        hintText: 'please select first station',
                        width: double.infinity,
                        enableSearch: true,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        dropdownMenuEntries: [
                          for (var station in graphs.keys)
                            DropdownMenuEntry(value: station, label: station),
                        ],
                        menuStyle: MenuStyle(
                          maximumSize: MaterialStateProperty.all<Size>(
                            Size(300, 400),
                          ), // width, height
                        ),
                        onSelected: (String? text) {
                          firstStation.value = startStationController.text;
                          showButtonEnable1.value =
                              startStationController.text.isNotEmpty;
                          map_enabled_1.value = true;
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: map_enabled_1.value
                              ? () {
                                  Station currentStation =
                                      Station.findStationByName(
                                        firstStation.value,
                                      );
                                  final url = Uri.parse(
                                    'geo:0,0?q=${currentStation.latitude},${currentStation.longitude}',
                                  );
                                  // Open the URL in the default browser
                                  launchUrl(url);
                                }
                              : null,
                          child: Text('On Map'),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              ListTile(
                title: Row(
                  spacing: 8,
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownMenu<String>(
                        controller: endStationController,
                        hintText: 'please select second station',
                        width: double.infinity,
                        enableSearch: true,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        dropdownMenuEntries: [
                          for (var station in graphs.keys)
                            DropdownMenuEntry(value: station, label: station),
                        ],
                        menuStyle: MenuStyle(
                          maximumSize: MaterialStateProperty.all<Size>(
                            Size(300, 400),
                          ), // width, height
                        ),
                        onSelected: (String? text) {
                          secondStation.value = endStationController.text;
                          showButtonEnable2.value =
                              endStationController.text.isNotEmpty;
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: map_enabled_2.value
                              ? () {
                                  Station currentStation =
                                      Station.findStationByName(
                                        secondStation.value,
                                      );
                                  final url = Uri.parse(
                                    'geo:0,0?q=${currentStation.latitude},${currentStation.longitude}',
                                  );
                                  // Open the URL in the default browser
                                  launchUrl(url);
                                }
                              : null,
                          child: Text('On Map'),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                    return ElevatedButton(
                      onPressed:
                          (showButtonEnable1.value && showButtonEnable2.value)
                          ? () {
                              enabled_3.value = true;
                              ride = Ride(
                                firstStation: firstStation.value,
                                secondStation: secondStation.value,
                              );

                              ride.findPaths(
                                firstStation.value,
                                secondStation.value,
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
                      child: Text('show'),
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
                              'Time: ${time}\n'
                              'Count: ${count}\n'
                              'Ticket: ${ticket}\n'
                              'Nearest Station: ${nearestStation}',
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(() {
                      return ElevatedButton(
                        onPressed: enabled_3.value
                            ? () {
                                Get.to(
                                  SecondPage(),
                                  arguments: ride,
                                  transition: Transition.rightToLeft,
                                );
                              }
                            : null,
                        child: Row(
                          spacing: 8,
                          children: [
                            Text('more'),
                            Icon(Icons.arrow_circle_right_outlined),
                          ],
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
                          enabled_4.value = x != null && x.isNotEmpty;
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 1, // takes 1 part of the space
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: enabled_4.value
                              ? () {
                                  // find the nearest station
                                  findDestination(destinationController.text);
                                }
                              : null,
                          child: Text('Show'),
                        );
                      }),
                    ),
                  ],
                ),
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
      firstStation.value = nearestStation;
      showButtonEnable1.value = true;
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
    secondStation.value = nearestStation;
    showButtonEnable2.value = endStationController.text.isNotEmpty;
  }
}
