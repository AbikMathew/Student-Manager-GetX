import 'package:get/get.dart';
import 'package:getx_counter_second/model/student_model.dart';
import 'package:getx_counter_second/repository/box_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentController extends GetxController {
  final Box _observableBox = BoxRepository.getBox();
  Box get observableBox => _observableBox; // You saw that this is unwanted find out why dart don't need to use getter and setter just to be safe.

  int get boxCount => _observableBox.length;

  createStudent({required StudentModel student}) { // Find if it's neccessary to add this required here, or simply write StudentModel student
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
}
