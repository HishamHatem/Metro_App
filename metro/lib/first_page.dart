import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';
import 'package:metro/ride.dart';
import 'package:geolocator/geolocator.dart';

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

  // List<List<String>> paths = [['a','b'],['c','d'],['e','f'],['g','h']];

  var count = 0.obs;

  var time = 0.obs;

  var ticket = 0.obs;

  var nearestStation = ''.obs;

  var showButtonEnable1 = false.obs;

  var showButtonEnable2 = false.obs;

  var enabled_3 = false.obs;

  var enabled_4 = false.obs;

  // final station = <Stations> [];
  final stationNames = [
    "helwan",
    "ain helwan",
    "helwan university",
    "wadi hof",
    "hadayek helwan",
    "elmaasara",
    "tora elasmant",
    "kozzika",
    "tora elbalad",
    "sakanat elmaadi",
    "maadi",
    "hadayek elmaadi",
    "dar elsalam",
    "elzahraa",
    "mar girgis",
    "elmalek elsaleh",
    "alsayeda zeinab",
    "saad zaghloul",
    "sadat",
    "gamal abdel nasser",
    "orabi",
    "alshohadaa",
    "ghamra",
    "eldemerdash",
    "manshiet elsadr",
    "kobri elqobba",
    "hammamat elqobba",
    "saray elqobba",
    "hadayek elzaitoun",
    "helmeyet elzaitoun",
    "elmatareyya",
    "ain shams",
    "ezbet elnakhl",
    "elmarg",
    "new elmarg",
    "shubra elkheima",
    "kolleyyet elzeraa",
    "mezallat",
    "khalafawy",
    "st. teresa",
    "rod elfarag",
    "masarra",
    "attaba",
    "mohamed naguib",
    "opera",
    "dokki",
    "el bohoth",
    "cairo university",
    "faisal",
    "giza",
    "omm elmasryeen",
    "sakiat mekky",
    "elmounib",
    "adly mansour",
    "elhaykestep",
    "omar ibn elkhattab",
    "qubaa",
    "hesham barakat",
    "elnozha",
    "el shams club",
    "alf masken",
    "heliopolis",
    "haroun",
    "alahram",
    "koleyet elbanat",
    "stadium",
    "fair zone",
    "abbassiya",
    "abdou pasha",
    "elgeish",
    "bab elshaariya",
    "maspero",
    "safaa hijazy",
    "kit kat",
    "sudan",
    "imbaba",
    "elbohy",
    "elqawmia",
    "ring road",
    "rod elfarag corridor",
    "tawfikia",
    "wadi el nile",
    "gamet el dowal",
    "boulak el dakrour",
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    startStationController.dispose(); // Dispose the start station controller
    endStationController.dispose(); // Dispose the end station controller
    destinationController.dispose(); // Dispose the destination controller
    super.dispose();
  }

  // Don't forget to add Dispose function to clean up the controllers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Metro Guide'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            // use ListTile for each DropdownMenu
            DropdownMenu<String>(
              controller: startStationController,
              hintText: 'please select first station',
              width: double.infinity,
              enableSearch: true,
              enableFilter: true,
              requestFocusOnTap: true,
              dropdownMenuEntries: [
                for (var station in stationNames)
                  DropdownMenuEntry(value: station, label: station),
              ],
              onSelected: (String? text) {
                firstStation.value = startStationController.text;
                showButtonEnable1.value =
                    startStationController.text.isNotEmpty;
              },
            ),

            DropdownMenu<String>(
              controller: endStationController,
              hintText: 'please select second station',
              width: double.infinity,
              enableSearch: true,
              enableFilter: true,
              requestFocusOnTap: true,
              dropdownMenuEntries: [
                for (var station in stationNames)
                  DropdownMenuEntry(value: station, label: station),
              ],
              onSelected: (String? text) {
                secondStation.value = startStationController.text;
                showButtonEnable2.value =
                    startStationController.text.isNotEmpty;
              },
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

                            time.value =
                                11; // Example time, replace with actual logic
                            count.value =
                                2; // Example count, replace with actual logic
                            ticket.value =
                                5; // Example ticket price, replace with actual logic
                            nearestStation.value =
                                'helwan'; // Example nearest station, replace with actual logic
                            // this is the right code but after implementing the data of all stations

                            // var paths = ride.findPaths(
                            //   ride.getListOfNamesAndLines,
                            //   firstStation.value,
                            //   secondStation.value,
                            // );
                            // if (paths.isNotEmpty) {
                            //   time.value = ride.getTime;
                            //   count.value = ride.getCount;
                            //   ticket.value = ride.getTicket;
                            //   // in the near station u must check if it's really near to user or not by location
                            //   //it's not just the first station in the path
                            //   //and the check will happen here not in the Ride class
                            //   nearestStation.value = ride.getNearestStation;
                            // } else {
                            //   Get.snackbar(
                            //     'Error',
                            //     'No path found between ${firstStation.value} and ${secondStation.value}',
                            //     snackPosition: SnackPosition.BOTTOM,
                            //   );
                            // }
                          }
                        : null,
                    child: Text('show'),
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    // will change the first drop down to the nearest station to the user
                    findNearStation();
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Time: ${time}\n'
                              'Count: ${count}\n'
                              'Ticket: ${ticket}\n'
                              'Nearest Station: ${nearestStation}',
                            ),
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

            // Row(
            //   children: [
            //     Container(
            //       width: ,
            //       child: TextField(
            //         controller: destinationController,
            //         decoration: InputDecoration(
            //           labelText: 'Enter your Destination',
            //           border: OutlineInputBorder(),
            //         ),
            //         onChanged: (String? x) {
            //           enabled_4.value = x != null && x.isNotEmpty;
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // Obx(() {
            //   return ElevatedButton(
            //     onPressed: enabled_4.value
            //         ? () {
            //       // find the nearest station to the destination using geocoding
            //     }
            //         : null,
            //     child: Text('Show'),
            //   );
            // }),
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
                              }
                            : null,
                        child: Text('Show'),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Obx(() {  // will show the data
            //   return Column(
            //     children: [
            //       Text('data: ${firstStation.value}'),
            //       Text('data: ${secondStation.value}'),
            //     ],
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String> findNearStation() async {
    //1- get current location
    final pos = await Geolocator.getCurrentPosition();
    //2- loop on all station and find the min distance
    double minDistance = double.infinity;
    double dis = 0.0;
    String nearestStation = '';
    for (var station in stationNames) {
      //find min distance with function
      final locations = await locationFromAddress(station);
      if (locations.isNotEmpty) {
        dis = Geolocator.distanceBetween(
          pos.latitude,
          pos.longitude,
          // You need to replace these with actual coordinates of the stations
          // For example, you can use a map or a database to get the coordinates
          locations.first.latitude, // Replace with station latitude
          locations.first.longitude, // Replace with station longitude
        );
      }
      if (dis < minDistance) {
        minDistance = dis;
        nearestStation = station;
      }
      // final places = await placemarkFromCoordinates(latitude, longitude);
      //nearestStation = places.first.name;
    }
    startStationController.text = nearestStation;
    print(nearestStation);
    return nearestStation;
  }
}
