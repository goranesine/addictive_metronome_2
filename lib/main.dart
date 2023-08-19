import 'dart:async';

import 'package:addictive_metronome_2/models/eight_mote_with_accent_data.dart';
import 'package:addictive_metronome_2/models/eight_note_with_accent_model.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:addictive_metronome_2/services/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:wakelock/wakelock.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ExerciseModel.splitToEightNotes();
  await ExerciseModel.splitToFourNotes();
  await OggPlayer.initOgg();
  await ExerciseModel.splitToEightNotes();
  await ExerciseModel.splitToFourNotes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final am = EightNoteWithAccentsModel();
  late StreamSubscription<Signal> _stream;

  void on<Signal>(Signal s) => setState(() {});

  @override
  void initState() {
    _stream = CustomTimer.listen(on);
    super.initState();
  }

  @override
  void dispose() {
    _stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width,
              height: height / 100 * 70,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8, crossAxisCount: am.numberOfBars),
                  itemCount: am.playingPattern.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Center(
                      child: Text(
                        am.playingPattern[index],
                        textScaleFactor: am.playingPattern[index] ==
                                am.playingPattern[index].toUpperCase()
                            ? 6
                            : 4,
                        style: index == am.beatPosition
                            ? const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)
                            : const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    );
                  }),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                child: const Center(
                    child: Text(
                  "|~^",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                onTap: () => am.invertAccent(),
              )),
              Expanded(
                  child: InkWell(
                child: const Center(
                    child: Text(
                  "L<>R",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                onTap: () => am.invertHands(),
              )),
              Expanded(
                  child: InkWell(
                child: const Center(
                    child: Text(
                  "PLAY",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                onTap: () => am.toogleMetronome(),
              )),
            ],
          ),
          Slider(
              activeColor: Colors.black,
              value: am.bpm.toDouble(),
              min: Constants.minBpm.toDouble(),
              max: Constants.maxBpm.toDouble(),
              onChanged: (newValue) {
                am.updateBpm(newValue.toInt());
              }),
          Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                child: Center(
                    child: Text(
                  "CLICK",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: am.isClickPlaying ? Colors.green : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                onTap: () => am.toogleClick(),
              )),
              Expanded(
                  child: InkWell(
                child: const Center(
                    child: Text(
                  "NEW",
                  style: Constants.submitTextStyle,
                )),
                onTap: () => am.populateExercise(),
              )),
              Expanded(
                  child: InkWell(
                child: Center(
                    child: Text(
                  "AUTO",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: am.isAutomaticIncreasmentOn
                        ? Colors.green
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                onTap: () => am.toogleAutoIncreasment(),
              )),
            ],
          ),
        ],
      ),
    ));
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
