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
  static const String downloadNowTitleKey = 'downloadNowTitleKey';

  static const String rateTitleKey = 'rateTitleKey';
  static const String rateDescKey = 'rateDescKey';
  static const String rateButtonTitleKey = 'rateButtonTitleKey';
  static const String rateNoThanksButtonTitleKey = 'rateNoThanksButtonTitleKey';
  static const String rateMaybeButtonTitleKey = 'rateMaybeButtonTitleKey';
}

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          MessageKeys.brickBreakerTitleKey: 'BRICK BREAKER',
          MessageKeys.playButtonTitleKey: 'Play',
          MessageKeys.settingsButtonTitleKey: 'Settings',
          MessageKeys.musicButtonTitleKey: 'Music',
          MessageKeys.darkModeButtonTitleKey: 'Dark Mode',
          MessageKeys.gameLevelTitleKey: 'Game Level',
          MessageKeys.levelTitleKey: 'Level ',
          MessageKeys.playAgainButtonTitleKey: 'Play Again?',
          MessageKeys.backButtonTitleKey: 'Back',
          MessageKeys.gameOverTitleKey: 'Game Over',
          MessageKeys.congratulationTitleKey: 'You Win',
          MessageKeys.nextButtonTitleKey: 'Next?',
          MessageKeys.onButtonTitleKey: 'ON',
          MessageKeys.offButtonTitleKey: 'OFF',
          MessageKeys.downloadNowTitleKey: 'Download Now',
          MessageKeys.rateTitleKey: 'Rate this app',
          MessageKeys.rateMaybeButtonTitleKey: 'MAYBE LATER',
          MessageKeys.rateDescKey:
              'If you like this game, please take a little bit of your time to review it !\nIt really helps us and it should not take you more than one minute.',
          MessageKeys.rateButtonTitleKey: 'RATE',
          MessageKeys.rateNoThanksButtonTitleKey: 'NO THANKS'
        },
        'ar': {
          MessageKeys.brickBreakerTitleKey: 'BRICK BREAKER',
          MessageKeys.playButtonTitleKey: 'Play',
          MessageKeys.settingsButtonTitleKey: 'Settings',
          MessageKeys.musicButtonTitleKey: 'Music',
          MessageKeys.darkModeButtonTitleKey: 'Dark Mode',
          MessageKeys.gameLevelTitleKey: 'Game Level',
          MessageKeys.levelTitleKey: 'Level ',
          MessageKeys.playAgainButtonTitleKey: 'Play Again?',
          MessageKeys.backButtonTitleKey: 'Back',
          MessageKeys.gameOverTitleKey: 'Game Over',
          MessageKeys.congratulationTitleKey: 'You Win',
          MessageKeys.nextButtonTitleKey: 'Next?',
          MessageKeys.onButtonTitleKey: 'ON',
          MessageKeys.offButtonTitleKey: 'OFF',
          MessageKeys.downloadNowTitleKey: 'Download Now',
          MessageKeys.rateTitleKey: 'Rate this app',
          MessageKeys.rateMaybeButtonTitleKey: 'MAYBE LATER',
          MessageKeys.rateDescKey:
          'If you like this game, please take a little bit of your time to review it !\nIt really helps us and it should not take you more than one minute.',
          MessageKeys.rateButtonTitleKey: 'RATE',
          MessageKeys.rateNoThanksButtonTitleKey: 'NO THANKS'
        }
      };
}
