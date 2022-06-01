import 'package:get/get.dart';
import 'package:getx_counter_second/model/student_model.dart';
import 'package:getx_counter_second/repository/box_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class StudentController extends GetxController {
  final Box<StudentModel> _observableBox = BoxRepository.getBox();
  Box<StudentModel> get observableBox =>
      _observableBox; // You saw that this is unwanted find out why dart don't need to use getter and setter just to be safe.

  int get boxCount => _observableBox.length;

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

  // addImageList({required int index, required List<String> imageList}) {
  //   //_observableBox.At(index)!.imageList?.addAll(imageList);
  //   _observableBox.getAt(index)!.imageList?.addAll(imageList);
  //   update();
  //   print('Ith vanooooo index $index');
  //   print(_observableBox.getAt(index)!.imageList);
  //   print(_observableBox.getAt(index)!.age);

  // }

  Rx<bool> isDescending = false.obs;
}
