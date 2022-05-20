
import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  StudentModel({required this.name, required this.age, required this.phoneNumber, required this.standard, required this.imagePath});

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(3)
  int phoneNumber;

  @HiveField(4)
  String standard;

  @HiveField(5)
  String imagePath;

}