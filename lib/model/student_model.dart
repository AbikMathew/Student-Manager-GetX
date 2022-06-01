
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject{
  StudentModel(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.standard,
      required this.imagePath,
      this.imageList});

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

  @HiveField(7)
  List<String>? imageList = [];

  //  @override
  // List<Object> get props => [name, age, phoneNumber, standard, imagePath];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModel &&
          runtimeType == other.runtimeType &&
          name == other.name;
  @override
  int get hashCode => name.hashCode;
}
