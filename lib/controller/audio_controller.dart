import 'package:audioplayers/audioplayers.dart';
import 'package:brick_breaker_game/base/utils/constants.dart';
import 'package:brick_breaker_game/base/utils/shared_preference.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AudioController extends GetxController {
  late AudioCache _audioPlayer;
  late SharedPrefs sharedPrefs;

  AudioController({required this.sharedPrefs}) {
    _audioPlayer = AudioCache();
  }

  void playBrickAudio() {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      const alarmAudioPath = "audio/brick.wav";
      _audioPlayer.play(alarmAudioPath);
    }
  }

  void playGameOverAudio() {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      const alarmAudioPath = "audio/game_over.wav";
      _audioPlayer.play(alarmAudioPath);
    }
  }

  void playAwardAudio() {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      const alarmAudioPath = "audio/award.wav";
      _audioPlayer.play(alarmAudioPath);
    }
  }

  void playMissionSuccessAudio() {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      const alarmAudioPath = "audio/mission_success.wav";
      _audioPlayer.play(alarmAudioPath);
    }
  }

  @override
  void dispose() {
    _audioPlayer.clearAll();
    super.dispose();
  }
}
