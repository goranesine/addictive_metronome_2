
import 'package:addictive_metronome_2/models/eight_mote_with_accent_data.dart';
import 'package:addictive_metronome_2/pages/home_page.dart';
import 'package:addictive_metronome_2/services/ogg_player.dart';
import 'package:addictive_metronome_2/services/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:addictive_metronome_2/models/triplets_with_accents_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ExerciseModel.splitToEightNotes();
  await ExerciseModel.splitToFourNotes();
  TripletsWithAccentsExerciseData.splitToTwelveNotes();
  TripletsWithAccentsExerciseData.splitToSixNotes();
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
          useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(background: Color(0xff292929)),

      ),
      home:  HomePage(),
    );
  }
}

