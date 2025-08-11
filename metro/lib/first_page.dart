import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro/second_page.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final cont_1 = TextEditingController();
  final cont_2 = TextEditingController();
  var firstStation = ''.obs;
  var secondStation = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: cont_1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter First Station',
              ),
            ),
            TextField(
              controller: cont_2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Second Station',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //time
                //count
                //ticket
                //nearest station
                //calculation

                //take inputs from user
                // firstStation.value = cont_1.text;
                // secondStation.value = cont_2.text;
              },
              child: Text('show'),
            ),
            // Obx(() {  // will show the data
            //   return Column(
            //     children: [
            //       Text('data: ${firstStation.value}'),
            //       Text('data: ${secondStation.value}'),
            //     ],
            //   );
            // }),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const SecondPage());
              },
              child: Text('more...'),
            ),
          ],
        ),
      ),
    );
  }
}
