import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class PronunciationController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxList<Map<String, String>> numbers = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> words = <Map<String, String>>[].obs;
  final RxString playingPath = ''.obs;
  var selectedFileName = ''.obs;
  var selectedFilePath = ''.obs;
  var inputText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.onPlayerComplete.listen((_) {
      playingPath.value = '';
    });
  }

  void playAudio(String path) async {
    playingPath.value = path;
    await _audioPlayer.play(DeviceFileSource(path));
  }

  void addPronunciation(String type, String text, String path) {
    if (text.isEmpty) {
      return;
    }
    if (type == 'number') {
      numbers.add({'text': text, 'path': path});
    } else if (type == 'word') {
      words.add({'text': text, 'path': path});
    }
  }

  void updateSelectedFile(String name, String path) {
    selectedFileName.value = name;
    selectedFilePath.value = path;
  }

  void clearSelectedFile() {
    selectedFileName.value = '';
    selectedFilePath.value = '';
  }

  void updateInputText(String text) {
    inputText.value = text;
  }

  void clearInput() {
    inputText.value = '';
    clearSelectedFile();
  }
}
