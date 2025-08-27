import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';
import 'package:geolocator/geolocator.dart';
import 'metro.dart';
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
  var count = 0.obs;
  var time = 0.obs;
  var ticket = 0.obs;
  var nearestStation = ''.obs;
  var startStationEnable = false.obs;
  var endStationEnable = false.obs;
  var isRouteCalculated = false.obs;
  var isDestinationEntered = false.obs;
  var isDarkMode = false.obs;
  final metro_station = UltraLightMetro.getAllStationNames();
  final finder = UltraFastPathFinder();

  List<List<int>> paths = [];
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
                  Obx(() {
                    return IconButton(
                      onPressed: () {
                        // Toggle the dark mode
                        isDarkMode.value = !isDarkMode.value;
                        Get.changeThemeMode(
                          isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                      icon: isDarkMode.value
                          ? Icon(
                              Icons.light_mode_outlined,
                              color: Colors.orangeAccent,
                            )
                          : Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.deepPurpleAccent,
                            ),
                    );
                  }),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        child: Image.asset(
                          'assets/images/background/metro.png',
                        ),
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
                            child: Obx(() {
                              return DropdownMenu<String>(
                                controller: startStationController,
                                hintText: 'Departure Station',
                                width: double.infinity,
                                enableSearch: true,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                dropdownMenuEntries: [
                                  for (var station in metro_station)
                                    if (station !=
                                        endStation
                                            .value) // Avoid showing the end station in the start station dropdown
                                      DropdownMenuEntry(
                                        value: station,
                                        label: station,
                                      ),
                                ],
                                menuStyle: MenuStyle(
                                  maximumSize: WidgetStateProperty.all<Size>(
                                    Size(300, 400),
                                  ), // width, height
                                ),
                                onSelected: (String? text) {
                                  startStation.value =
                                      startStationController.text;
                                  if (startStation.value != '' &&
                                      metro_station.contains(
                                        startStation.value,
                                      )) {
                                    startStationEnable.value =
                                        startStationController.text.isNotEmpty;
                                  } else {
                                    startStationEnable.value = false;

                                    // Clear the controller and reset the value and wait till this frame finishes rendering
                                    // not using WidgetsBinding here will cause the controller to not clear
                                    // till selecting the invalid text for the second time
                                    // and the value will not reset immediately
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          startStationController.clear();
                                          startStation.value = '';
                                        });
                                    Get.snackbar(
                                      'Error',
                                      'Invalid station selected',
                                    );
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
                                onPressed: startStationEnable.value
                                    ? () {
                                        Station currentStation =
                                            Station.findStationByName(
                                              startStation.value,
                                            );
                                        final url = Uri.parse(
                                          'geo:0,0?q=${currentStation.latitude},${currentStation.longitude}',
                                        );
                                        // Open the URL in the default browser
                                        launchUrl(url);
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.green,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),

                      Obx(() {
                        return AnimatedOpacity(
                          opacity:
                              (startStationEnable.value &&
                                  endStationEnable.value)
                              ? 1.0
                              : 0.4,
                          duration: Duration(milliseconds: 300),
                          child: IconButton(
                            onPressed:
                                (startStationEnable.value &&
                                    endStationEnable.value)
                                ? () {
                                    // Swap the values of the two stations
                                    String temp = startStation.value;
                                    startStation.value = endStation.value;
                                    endStation.value = temp;

                                    // Update the controllers
                                    startStationController.text =
                                        startStation.value;
                                    endStationController.text =
                                        endStation.value;
                                  }
                                : null,
                            icon: Icon(Icons.swap_calls_rounded),
                          ),
                        );
                      }),

                      Row(
                        spacing: 8,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Obx(() {
                              return DropdownMenu<String>(
                                controller: endStationController,
                                hintText: 'Arrival Station',
                                width: double.infinity,
                                enableSearch: true,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                dropdownMenuEntries: [
                                  for (var station in metro_station)
                                    if (station !=
                                        startStation
                                            .value) // Avoid showing the start station in the end station dropdown
                                      DropdownMenuEntry(
                                        value: station,
                                        label: station,
                                      ),
                                ],
                                menuStyle: MenuStyle(
                                  maximumSize: WidgetStateProperty.all<Size>(
                                    Size(300, 400),
                                  ), // width, height
                                ),
                                onSelected: (String? text) {
                                  endStation.value = endStationController.text;
                                  if (endStation.value != '' &&
                                      metro_station.contains(
                                        endStation.value,
                                      )) {
                                    endStationEnable.value =
                                        endStationController.text.isNotEmpty;
                                  } else {
                                    endStationEnable.value = false;

                                    // Clear the controller and reset the value and wait till this frame finishes rendering
                                    // not using WidgetsBinding here will cause the controller to not clear
                                    // till selecting the invalid text for the second time
                                    // and the value will not reset immediately
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          endStationController.clear();
                                          endStation.value = '';
                                        });
                                    Get.snackbar(
                                      'Error',
                                      'Invalid station selected',
                                    );
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
                                onPressed: endStationEnable.value
                                    ? () {
                                        Station currentStation =
                                            Station.findStationByName(
                                              endStation.value,
                                            );
                                        final url = Uri.parse(
                                          'geo:0,0?q=${currentStation.latitude},${currentStation.longitude}',
                                        );
                                        // Open the URL in the default browser
                                        launchUrl(url);
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.green,
                                ),
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
                              opacity:
                                  (startStationEnable.value &&
                                      endStationEnable.value)
                                  ? 1.0
                                  : 0.4,
                              duration: Duration(milliseconds: 300),
                              child: ElevatedButton(
                                onPressed:
                                    (startStationEnable.value &&
                                        endStationEnable.value)
                                    ? () {
                                        isRouteCalculated.value = true;
                                        // ride = Ride(
                                        //   firstStation: startStation.value,
                                        //   secondStation: endStation.value,
                                        // );
                                        //
                                        // ride.findPaths(
                                        //   startStation.value,
                                        //   endStation.value,
                                        //   graphs,
                                        // );
                                        //
                                        finder.findPaths(
                                          UltraLightMetro.getStationIndex(
                                            startStation.value,
                                          ),
                                          UltraLightMetro.getStationIndex(
                                            endStation.value,
                                          ),
                                        );
                                        paths = finder.allPaths;
                                        time.value = finder.time;
                                        count.value = finder.count;
                                        ticket.value = finder.ticket;
                                        print(
                                          '${time.value}, ${count.value}, ${ticket.value}',
                                        );
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
                                            arguments: {
                                              'paths': paths,
                                              'finder': finder,
                                            },
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
                                  isDestinationEntered.value =
                                      x != null && x.isNotEmpty;
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
                                          findDestination(
                                            destinationController.text,
                                          );
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
