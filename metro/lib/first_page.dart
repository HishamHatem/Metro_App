import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';
import 'package:metro/stations.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final cont_1 = TextEditingController();
  final cont_2 = TextEditingController();
  var firstStation = ''.obs;
  var secondStation = ''.obs;
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
                          //time
                          //count
                          //ticket
                          //nearest station
                          //calculation

                          //take inputs from user
                          // firstStation.value = cont_1.text;
                          // secondStation.value = cont_2.text;
                        }
                      : null,
                  child: Text('show'),
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
