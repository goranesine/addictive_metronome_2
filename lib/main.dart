import 'dart:async';

import 'package:addictive_metronome_2/models/exercise_model.dart';
import 'package:addictive_metronome_2/models/metronome_model.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

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
  double value = 60.0;
  late StreamSubscription<Signal> _stream;



  void on<Signal>(Signal s) => setState(() {

  });

  @override
  void initState() {
    _stream = EightNoteWithAccentsModel.listen(on);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4),
            itemCount: am.playingPattern.length,
            itemBuilder: (BuildContext ctx, index) {
              return Text(am.playingPattern[index],textScaleFactor: 5,style:
              index== am.beatPosition ?
              TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent): TextStyle(fontWeight: FontWeight.normal),);
            }),
        ),
    ),
            ElevatedButton(
                onPressed: () => am.toogleClick(),
                child: const Text("Click on/off")),
            Slider(
                value: value,
                min: 60.0,
                max: 120.0,
                divisions: 10,
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                  am.updateBpm(newValue.toInt());
                }),
            ElevatedButton(
                onPressed: () => am.toogleMetronome(),
                child: const Text("Start/Stop")),
            ElevatedButton(
                onPressed: () {
                  am.populateExercise();
                  Future.delayed(
                      const Duration(seconds: 1), () => setState(() {}));
                },
                child: const Text("Random Exercise")),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
