import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pronounciation_controller.dart';

class UploadAudio extends StatelessWidget {
  UploadAudio({super.key});
  final PronunciationController controller = Get.find();
  final TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Audio'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Write the Spanish Translation in English And Pick The Spanish Audio',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 450,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color.fromARGB(255, 184, 180, 233),
                        width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: textController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 184, 180, 233)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              hintText: ('The Word/Number In English'),
                              prefixIcon: const Icon(
                                Icons.menu_book_outlined,
                                size: 30,
                                color: Color.fromARGB(255, 184, 180, 233),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a word or number';
                              }
                              return null;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.audio,
                            );

                            if (result != null) {
                              String? path = result.files.single.path;
                              if (path != null) {
                                String fileName = result.files.single.name;
                                controller.updateSelectedFile(fileName, path);
                              }
                            }
                          },
                          child: Obx(
                            () {
                              return SizedBox(
                                height: 148,
                                width: double.infinity,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(25),
                                  color: Colors.black,
                                  strokeWidth: 1,
                                  child: Center(
                                    child: controller
                                            .selectedFilePath.value.isEmpty
                                        ? const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.upload,
                                                size: 40,
                                              ),
                                              Text(
                                                'Upload Audio',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.audiotrack,
                                                size: 40,
                                              ),
                                              Text(
                                                controller
                                                    .selectedFileName.value,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  controller
                                                      .clearSelectedFile();
                                                },
                                                child: const Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String selectedType =
                                      'number'; // Default to number

                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text('Select Type'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              title: const Text('Number'),
                                              leading: Radio<String>(
                                                activeColor: Colors.blue,
                                                value: 'number',
                                                groupValue: selectedType,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      selectedType = value;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: const Text('Word'),
                                              leading: Radio<String>(
                                                activeColor: Colors.blue,
                                                value: 'word',
                                                groupValue: selectedType,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      selectedType = value;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              controller.addPronunciation(
                                                selectedType,
                                                textController.text,
                                                controller
                                                    .selectedFilePath.value,
                                              );
                                              textController.clear();
                                              controller.clearSelectedFile();
                                              Navigator.of(context)
                                                  .pop(); // To Close the dialog

                                              // To Show success Snackbar
                                              Get.snackbar(
                                                'Success',
                                                'Audio uploaded successfully!',
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                backgroundColor: Colors.blue,
                                                colorText: Colors.white,
                                              );
                                            },
                                            child: const Text(
                                              'OK',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 184, 180, 233),
                            fixedSize: const Size(300, 55),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
