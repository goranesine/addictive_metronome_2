import 'dart:async';
import 'dart:math' as math;

import 'package:addictive_metronome_2/models/metronome_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/streams.dart';

class MetronomePage extends StatefulWidget {
  MetronomePage({super.key});

  @override
  State<MetronomePage> createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  final am = MetronomeModel();

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
    am.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width / 2,
                  height: height / 100 * 80,
                  color:
                      am.beatPosition == 0 ? Colors.black : Colors.greenAccent,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(am.playPyramidExercise ? am.numberOfSubdivisions.toString()
                        : am.bpm.toString(),style: TextStyle(color: Colors.white,fontSize: 100,fontWeight: FontWeight.bold),),

                  ],),
                ),
                GestureDetector(onDoubleTap:()=> am.decreaseSubdivision(),
                  onTap: ()=> am.increaseSubdivision(),
                  child: SizedBox(width: width/2,height: height/100*80,
                    child: ListView.builder(
                        itemCount: am.numberOfSubdivisions-1,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(width: width/2,height:
                            height/100*80/(am.numberOfSubdivisions-1),
                          color: am.beatPosition == index+1
                              ? Colors.black
                              : Constants.rainbowColors[index]);
                        }),
                  ),
                )
              ],
            ),
            Row(
              children: [
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
                Expanded(child: IconButton(
                  onPressed: () { am.tooglePiramidExercise(); },
                  icon: const Icon(Icons.temple_hindu_rounded),color:
                  am.playPyramidExercise ? Colors.greenAccent : Colors.black,)),
                Expanded(
                    child: InkWell(
                  child: Center(
                      child: Text(
                    am.isMetronomePlaying ? "STOP" : "PLAY",
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
            Expanded(
              child: Slider(
                activeColor: Colors.black,
                onChanged: (value) => am.updateBpm(value.toInt()),
                min: am.minBpm.toDouble(),
                max: am.maxBpm.toDouble(),
                divisions: 12, value: am.bpm.toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
