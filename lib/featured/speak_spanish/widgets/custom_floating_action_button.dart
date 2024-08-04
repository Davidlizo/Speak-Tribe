import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pronounciation_controller.dart';
import '../pages/upload_audio.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.controller,
  });

  final PronunciationController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () async {
        Get.to(() => UploadAudio(key: super.key,));
      },
      child: const Icon(
        Icons.upload_file,
        color: Colors.white,
      ),
    );
  }
}
