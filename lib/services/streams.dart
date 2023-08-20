import 'dart:async';

class Signal {}
class SignalForGuiUpdate {}

class Streams{
  // Outbound signal driver - allows widgets to listen for signals for set state
  static final StreamController<Signal> metronomeTickSignal =
  StreamController<Signal>.broadcast();

  static Future<void> close() =>
      metronomeTickSignal.close(); // Not used but required by SDK
  static StreamSubscription<Signal> listen(Function(Signal) onData) =>
      metronomeTickSignal.stream.listen(onData);

  static void broadcastMetronomeSignal() {
    metronomeTickSignal.add(Signal());
  }
  static final StreamController<SignalForGuiUpdate> guiUpdateSignal =
  StreamController<SignalForGuiUpdate>.broadcast();

  static Future<void> closeGuiUpdateStream() =>
      guiUpdateSignal.close(); // Not used but required by SDK
  static StreamSubscription<SignalForGuiUpdate> listenForGuiUpdate(Function(SignalForGuiUpdate) onData) =>
      guiUpdateSignal.stream.listen(onData);

  static void broadcastGuiUpdateSignal() {
    guiUpdateSignal.add(SignalForGuiUpdate());
  }

}