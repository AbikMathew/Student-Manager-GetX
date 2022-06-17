import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_second/model/student_model.dart';
import 'package:getx_counter_second/repository/box_repository.dart';
import 'package:getx_counter_second/screens/profile_display_screen/showProfileScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class StudentController extends GetxController {
  final Box<StudentModel> _observableBox = BoxRepository.getBox();
  Box<StudentModel> get observableBox =>
      _observableBox; // You saw that this is unwanted find out why dart don't need to use getter and setter just to be safe.

  int get boxCount => _observableBox.length;
  Rx<bool> isDescending = false.obs;

  createStudent({required StudentModel student}) {
    // Find if it's neccessary to add this required here, or simply write StudentModel student
    _observableBox.add(student);
    update();
  }

  updateStundent({required int index, required StudentModel student}) {
    _observableBox.putAt(index, student);
    update();
  }

  deleteStundent({required int index}) {
    _observableBox.deleteAt(index);
    update();
  }

  deleteStundentKey({required int key}) {
    _observableBox.delete(key);
    update();
  }

  searchStudent(context) {
    showSearch(context: context, delegate: MySearch());
  }

  changeOrder() {
    isDescending.value ? isDescending = false.obs : isDescending = true.obs;
    update();
  }
}

class MySearch extends SearchDelegate {
  StudentController controller = Get.find<StudentController>();

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            query.isEmpty ? close(context, null) : query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    List<StudentModel> studentList = controller.observableBox.values.toList();
    // onlyy    movieNameLister();

    for (int i = 0; i < studentList.length; i++) {
      if (studentList[i].name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(studentList[i].name);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(matchQuery[index]),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<StudentModel> studentList = controller.observableBox.values.toList();
    // onlyy    movieNameLister();

    for (int i = 0; i < studentList.length; i++) {
      if (studentList[i].name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(studentList[i].name);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(matchQuery[index]),
            onTap: () {
              query = studentList[index].name;
              showResults(context);
              Get.to(ShowProfileScreen(
                  index: index,
                  name: studentList[index].name,
                  age: studentList[index].age,
                  standard: studentList[index].standard,
                  phone: studentList[index].phoneNumber,
                  imagePath: studentList[index].imagePath));
            },
          );
        });
  }
}
