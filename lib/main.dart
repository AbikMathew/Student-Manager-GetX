import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_second/model/student_model.dart';
import 'package:getx_counter_second/repository/box_repository.dart';
import 'package:getx_counter_second/screens/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  await BoxRepository.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
    );
      
  }
}
