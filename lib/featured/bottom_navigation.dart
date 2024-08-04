import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'speak_spanish/controllers/navbar_controller.dart';
import 'speak_spanish/pages/profile.dart';
import 'speak_spanish/pages/speak_tribe.dart';
import 'speak_spanish/pages/upload_audio.dart';

class NavScreens extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  NavScreens({super.key});

  final List<Widget> _screens = [
    const SpeakTribeScreen(),
          UploadAudio(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.currentIndex.value,
          onTap: controller.changeIndex,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white70,
          color: const Color.fromARGB(255, 184, 180, 233),
          items: const [
            Icon(Icons.home),
            Icon(Icons.upload),
            Icon(Icons.person),
          ],
        );
      }),
    );
  }
}
