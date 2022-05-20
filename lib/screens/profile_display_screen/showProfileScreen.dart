import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:getx_counter_second/controller/student_controller.dart';

import '../../model/student_model.dart';

class ShowProfileScreen extends StatelessWidget {
  const ShowProfileScreen({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    StudentController controller = Get.find();
    StudentModel student = controller.observableBox.getAt(index);

    return Scaffold(
      appBar: AppBar(title: Text(student.name), centerTitle: true),
      backgroundColor: Colors.grey,
      body: ListView(
        children: [
          Column(
            children: [
              GestureDetector(
                // onTap: () => pickImage(),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    //  color: Colors.blueGrey,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(student.imagePath)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200, width: 200),
              Row(
                children: [const Text('Name'), Text(student.name)],
              ),
              Row(
                children: [
                  const Text('Class'),
                  Text(student.standard),
                  const Text('Age'),
                  Text(student.age.toString())
                ],
              ),
              Row(
                children: [
                  const Text('Phone:'),
                  Text(student.phoneNumber.toString())
                ],
              ),
            ],
          )
        ],
      ),
      // appBar: ,
    );
  }
}
