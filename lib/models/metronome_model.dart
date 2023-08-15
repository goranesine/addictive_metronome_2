import 'dart:async';

import 'package:addictive_metronome_2/models/exercise_model.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reliable_interval_timer/reliable_interval_timer.dart';
class Signal {}

class AddictiveMetronome {
  int bpm = 60;
  int numberOfBars = 4;
  int numberOfSubdivisions = 4;
 late List<String> playingPattern = [];
  late ReliableIntervalTimer timer = ReliableIntervalTimer(
      interval: Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions),
      callback: (e) => loop());
  late bool isPlaying;
  bool isClickPlaying = false;

  int beatPosition = 0;

  // Outbound signal driver - allows widgets to listen for signals from audio engine
  static final StreamController<Signal> _signal =
  StreamController<Signal>.broadcast();

  static Future<void> close() =>
      _signal.close(); // Not used but required by SDK
  static StreamSubscription<Signal> listen(Function(Signal) onData) =>
      _signal.stream.listen(onData);

  AddictiveMetronome() {
    isPlaying = timer.isRunning;
    String temp =  ExerciseModel.randomSixteenNotes();
    playingPattern = temp.split("");
  }

  void populateExercise()  {
   if(isPlaying) {
      toogleMetronome();
    }
    playingPattern.clear();
    String temp =  ExerciseModel.randomSixteenNotes();
       playingPattern = temp.split("");
   Future.delayed(const Duration(seconds: 1), () => toogleMetronome());
  }

  void updateBpm(int newBpm) {
    bpm = newBpm;
    timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
  }
void toogleClick(){
    isClickPlaying = !isClickPlaying;
}
  void toogleMetronome() {
    if (isPlaying == true) {
      timer.stop();
      isPlaying = false;
      beatPosition = 0;
    } else {
      timer.start();
      isPlaying = true;
    }
  }

  void loop() {
    if (beatPosition <= (numberOfBars * numberOfSubdivisions - 1)) {
      if (playingPattern[beatPosition] ==
          playingPattern[beatPosition].toUpperCase()) {
        if(isClickPlaying) {
          beatPosition % numberOfSubdivisions == 0 || beatPosition == 0
              ? OggPlayer.play(2)
              : null;
        }
        OggPlayer.play(1);
        _signal.add(Signal());

        beatPosition <= (numberOfBars * numberOfSubdivisions - 2)
            ? beatPosition++
            : beatPosition = 0;
      } else {
        if(isClickPlaying) {
          beatPosition % numberOfSubdivisions == 0 || beatPosition == 0
              ? OggPlayer.play(2)
              : null;
        }
        OggPlayer.play(0);
        _signal.add(Signal());

        beatPosition <= (numberOfBars * numberOfSubdivisions - 2)
            ? beatPosition++
            : beatPosition = 0;
      }
    }
  }
}
