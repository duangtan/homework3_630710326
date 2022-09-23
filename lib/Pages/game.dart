import 'dart:math';

enum Result {
  tooHigh,
  tooLow,
  correct
}

class Game {
  static const defaultMaxRandom = 100;
  int? _answer;

  Game({int maxRandom = defaultMaxRandom}) {
    var r = Random();
    _answer = r.nextInt(maxRandom) + 1;
    print('The answer is $_answer');
  }

  Result doGuess(int num) {
    if (num > _answer!) {
      return Result.tooHigh;
    } else if (num < _answer!) {
      return Result.tooLow;
    } else {
      return Result.correct;
    }
  }
}