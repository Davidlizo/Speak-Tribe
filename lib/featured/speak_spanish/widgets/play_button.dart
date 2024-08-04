import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pronounciation_controller.dart';

class PlayButton extends StatelessWidget {
  final String audioPath;

  const PlayButton(this.audioPath, {super.key});

  @override
  Widget build(BuildContext context) {
    final PronunciationController controller = Get.find();

    return GestureDetector(
      onTap: () {
        controller.playAudio(audioPath);
      },
      child: Obx(() {
        bool isPlaying = controller.playingPath.value == audioPath;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue,
          ),
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
                Text(
                  isPlaying ? 'Playing' : 'Play',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
