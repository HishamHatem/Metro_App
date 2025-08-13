import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';
import 'package:metro/ride.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

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

  // final station = <Stations> [];
  // station.add(Stations(name: 'Station A', line: 'Line 1'));
  // All unique station names from Metro lines 1, 2, and 3
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

  // Don't forget to add Dispose function to clean up the controllers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metro Guide'),
        centerTitle: true,
      ),
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
                showButtonEnable1.value = startStationController.text.isNotEmpty;
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
                showButtonEnable2.value = startStationController.text.isNotEmpty;
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  return ElevatedButton(
                    onPressed: (showButtonEnable1.value && showButtonEnable2.value)
                        ? () {
                            enabled_3.value = true;
                            ride = Ride(
                              firstStation: firstStation.value,
                              secondStation: secondStation.value,
                            );

                            time.value = 11; // Example time, replace with actual logic
                            count.value = 2; // Example count, replace with actual logic
                            ticket.value = 5; // Example ticket price, replace with actual logic
                            nearestStation.value = 'helwan'; // Example nearest station, replace with actual logic
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
                            border: Border.all(
                              color: Colors.grey,
                              width: 3,
                            ),
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
                              Get.to(() => const SecondPage());
                            }
                          : null,
                      child: Row(
                        spacing: 8,
                        children: [
                          Text('more'),
                          Icon(Icons.arrow_circle_right_outlined),
                        ],
                      )
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
                children: [
                  Flexible(
                    flex: 2, // takes 2 parts of the available space
                    child: TextField(
                      controller: destinationController,
                      decoration: InputDecoration(
                        labelText: 'Enter your Destination',
                        border: OutlineInputBorder(),
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
            )


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
}
