
import 'package:addictive_metronome_2/models/eight_mote_with_accent_data.dart';
import 'package:addictive_metronome_2/pages/home_page.dart';
import 'package:addictive_metronome_2/pages/metronome_page.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:addictive_metronome_2/services/router.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: SimpleRouter.getKey(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}

