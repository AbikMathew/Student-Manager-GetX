import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getx_counter_second/constants/constants.dart';

class ShowProfileScreen extends StatelessWidget {
  const ShowProfileScreen(
      {Key? key,
  //    required this.index,
      required this.name,
      required this.age,
      required this.standard,
      required this.phone,
      required this.imagePath})
      : super(key: key);

  final String name;
  final int age;
  final String standard;
  final int phone;
  final String imagePath;
 // final int index;
  @override
  Widget build(BuildContext context) {
    // StudentController controller = Get.find();
    // StudentModel student = controller.observableBox.getAt(index)!;

    return Scaffold(
      appBar: AppBar(title: Text(name), centerTitle: true),
      backgroundColor: kBGreyBg,
      body: ListView(
        children: [
          Column(
            children: [
              GestureDetector(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(imagePath)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200, width: 200),
              Row(
                children: [const Text('Name:'), Text(name)],
              ),
              Row(
                children: [
                  const Text('Class'),
                  Text(standard),
                  const Text('Age'),
                  Text(age.toString())
                ],
              ),
              Row(
                children: [const Text('Phone:'), Text(phone.toString())],
              ),
            ],
          )
        ],
      ),
      // appBar: ,
    );
  }
}
