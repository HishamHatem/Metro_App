import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';
import 'package:metro/ride.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final cont_1 = TextEditingController();
  final cont_2 = TextEditingController();
  var firstStation = ''.obs;
  var secondStation = ''.obs;

  var ride = Ride(firstStation: '', secondStation: '');
  var count = 0.obs;
  var time = 0.obs;
  var ticket = 0.obs;
  var nearestStation = ''.obs;

  var enabled_1 = false.obs;
  var enabled_2 = false.obs;
  var enabled_3 = false.obs;

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
        title: Text('hello for your Metro Guide'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 16,
            children: [
              DropdownMenu<String>(
                controller: cont_1,
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
                  firstStation.value = cont_1.text;
                  enabled_1.value = cont_1.text.isNotEmpty;
                },
              ),

              DropdownMenu<String>(
                controller: cont_2,
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
                  secondStation.value = cont_1.text;
                  enabled_2.value = cont_1.text.isNotEmpty;
                },
              ),

              Obx(() {
                return ElevatedButton(
                  onPressed: (enabled_1.value && enabled_2.value)
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
              Obx(() {
                return Column(
                  children: [
                    Text('Time: ${time}'),
                    Text('Count: ${count}'),
                    Text('Ticket: ${ticket}'),
                    Text('Nearest Station: ${nearestStation}'),
                  ],
                );
              }),
              // Obx(() {  // will show the data
              //   return Column(
              //     children: [
              //       Text('data: ${firstStation.value}'),
              //       Text('data: ${secondStation.value}'),
              //     ],
              //   );
              // }),
              Obx(() {
                return ElevatedButton(
                  onPressed: enabled_3.value
                      ? () {
                          Get.to(() => const SecondPage());
                        }
                      : null,
                  child: Text('more...'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
