import 'dart:async';

import '../services/ogg_player.dart';
import '../services/streams.dart';
import '../services/timer.dart';

class MetronomeModel {
  final _timer = CustomTimer();
  final int minBpm = 60;
  final int maxBpm = 120;
  int bpm = 60;
  int numberOfSubdivisions = 4;
  late List<String> playingPattern = [];
  bool isAutomaticIncreasmentOn = false;
  bool isMetronomePlaying = false;
  int beatPosition = 0;
  late StreamSubscription<Signal> _stream;

  void on<Signal>(Signal s) => loop();
  int numberOfBarsPlayed = 0;
  int numberOfEightBarsPlayed = 0;
  bool playPyramidExercise = false;
  bool isPyramidAscending = true;

  MetronomeModel() {
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
    _stream = Streams.listen(on);
  }

  void loop() {
  //  print("number of playingbars: $numberOfEightBarsPlayed" "isAscending: $isPyramidAscending");
  if(playPyramidExercise){
    if (beatPosition == 0 ) {
      OggPlayer.play(1);

          beatPosition++;
      } else {
      OggPlayer.play(0);

      if (beatPosition < numberOfSubdivisions - 1) {

        beatPosition++;
      } else {

        beatPosition = 0;
        if (numberOfBarsPlayed < 7) {
          numberOfBarsPlayed++;
        } else {
          numberOfBarsPlayed = 0;
          if(numberOfEightBarsPlayed<7 ) {
              numberOfEightBarsPlayed++;
              if(isPyramidAscending && numberOfSubdivisions <8 ){
                numberOfSubdivisions++;
                _timer.updateInterval(
                    Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
              }if(!isPyramidAscending && numberOfSubdivisions >1 ) {
                numberOfSubdivisions--;
                _timer.updateInterval(
                    Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
              }
            }else{
            numberOfEightBarsPlayed = 2;
            isPyramidAscending = !isPyramidAscending;
       isPyramidAscending ? numberOfSubdivisions++ :     numberOfSubdivisions--;
            _timer.updateInterval(
                Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
          }

        }
      }
    }

  }else{
    if (beatPosition == 0) {
      OggPlayer.play(1);
      beatPosition++;
    } else {
      OggPlayer.play(0);
      if (beatPosition < numberOfSubdivisions - 1) {
        beatPosition++;
      } else {
        beatPosition = 0;
        if (numberOfBarsPlayed < 7) {
          numberOfBarsPlayed++;
        } else {
          numberOfBarsPlayed = 0;
          if (isAutomaticIncreasmentOn) {
            if (bpm + 5 <= maxBpm) {
              updateBpm(bpm + 5);
            }
          }
        }
      }
    }
  }
  }

  void toogleMetronome() {
    if (_timer.isPlaying == true) {
      _timer.stop();
      _timer.isPlaying = false;
      isMetronomePlaying = false;
      beatPosition = 0;
      Streams.broadcastGuiUpdateSignal();
    } else {
      _timer.start();
      _timer.isPlaying = true;
      isMetronomePlaying = true;
    }
  }

  void toogleAutoIncreasment() {
    if (playPyramidExercise == false) {
      isAutomaticIncreasmentOn = !isAutomaticIncreasmentOn;
    }
    Streams.broadcastGuiUpdateSignal();
  }

  void tooglePiramidExercise() {
    isPyramidAscending = true;
    _timer.stop();
    _timer.isPlaying = false;
    isMetronomePlaying = false;
    isAutomaticIncreasmentOn = false;
    playPyramidExercise = !playPyramidExercise;
    numberOfBarsPlayed = 0;
    numberOfEightBarsPlayed=1;
    beatPosition = 0;
    playPyramidExercise ? numberOfSubdivisions = 2 : numberOfSubdivisions = 4;
    Streams.broadcastGuiUpdateSignal();
  }

  void updateBpm(int newBpm) {
    bpm = newBpm;
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/ numberOfSubdivisions));
    Streams.broadcastGuiUpdateSignal();
  }

  void increaseSubdivision() {
    if (numberOfSubdivisions < 8) {
      numberOfSubdivisions++;
    }
    updateBpm(bpm);
    Streams.broadcastGuiUpdateSignal();
  }

  void decreaseSubdivision() {
    if (numberOfSubdivisions > 1) {
      numberOfSubdivisions--;
    }
    updateBpm(bpm);

    Streams.broadcastGuiUpdateSignal();
  }

  void dispose() {
    _timer.stop();
    _stream.cancel();
  }
}
