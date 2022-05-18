import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_second/controller/student_controller.dart';
import 'package:getx_counter_second/model/student_model.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(
      StudentController()); //Controller class: Create, Update, Delete functions

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

  @override
  Widget build(BuildContext context) {
    // print(controller.boxCount);
    // final c= StudentController();
    // print('C കിട്ടിയോ മോനേ ');
    // // print(c.boxCount);
    return Scaffold(
      appBar: AppBar(title: const Text('Student Manager')),
      body: GetBuilder<StudentController>(
        builder: (controller) => ListView.builder(
            itemCount: controller.boxCount,
            itemBuilder: (context, index) {
              print(controller.boxCount);
              if (controller.boxCount > 0) {
                List<dynamic> student1 =
                    controller.observableBox.values.toList();

                StudentModel? student = controller.observableBox.getAt(index);
                return Card(
                    child: ListTile(
                  title: Text(student?.name ?? "n/a"),
                  subtitle: Text(student?.standard ?? "n/a"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            print('Index issssssss $index');
                            controller.deleteStundent(index: index);
                          },
                          icon: const Icon(Icons.remove)),
                      IconButton(
                          onPressed: () =>
                              addEditStudent(index: index, student: student),
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ));
              } else {
                return const Center(
                  child: Text('No student data available'),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => addEditStudent()),
        child: const Icon(Icons.add),
      ),
    );
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
          } else {
            sAgeTEController.clear();
            sNameTEController.clear();
            sPhoneTEController.clear();
            sStdTEController.clear();
          }

          return Material(
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Name'),
                      controller: sNameTEController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                   // CustomInputField(textController: sAgeTEController),
                    ElevatedButton(
                        onPressed: () {
                          bool? isValidated = formKey.currentState?.validate();
                          if (isValidated == true) {
                            String stdName = sNameTEController.text;
                            int stdAge = int.parse(sAgeTEController.text);
                            int stdPhone = 3030303030330;
                            String stdStandard = 'V-B';
                            // String stdPhone = sPhoneTEController.text;
                            // String stdStandard = sStdTEController.text;

                            if (index != null) {
                              controller.updateStundent(
                                  index: index,
                                  student: StudentModel(
                                      name: stdName,
                                      age: stdAge,
                                      phoneNumber: stdPhone,
                                      standard: stdStandard));
                            } else {
                              controller.createStudent(
                                  student: StudentModel(
                                      name: stdName,
                                      age: stdAge,
                                      phoneNumber: stdPhone,
                                      standard: stdStandard));
                            }
                            print(
                                "checking for box ${controller.observableBox.values.toList().toString()}");

                            Get.back();
                          } else {
                            Get.back();
                            Get.snackbar('title', 'message');
                          }
                        },
                        child: const Icon(Icons.add))
                  ],
                )),
          );
        });
  }

  clearStudent() {}
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
    return TextFormField(
      decoration:  InputDecoration(hintText: hintText),
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
