import 'package:get/get.dart';

class MessageKeys {
  static const String brickBreakerTitleKey = "brickBreakerTitleKey";
  static const String playButtonTitleKey = 'playButtonTitleKey';
  static const String settingsButtonTitleKey = 'settingsButtonTitleKey';
  static const String musicButtonTitleKey = 'musicButtonTitleKey';
  static const String onButtonTitleKey = 'onButtonTitleKey';
  static const String offButtonTitleKey = 'offButtonTitleKey';
  static const String darkModeButtonTitleKey = 'darkModeButtonTitleKey';
  static const String gameLevelTitleKey = 'gameLevelTitleKey';
  static const String levelTitleKey = 'levelTitleKey';
  static const String nextButtonTitleKey = 'nextButtonTitleKey';
  static const String playAgainButtonTitleKey = 'playAgainButtonTitleKey';
  static const String backButtonTitleKey = 'backButtonTitleKey';
  static const String gameOverTitleKey = 'gameOverTitleKey';
  static const String congratulationTitleKey = 'congratulationTitleKey';
}

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          MessageKeys.brickBreakerTitleKey: 'BRICK BREAKER',
          MessageKeys.playButtonTitleKey: 'Tap to play',
          MessageKeys.settingsButtonTitleKey: 'Settings',
          MessageKeys.musicButtonTitleKey: 'Music',
          MessageKeys.darkModeButtonTitleKey: 'Dark Mode',
          MessageKeys.gameLevelTitleKey: 'Game Level',
          MessageKeys.levelTitleKey: 'Level ',
          MessageKeys.playAgainButtonTitleKey: 'Play Again?',
          MessageKeys.backButtonTitleKey: 'Back',
          MessageKeys.gameOverTitleKey: 'Game Over',
          MessageKeys.congratulationTitleKey: 'Wow',
          MessageKeys.nextButtonTitleKey: 'Next?',
          MessageKeys.onButtonTitleKey: 'ON',
          MessageKeys.offButtonTitleKey: 'OFF',
        },
        'ar': {
          MessageKeys.brickBreakerTitleKey: 'BRICK BREAKER',
          MessageKeys.playButtonTitleKey: 'Tap to play',
          MessageKeys.settingsButtonTitleKey: 'Settings',
          MessageKeys.musicButtonTitleKey: 'Music',
          MessageKeys.darkModeButtonTitleKey: 'Dark Mode',
          MessageKeys.gameLevelTitleKey: 'Game Level',
          MessageKeys.levelTitleKey: 'Level ',
          MessageKeys.playAgainButtonTitleKey: 'Play Again?',
          MessageKeys.backButtonTitleKey: 'Back',
          MessageKeys.gameOverTitleKey: 'Game Over',
          MessageKeys.congratulationTitleKey: 'Wow',
          MessageKeys.nextButtonTitleKey: 'Next?',
          MessageKeys.onButtonTitleKey: 'ON',
          MessageKeys.offButtonTitleKey: 'OFF',
        }
      };
}
