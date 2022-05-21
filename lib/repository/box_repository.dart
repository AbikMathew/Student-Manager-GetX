import 'package:hive_flutter/hive_flutter.dart';
import '../model/student_model.dart';

class BoxRepository {
  static const String boxName = "CRUD";
  static openBox() async => await Hive.openBox<StudentModel>(boxName);
  static Box<StudentModel> getBox() => Hive.box<StudentModel>(boxName);
  static closeBox() async => await Hive.box(boxName).close();
}
