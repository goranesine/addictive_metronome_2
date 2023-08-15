
import 'dart:async';

import 'package:reliable_interval_timer/reliable_interval_timer.dart';
class Signal {}

class CustomTimer {
 late ReliableIntervalTimer customTimer;
 late Duration interval;
 late bool isPlaying = false;

 CustomTimer(){
   customTimer = ReliableIntervalTimer(interval: (const Duration(milliseconds: 60000 ~/ 60 ~/ 4)),
       callback:(t)=> broadcastSignal());
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

  // Outbound signal driver - allows widgets to listen for signals for set state
  static final StreamController<Signal> _signal =
  StreamController<Signal>.broadcast();

  static Future<void> close() =>
      _signal.close(); // Not used but required by SDK
  static StreamSubscription<Signal> listen(Function(Signal) onData) =>
      _signal.stream.listen(onData);
static void broadcastSignal(){
  _signal.add(Signal());
}

}