import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_counter_second/constants/constants.dart';
import 'package:getx_counter_second/controller/student_controller.dart';
import 'package:getx_counter_second/model/student_model.dart';
import 'package:getx_counter_second/screens/profile_display_screen/showProfileScreen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Rx<bool> isDescending = false.obs;
  HashSet<StudentModel> selectedItem = HashSet();

  final controller = Get.put(
      StudentController()); //Controller class: Create, Update, Delete functions

  final image = ''.obs;
  final TextEditingController sNameTEController = TextEditingController();
  final TextEditingController sAgeTEController = TextEditingController();
  final TextEditingController sPhoneTEController = TextEditingController();
  final TextEditingController sStdTEController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    sNameTEController.dispose();
    sAgeTEController.dispose();
    sPhoneTEController.dispose();
    sStdTEController.dispose();
    super.dispose();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      this.image.value = image.path;
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image due to exception $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGreyBg,
      appBar: AppBar(
        title: const Text('Student Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              isDescending.value = true;
            },
          ),
          kWidth,
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () {},
          ),
          kWidth
        ],
      ),
      body: GetBuilder<StudentController>(
        builder: (controllerNotUsed) {
          List<StudentModel> studentList =
              controller.observableBox.values.toList();

          studentList.sort((a, b) => a.name.compareTo(b.name));

          return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                StudentModel student = studentList[index];

                void doMultiselect(StudentModel student) {
                  if (selectedItem.contains(student)) {
                    selectedItem.remove(student);
                  } else {
                    selectedItem.add(student);
                  }
                  setState(() {});
                }

                return studentCard(index, student);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => addEditStudent()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Card studentCard(int index, StudentModel student) {
    return Card(
        child: ListTile(
      tileColor: Colors.blueGrey.shade50,
      //  onLongPress: ,
      onTap: () => Get.to(
        () => ShowProfileScreen(
          //    index: index,
          name: student.name,
          age: student.age,
          standard: student.standard,
          phone: student.phoneNumber,
          imagePath: student.imagePath,
        ),
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage:
            //  FileImage(File(student?.imagePath ?? 'abc.jpg')),
            FileImage(File(student.imagePath)),
      ),
      title:
          // Text(student?.name ?? "n/a"),
          Text(student.name),
      subtitle:
          //Text(student?.standard ?? "n/a"),
          Text(student.standard),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                print('Index issssssss $index');
                controller.deleteStundent(index: index);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () => addEditStudent(index: index, student: student),
              icon: const Icon(Icons.edit)),
        ],
      ),
    ));
  }

  addEditStudent({int? index, StudentModel? student}) {
    showDialog(
      context: context,
      builder: (context) {
        if (student != null) {
          sNameTEController.text = student.name.toString();
          sAgeTEController.text = student.age.toString();
          sPhoneTEController.text = student.phoneNumber.toString();
          sStdTEController.text = student.standard.toString();
          image.value = student.imagePath;
        } else {
          sAgeTEController.clear();
          sNameTEController.clear();
          sPhoneTEController.clear();
          sStdTEController.clear();
          image.value = '';
        }

        return Material(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    kHeight,
                    kHeight,
                    Center(
                      child: GestureDetector(
                        onTap: () => pickImage(),
                        child: Obx(
                          () => image.value ==
                                  '' //if image if null, show container; otherwiese Image.file
                              ? Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueGrey,
                                  ),
                                )
                              : Image.file(
                                  File(image.value),
                                  height: 140,
                                  width: 140,
                                ),
                        ),
                      ),
                    ),
                    kHeight,
                    kHeight,
                    CustomInputField(
                        textController: sNameTEController, hintText: 'Name'),
                    kHeight,
                    CustomInputField(
                        textController: sAgeTEController, hintText: 'Age'),
                    kHeight,
                    CustomInputField(
                        textController: sPhoneTEController,
                        hintText: 'Phone number'),
                    kHeight,
                    CustomInputField(
                        textController: sStdTEController, hintText: 'Class'),
                    kHeight,
                    submitButton(index)
                  ],
                ),
              )),
        );
      },
    );
  }

  ElevatedButton submitButton(int? index) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
      label: Text('Submit'),
      onPressed: () {
        bool? isValidated = formKey.currentState?.validate();
        if (isValidated == true) {
          String stdName = sNameTEController.text;
          int stdAge = int.parse(sAgeTEController.text);
          int stdPhone = int.parse(sPhoneTEController.text);
          String stdStandard = sStdTEController.text;
          String imagePath = image.value;

          if (index != null) {
            controller.updateStundent(
                index: index,
                student: StudentModel(
                    name: stdName,
                    age: stdAge,
                    phoneNumber: stdPhone,
                    standard: stdStandard,
                    imagePath: imagePath));
          } else {
            controller.createStudent(
                student: StudentModel(
                    name: stdName,
                    age: stdAge,
                    phoneNumber: stdPhone,
                    standard: stdStandard,
                    imagePath: imagePath));
          }
          print(
              "checking for box ${controller.observableBox.values.toList().toString()}");

          Get.back();
        } else {
          //Get.back();
          Get.snackbar('Wrong input',
              'Please enter the required details in the given fields');
        }
      },
      icon: const Icon(Icons.check),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.textController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType = TextInputType.name;

    if (hintText != 'Name') {
      keyboardType = const TextInputType.numberWithOptions();
    }

    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hintText),
      controller: textController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
