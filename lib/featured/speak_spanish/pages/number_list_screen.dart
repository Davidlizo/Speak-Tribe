import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pronounciation_controller.dart';
import '../widgets/play_button.dart';

class NumberListScreen extends StatelessWidget {
  const NumberListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PronunciationController controller = Get.find();

    return Obx(() {
      if (controller.numbers.isEmpty) {
        return const Center(
          child: Text(
            'No numbers available. Please upload some audio files.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        );
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.numbers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 184, 180, 233),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.numbers[index]['text']} in español says',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Center(child: Icon(Icons.arrow_downward)),
                    PlayButton(controller.numbers[index]['path']!),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
