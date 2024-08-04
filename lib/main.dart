import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'featured/bottom_navigation.dart';
import 'featured/speak_spanish/controllers/pronounciation_controller.dart';
import 'featured/speak_spanish/pages/splash_screen.dart';


void main() {
  runApp(const SpeakTribe());
}

class SpeakTribe extends StatelessWidget {
  const SpeakTribe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spanish Pronunciation App',
      initialBinding: BindingsBuilder(() {
        Get.put(PronunciationController());
      }),
      routes: {
        '/': (context) => const AnimatedSplashScreen(),
        '/home': (context) => NavScreens(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
