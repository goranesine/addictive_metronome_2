import 'dart:async';

import 'package:addictive_metronome_2/services/ogg_player.dart';

import '../services/streams.dart';
import '../services/timer.dart';


class MetronomeModel  {
  final _timer = CustomTimer();
  int beatCounter = 1;
  int tempoInBpm = 120;
  int step = 5;
  bool isMetronomePlaying = false;
 late Duration beatDurationInMilliseconds = Duration();
  List<bool> beatStatusList =
      <bool>[true, false,false,false];
  int listLength = 4;
  bool isAutomaticIncreaserOn = false;
  int barCounter = 0;
  bool tick = false;
  bool isAndBeatOn = false;
  List<DateTime> tapList = [];
  bool longPressIncreaserDecreaser = false;
  Duration tempoOfIncreaserDecreaser = const Duration(milliseconds: 200);
  final _stopwatch = Stopwatch();
  String elapsedPlayingTime = "00:00:00";
  late Timer elapsedTimer;
  late StreamSubscription<Signal> _stream;

  void on<Signal>(Signal s) => isMetronomePlaying == true ? updateBeatCounter() : null;

  MetronomeModel() {
    _stream = Streams.listen(on);

    beatCounter = -1;
    calculateBeatDurationInMilliseconds();
    elapsedTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      elapsedPlayingTime = formatTime(_stopwatch.elapsedMilliseconds);
    });
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void handleStartStopStopWatch() {
    if (isMetronomePlaying == true) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
  }

  void activateLongPress() {
    longPressIncreaserDecreaser = true;
  }

  void deactivateLongPress() {
    longPressIncreaserDecreaser = false;
  }

  void stepIncreaser() {
    if (step < 10) {
      step++;
      Streams.broadcastGuiUpdateSignal();
    }
  }

  void stepDecreaser() {
    if (step > 1) {
      step--;
      Streams.broadcastGuiUpdateSignal();
    }
  }

  void switchAndBeat() {
    isAndBeatOn = !isAndBeatOn;
    Streams.broadcastGuiUpdateSignal();
  }

  void automaticIncreaserOnOff() {
    isAutomaticIncreaserOn = !isAutomaticIncreaserOn;
    barCounter = 0;
    Streams.broadcastGuiUpdateSignal();
  }

  void startAutomaticTimeIncreasment() {
    if (tempoInBpm + step <= 320 &&
        isAutomaticIncreaserOn == true) {
      tempoInBpm = tempoInBpm + step;
      barCounter = 0;
      Streams.broadcastGuiUpdateSignal();
      calculateBeatDurationInMilliseconds();
    }
  }

  void getListLength() {
    listLength = beatStatusList.length;
    Streams.broadcastGuiUpdateSignal();
  }

  void addBeat() {
    if (beatStatusList.length > 1 && beatStatusList.length < 8) {
      beatStatusList.add(false);
      barCounter = 0;

      Streams.broadcastGuiUpdateSignal();
      getListLength();
      calculateBeatDurationInMilliseconds();
    }
  }

  void removeBeat() {
    if (beatStatusList.length > 2) {
      beatStatusList.removeLast();
      barCounter = 0;

      Streams.broadcastGuiUpdateSignal();
      getListLength();
      calculateBeatDurationInMilliseconds();
    }
  }

  void setBeatAccent(int index) {
    bool oldValue = beatStatusList[index];
    beatStatusList[index] = !oldValue;
    Streams.broadcastGuiUpdateSignal();
  }

  void calculateBeatDurationInMilliseconds() {
    _timer.updateInterval(Duration(milliseconds: 60000.0 ~/ tempoInBpm));

    Streams.broadcastGuiUpdateSignal();
  }



  void increaseTempo() {
    if (tempoInBpm >= 40 && tempoInBpm + step <= 320) {
      tempoInBpm = tempoInBpm + step;
      Streams.broadcastGuiUpdateSignal();
      calculateBeatDurationInMilliseconds();
    }
    if (longPressIncreaserDecreaser == true) {
      Timer(tempoOfIncreaserDecreaser, () {
        increaseTempo();
      });
    }
  }

  void decreaseTempo() {
    if (tempoInBpm - step >= 40 && tempoInBpm <= 320) {
      tempoInBpm = tempoInBpm - step;
      Streams.broadcastGuiUpdateSignal();
      calculateBeatDurationInMilliseconds();
    }
    if (longPressIncreaserDecreaser == true) {
      Timer(tempoOfIncreaserDecreaser, () {
        decreaseTempo();
      });
    }
  }

  void switchOnOff() {
    if (isMetronomePlaying == false) {
      barCounter = 0;
      isMetronomePlaying = true;
      Streams.broadcastGuiUpdateSignal();
_timer.start();      _stopwatch.start();

    } else {
      _timer.stop;
      isMetronomePlaying = false;
      beatCounter = -1;
      barCounter = 0;
      Streams.broadcastGuiUpdateSignal();
      _stopwatch.stop();

    }
  }



  void playAndBeat() {
    if (isAndBeatOn == true) {
      OggPlayer.play(2);
    }
  }

  void updateBeatCounter() {
    if (beatCounter < beatStatusList.length - 1) {
      beatCounter++;
      Streams.broadcastGuiUpdateSignal();
      playSound();
    } else {
      barCounter > 4 ? barCounter = 0 : barCounter++;

      beatCounter = 0;
      Streams.broadcastGuiUpdateSignal();

      playSound();
    }
  }

  void playSound() {
    if (barCounter == 4) {
      startAutomaticTimeIncreasment();
    }

    tick = !tick;
    Streams.broadcastGuiUpdateSignal();
    if (barCounter == 3 && isAutomaticIncreaserOn == true) {
OggPlayer.play(2);
    } else {print(beatStatusList); print(beatCounter);
      beatStatusList[beatCounter] == true
          ? OggPlayer.play(3)
          : OggPlayer.play(4);
    }
    Timer(beatDurationInMilliseconds ~/ 2, () => OggPlayer.play(2));
  }

  void tapTempo() {
    //  if (tapList.length < 2) {
    tapList.add(DateTime.now());
    //  } else {
    if (tapList.length >= 2) {
      getTempoFromTapList();
    }
    //  tapList.clear();
    //  }
  }

  void getTempoFromTapList() {
    int listLength = tapList.length - 1;
    int calculatedTempo = 60000 ~/
        (tapList[listLength].millisecondsSinceEpoch -
            tapList[listLength - 1].millisecondsSinceEpoch);
    if (calculatedTempo <= 320 && calculatedTempo >= 40) {
      tempoInBpm = calculatedTempo;
      Streams.broadcastGuiUpdateSignal();
      calculateBeatDurationInMilliseconds();
    } else {}
  }


  void dispose() {
    _timer.stop();
    elapsedTimer.cancel();
  }

}
