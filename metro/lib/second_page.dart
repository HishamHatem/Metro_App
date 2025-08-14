import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ride = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Routes'),
      ),
      body: ListView.builder(
        itemCount: (ride.getCount/2).ceil(),
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Column(
                children: [
                  Text(
                    'Route ${index+1}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        child: Text('${ride.printSinglePath(index, ride.getAllPaths)}'),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
    );
  }
}
