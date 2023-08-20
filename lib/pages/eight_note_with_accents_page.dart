

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/eight_note_with_accent_model.dart';
import '../services/streams.dart';

class EightNoteWithAccentsPage extends StatefulWidget {
  const EightNoteWithAccentsPage({super.key});


  @override
  State<EightNoteWithAccentsPage> createState() => _EightNoteWithAccentsPageState();
}

class _EightNoteWithAccentsPageState extends State<EightNoteWithAccentsPage> {
  final am = EightNoteWithAccentsModel();
  late StreamSubscription<Signal> metronomeStream;
  late StreamSubscription<SignalForGuiUpdate> guiUpdateStream;

  void on<Signal>(Signal s) => setState(() {});
  void onGui<SignalForGuiUpdate>(SignalForGuiUpdate s) => setState(() {});

  @override
  void initState() {
    metronomeStream = Streams.listen(on);
    guiUpdateStream = Streams.listenForGuiUpdate(onGui);
    super.initState();
  }

  @override
  void dispose() {
    metronomeStream.cancel();
    guiUpdateStream.cancel();
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
                  height: height / 100 * 60,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: am.numberOfBars),
                      itemCount: am.playingPattern.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Center(
                          child: GestureDetector(
                            onTap:()=> am.invertIndividualAccent(index),
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
                          ),
                        );
                      }),
                ),
              ),
              Row(
                children: [
                  Text(" Level: ${am.exerciseLevel.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.black,
                      onChanged: (value) => am.updateLevel(value.toInt()),
                      min: 0.0,
                      max: 2.0,
                      divisions: 2, value: am.exerciseLevel.toDouble(),
                    ),
                  ),
                ],
              ),
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
                        child:  Center(
                            child: Text(am.isMetronomePlaying? "STOP" :
                            "PLAY",
                              style: const TextStyle(
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
              Row(
                children: [
                  Text(" Bpm: ${am.bpm.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  Expanded(
                    child: Slider(
                      activeColor: Colors.black,
                      onChanged: (value) => am.updateBpm(value.toInt()),
                      min: Constants.minBpm.toDouble(),
                      max: Constants.maxBpm.toDouble(),
                      divisions: 12, value: am.bpm.toDouble(),
                    ),
                  ),
                ],
              ),
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
