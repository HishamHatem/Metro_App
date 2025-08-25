import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ride = Get.arguments['paths'];
    final find = Get.arguments['finder'];

    return Scaffold(
      appBar: AppBar(title: Text('All Routes')),
      body: ListView.builder(
        itemCount: ride.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Route ${index + 1}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${find.printSinglePath(index)}'),
              ),
            ],
          );
        },
      ),
    );
  }
}
