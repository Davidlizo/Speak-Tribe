import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pronounciation_controller.dart';
import '../widgets/custom_floating_action_button.dart';
import 'number_list_screen.dart';
import 'word_list_screen.dart';

class SpeakTribeScreen extends StatelessWidget {
  const SpeakTribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PronunciationController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text('Learn Spanish'),
      ),
      body: const DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Learn To Pronounce Numbers And Words In Spanish',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              // physics: NeverScrollableScrollPhysics(),
              tabs: [
                Tab(text: 'Numbers'),
                Tab(text: 'Words'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  NumberListScreen(),
                  WordListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(controller: controller),
    );
  }
}
