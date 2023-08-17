import 'dart:async';

import 'package:addictive_metronome_2/models/eight_mote_with_accent_data.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:addictive_metronome_2/services/timer.dart';

import '../constants.dart';

class EightNoteWithAccentsModel {
  final _timer = CustomTimer();
  int bpm = 60;
  int numberOfBars = 4;
  int numberOfSubdivisions = 4;
  late List<String> playingPattern = [];
  bool isAutomaticIncreasmentOn = false;
  bool isClickPlaying = false;
bool isMetronomePlaying = false;
  int beatPosition = 0;
  int numberOfBarsPlayed = 0;
  late StreamSubscription<Signal> _stream;

  void on<Signal>(Signal s) => loop();

  EightNoteWithAccentsModel() {
    String temp = ExerciseModel.randomSixteenNotes();
    playingPattern = temp.split("");
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
    _stream = CustomTimer.listen(on);
  }

  void populateExercise() {
    if (_timer.isPlaying) {
      toogleMetronome();
    }
    playingPattern.clear();
    String temp = ExerciseModel.randomSixteenNotes();
    playingPattern = temp.split("");
    Future.delayed(const Duration(seconds: 1), () => toogleMetronome());
  }

  void invertAccent() {
    List<String> temp = [];
    for (var i = 0; i < playingPattern.length; i++) {
      playingPattern[i] == playingPattern[i].toUpperCase()
          ? temp.add(playingPattern[i].toLowerCase())
          : temp.add(playingPattern[i].toUpperCase());
    }
    playingPattern = temp;
  }

  void invertHands() {
    List<String> temp = [];
    for (var i = 0; i < playingPattern.length; i++) {
      switch (playingPattern[i]) {
        case "l":
          temp.add("r");
          break;

        case "L":
          temp.add("R");
          break;

        case "r":
          temp.add("l");
          break;

        case "R":
          temp.add("L");
          break;
      }
    }
    playingPattern = temp;
  }

  void updateBpm(int newBpm) {
    bpm = newBpm;
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
  }

  void toogleClick() {
    isClickPlaying = !isClickPlaying;
  }

  void toogleAutoIncreasment() {
    numberOfBarsPlayed = 0;
    isAutomaticIncreasmentOn = !isAutomaticIncreasmentOn;
  }

  void toogleMetronome() {
    if (_timer.isPlaying == true) {
      _timer.stop();
      _timer.isPlaying = false;
      isMetronomePlaying = false;
      beatPosition = 0;
      numberOfBarsPlayed = 0;
    } else {
      _timer.start();
      _timer.isPlaying = true;
      isMetronomePlaying = true;
    }
  }

  void loop() {
    if (beatPosition <= (numberOfBars * numberOfSubdivisions - 1)) {
      if (playingPattern[beatPosition] ==
          playingPattern[beatPosition].toUpperCase()) {
        if (isClickPlaying) {
          beatPosition % numberOfSubdivisions == 0 || beatPosition == 0
              ? OggPlayer.play(2)
              : null;
        }
        OggPlayer.play(1);

        beatPosition <= (numberOfBars * numberOfSubdivisions - 2)
            ? beatPosition++
            : {beatPosition = 0, numberOfBarsPlayed++};
      } else {
        if (isClickPlaying) {
          beatPosition % numberOfSubdivisions == 0 || beatPosition == 0
              ? OggPlayer.play(2)
              : null;
        }
        OggPlayer.play(0);

        beatPosition <= (numberOfBars * numberOfSubdivisions - 2)
            ? beatPosition++
            : {beatPosition = 0, numberOfBarsPlayed++};
      }
    }
    if (numberOfBarsPlayed == 8 &&
        bpm+Constants.bpmAutomaticIncrementValue <= Constants.maxBpm &&
        isAutomaticIncreasmentOn == true) {
      updateBpm(bpm + Constants.bpmAutomaticIncrementValue);
      numberOfBarsPlayed = 0;
    }
  }
}
