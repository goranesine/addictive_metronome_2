import 'dart:async';

import 'package:addictive_metronome_2/models/eight_mote_with_accent_data.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:addictive_metronome_2/services/timer.dart';

import '../constants.dart';
import '../services/streams.dart';

class EightNoteWithAccentsModel {
  final _timer = CustomTimer();
  final int minBpm = 60;
  final int maxBpm = 120;
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
  int exerciseLevel = 0;

  void on<Signal>(Signal s) => loop();

  EightNoteWithAccentsModel() {
    String temp = ExerciseModel.randomSixteenNotes(exerciseLevel);
    playingPattern = temp.split("");
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
    _stream = Streams.listen(on);
  }

  void updateLevel(int level) {
    exerciseLevel = level;
    Streams.broadcastGuiUpdateSignal();
  }

  void populateExercise() {
    if (_timer.isPlaying) {
      toogleMetronome();
    }
    playingPattern.clear();
    String temp = ExerciseModel.randomSixteenNotes(exerciseLevel);
    playingPattern = temp.split("");
    Streams.broadcastGuiUpdateSignal();
  }

  void invertIndividualAccent(int indexInGrid) {
    playingPattern[indexInGrid] == playingPattern[indexInGrid].toLowerCase()
        ? playingPattern[indexInGrid] =
            playingPattern[indexInGrid].toUpperCase()
        : playingPattern[indexInGrid] =
            playingPattern[indexInGrid].toLowerCase();
    Streams.broadcastGuiUpdateSignal();
  }

  void invertAccent() {
    List<String> temp = [];
    for (var i = 0; i < playingPattern.length; i++) {
      playingPattern[i] == playingPattern[i].toUpperCase()
          ? temp.add(playingPattern[i].toLowerCase())
          : temp.add(playingPattern[i].toUpperCase());
    }
    playingPattern = temp;
    Streams.broadcastGuiUpdateSignal();
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
    Streams.broadcastGuiUpdateSignal();
  }

  void updateBpm(int newBpm) {
    bpm = newBpm;
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
    Streams.broadcastGuiUpdateSignal();
  }

  void toogleClick() {
    isClickPlaying = !isClickPlaying;
    Streams.broadcastGuiUpdateSignal();
  }

  void toogleAutoIncreasment() {
    numberOfBarsPlayed = 0;
    isAutomaticIncreasmentOn = !isAutomaticIncreasmentOn;
    Streams.broadcastGuiUpdateSignal();
  }

  void toogleMetronome() {
    if (_timer.isPlaying == true) {
      _timer.stop();
      _timer.isPlaying = false;
      isMetronomePlaying = false;
      beatPosition = 0;
      numberOfBarsPlayed = 0;
      Streams.broadcastGuiUpdateSignal();
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
        bpm + Constants.bpmAutomaticIncrementValue <= 120 &&
        isAutomaticIncreasmentOn == true) {
      updateBpm(bpm + Constants.bpmAutomaticIncrementValue);
      numberOfBarsPlayed = 0;
    }
  }
  void dispose(){
    _timer.stop();
    _stream.cancel();

  }
}
