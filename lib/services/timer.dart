import 'dart:async';

import 'package:addictive_metronome_2/services/streams.dart';
import 'package:reliable_interval_timer/reliable_interval_timer.dart';


class CustomTimer {
  late ReliableIntervalTimer customTimer;
  late Duration interval;
  late bool isPlaying = false;

  CustomTimer() {
    customTimer = ReliableIntervalTimer(
        interval: (const Duration(milliseconds: 60000 ~/ 60 ~/ 4)),
        callback: (t) => Streams.broadcastMetronomeSignal());
  }

  Future<void> start() async {
    customTimer.start();
  }

  Future<void> stop() async {
    customTimer.stop();
  }

  Future<void> updateInterval(Duration newInterval) async {
    customTimer.updateInterval(newInterval);
  }


}
