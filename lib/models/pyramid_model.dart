
import 'dart:async';

import 'package:addictive_metronome_2/constants.dart';

import '../services/ogg_player.dart';
import '../services/streams.dart';
import '../services/timer.dart';

class PyramidModel{

  final _timer = CustomTimer();
  final int minBpm = 60;
  final int maxBpm = 120;
  int bpm = 60;

  late List<bool> playingPattern = [];
  bool isAutomaticIncreasmentOn = false;
  bool isClickPlaying = false;
  bool isMetronomePlaying = false;
  int beatPosition = 0;
 bool isAscending = false;
 int exerciseNumber = 0;
 int numberOfLoopsPlayed = 0;
  late StreamSubscription<Signal> _stream;

  void on<Signal>(Signal s) => loop();

  PyramidModel() {
    updatePattern();
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ));
    _stream = Streams.listen(on);
  }



  void updatePattern() {

    playingPattern.clear();
    for(var i=0;i<8;i++){
      for(var j=0;j< Constants.pyramidList[exerciseNumber].length;j++){
playingPattern.add(Constants.pyramidList[exerciseNumber][j]);
      }
    }
    Streams.broadcastGuiUpdateSignal();
  }


  void updateBpm(int newBpm) {
    bpm = newBpm;
    _timer.updateInterval(
        Duration(milliseconds: 60000 ~/ bpm ~/Constants.pyramidList[exerciseNumber].length
            ));
    Streams.broadcastGuiUpdateSignal();
  }

  void toogleClick() {
    isClickPlaying = !isClickPlaying;
    Streams.broadcastGuiUpdateSignal();
  }

  void toogleAutoIncreasment() {
    isAutomaticIncreasmentOn = !isAutomaticIncreasmentOn;
    Streams.broadcastGuiUpdateSignal();
  }

  void toogleMetronome() {
    if (_timer.isPlaying == true) {
      _timer.stop();
      _timer.isPlaying = false;
      isMetronomePlaying = false;
      beatPosition = 0;
      exerciseNumber = 0;
      isAscending = false;
      updatePattern();
      Streams.broadcastGuiUpdateSignal();
    } else {
      isMetronomePlaying = true;

      _timer.start();
      _timer.isPlaying = true;
    }
  }
  void updateExerciseNUmber(){
    if(isAutomaticIncreasmentOn && exerciseNumber == 0 && !isAscending){
      updateBpm(bpm+5);
    }
    if(exerciseNumber == 7 || exerciseNumber == 0){isAscending = !isAscending;}

    if(exerciseNumber<7 && isAscending){
      exerciseNumber++;
      updatePattern();
    }else if(exerciseNumber>0 && !isAscending){
      exerciseNumber--;
      updatePattern();
    }
    Streams.broadcastGuiUpdateSignal();
  }
void updateBeatPosition(){
  if(beatPosition < Constants.pyramidList[exerciseNumber].length * 8-1){
    beatPosition++;
  }else{
    beatPosition=0;
   updateExerciseNUmber();
  }
}
  void loop() {
    updateBpm(bpm);

    if (playingPattern[beatPosition]) {

       OggPlayer.play(1);

    } else{OggPlayer.play(0);}

   updateBeatPosition();

  }
  void dispose(){
    _timer.stop();
    _stream.cancel();

  }
}