import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_second/constants/constants.dart';
import 'package:getx_counter_second/controller/student_controller.dart';
//import 'package:getx_counter_second/controller/student_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/student_model.dart';

class ShowProfileScreen extends StatefulWidget {
  const ShowProfileScreen(
      {Key? key,
      required this.index,
      required this.name,
      required this.age,
      required this.standard,
      required this.phone,
      required this.imagePath})
      : super(key: key);

  final int index;
  final String name;
  final int age;
  final String standard;
  final int phone;
  final String imagePath;

  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  // final int index;
  // final List<XFile> imageList = [];
  //final controller = Get.find();
  final controller = Get.put(StudentController());

  List<String> imgFilePath = [];

  void selectImages(StudentModel student) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      for (var i = 0; i < selectedImages.length; i++) {
        selectedImages[i];
        File file = File(selectedImages[i].path);
        imgFilePath.add(file.path);
      }
      //  imageList.addAll(selectedImages);
      // print('Show profile part aaaane, kittio');
      // print(selectedImages.length);
      //controller.addImageList(index: widget.index, imageList: selectedImages);
      controller.updateStundent(
          index: widget.index,
          student: StudentModel(
              name: widget.name,
              age: widget.age,
              phoneNumber: widget.phone,
              standard: widget.standard,
              imagePath: widget.imagePath,
              imageList: imgFilePath));
      //  student.imageList.add(selectedImages);

      // controller.updateStundent(index: widget.index, student: student);
    }

    setState(() {});
  }

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // StudentController controller = Get.find();
    // StudentModel student = controller.observableBox.getAt(index)!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.name), centerTitle: true),
      backgroundColor: kBGreyBg,
      body: GetBuilder<StudentController>(builder: (ctr) {
        List<StudentModel> studentList =
            controller.observableBox.values.toList();
        StudentModel student = studentList[widget.index];
        List<String>? imgList = student.imageList;

        return ListView(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectImages(student);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(widget.imagePath)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 200, width: 200),
                Row(
                  children: [const Text('Name:'), Text(widget.name)],
                ),
                Row(
                  children: [
                    const Text('Class'),
                    Text(widget.standard),
                    const Text('Age'),
                    Text(widget.age.toString())
                  ],
                ),
                Row(
                  children: [
                    const Text('Phone:'),
                    Text(widget.phone.toString())
                  ],
                ),
              ],
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: imgList?.length ?? 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  if (imgList != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(imgList[index]),
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return Container(
                      height: 100,
                      width: 100,
                      color: kBGrey,
                    );
                  }
                })
          ],
        );
      }),
      // appBar: ,
    );
  }
}
