
import 'dart:async';

import 'package:addictive_metronome_2/pages/tapBpmPage.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/metronome_model.dart';
import '../services/streams.dart';

class MetronomePage extends StatefulWidget {
  const MetronomePage({Key? key}) : super(key: key);

  @override
  State<MetronomePage> createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  final mm = MetronomeModel();
  late StreamSubscription<Signal> metronomeStream;
  late StreamSubscription<SignalForGuiUpdate> guiUpdateStream;

  void on<Signal>(Signal s) => setState(() {
  });

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
    mm.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      body: Stack(
        children: [
          /// beat grid
          Positioned(top: 5, left: 0, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                height: height / 3,
                child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mm.listLength,
                      itemBuilder: (BuildContext context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onHorizontalDragEnd: (dragEndDetails) {
                                if (dragEndDetails.primaryVelocity! < 0) {
                                  mm.addBeat();
                                } else if (dragEndDetails.primaryVelocity! > 0) {
                                  mm.removeBeat();
                                }
                              },
                              onTap: () => mm.setBeatAccent(index),
                              child: ClayContainer(
                                  borderRadius: 50,
                                  depth: 20,
                                  emboss: mm.beatStatusList[index] ? true : false,
                                  curveType: mm.beatStatusList[index] ? CurveType.concave : CurveType.convex,
                                  height: 100,
                                  width: width / mm.listLength - 16,
                                  color: Color(0xff292929),
                                  child: beatIcon(mm.listLength,index),

                              ),
                            ),
                          )),

              ),
            ],
          )),

          /// separator
          Positioned(
              left: 0,
              top: (height / 100) * 37,
              child: ClayContainer(
                color: Theme.of(context).colorScheme.background,
                width: width,
                height: height / 100,
                emboss: true,
              )),

          /// bpm display box
          Positioned(
            left: (width / 100) * 69,
            top: (height / 100) * 50,
            child: ClayContainer(
              color: Theme.of(context).colorScheme.background,
              width: width / 6,
              height: height / 3,
              emboss: true,
            ),
          ),

          /// step text
          Positioned(
            left: (width / 100) * 68,
            top: (height / 100) * 40.5,
            child: const Text(
              "STEP",
              style: TextStyle(
                  letterSpacing: 18.0,
                  color: Colors.greenAccent,
                  fontSize: 20.0,
                  fontFamily: "Digital",
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// auto text
          Positioned(
            left: (width / 100) * 35,
            top: (height / 100) * 40.5,
            child: const Text(
              "AUTO",
              style: TextStyle(
                  letterSpacing: 15.0,
                  color: Colors.greenAccent,
                  fontSize: 20.0,
                  fontFamily: "Digital",
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// bpm text
          Positioned(
            left: (width / 100) * 71,
            top: (height / 100) * 85.5,
            child: const Text(
              "BPM",
              style: TextStyle(
                  letterSpacing: 15.0,
                  color: Colors.greenAccent,
                  fontSize: 20.0,
                  fontFamily: "Digital",
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// pilot text
          Positioned(
            left: (width / 100) * 35.5,
            top: (height / 100) * 85.5,
            child: const Text(
              "PILOT",
              style: TextStyle(
                  letterSpacing: 12.0,
                  color: Colors.greenAccent,
                  fontSize: 20.0,
                  fontFamily: "Digital",
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// step increaser
          Positioned(
              left: (width / 100) * 88,
              top: (height / 100) * 50,
              child: GestureDetector(
                onTap: () => mm.stepIncreaser(),
                child: ClayContainer(
                  color: Theme.of(context).colorScheme.background,
                  child: Icon(
                    Icons.add,
                    color: Colors.greenAccent,
                    size: width / 16,
                  ),
                ),
              )),

          /// step decreaser
          Positioned(
              left: (width / 100) * 60,
              top: (height / 100) * 50,
              child: GestureDetector(
                onTap: () => mm.stepDecreaser(),
                child: ClayContainer(
                  color: Theme.of(context).colorScheme.background,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.remove,
                      color: Colors.redAccent,
                      size: width / 16,
                    ),
                  ),
                ),
              )),

          /// bpm decreaser
          Positioned(
              left: (width / 100) * 60,
              top: (height / 100) * 69,
              child: GestureDetector(
                onTap: () => mm.decreaseTempo(),
                onLongPress: (){
                  mm.activateLongPress();
                  mm.decreaseTempo();
                },
                onLongPressUp: ()=> mm.deactivateLongPress(),
                child: ClayContainer(
                  color: Theme.of(context).colorScheme.background,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.remove,
                      color: Colors.redAccent,
                      size: width / 16,
                    ),
                  ),
                ),
              )),

          /// bpm increaser
          Positioned(
              left: (width / 100) * 88,
              top: (height / 100) * 69,
              child: GestureDetector(
                onTap: () => mm.increaseTempo(),
                onLongPress: (){
                  mm.activateLongPress();
                  mm.increaseTempo();
                },
                onLongPressUp: ()=> mm.deactivateLongPress(),
                child: ClayContainer(
                  color: Theme.of(context).colorScheme.background,
                  child: Icon(
                    Icons.add,
                    color: Colors.greenAccent,
                    size: width / 16,
                  ),
                ),
              )),

          /// bpm and step value display
          Positioned(
              left: (width / 100) * 71,
              top: (height / 100) * 48,
              child:  GestureDetector(
                onTap: (){
                  if(mm.isMetronomePlaying == true){
                    mm.switchOnOff();}

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const TapBpmPage()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(height:height/100 ,),

                    Text(mm.step.toString(),
                      style: TextStyle(
                        fontFamily: "Digital",
                        fontSize: width/14,
                        color: Colors.greenAccent,
                      ),),
                    Divider(height:height/100 ,),

                    Text(mm.tempoInBpm.toString(),
                      style: TextStyle(
                        fontFamily: "Digital",
                        fontSize: width/14,
                        color: Colors.greenAccent,
                      ),),
                    Divider(height:height/100 ,),

                  ],
                ),
              ),),

          /// play/stop button
          Positioned(
              left: (width / 100) * 7,
              top: (height / 100) * 65,
              child:  ClayContainer(
                color: Theme.of(context).colorScheme.background,
                child: GestureDetector(
                  onTap:()=> mm.switchOnOff(),
                  child:
                      Row(
                        children: [
                          Icon(

                            Icons.play_arrow,
                            color:
                            mm.isMetronomePlaying == true
                                && mm.tick == true
                                ? Colors.greenAccent
                                : Colors.grey,
                            size: width/10,
                          ),
                          Icon(

                            Icons.stop,
                            color:
                            mm.isMetronomePlaying == true
                                ? Colors.grey
                                : Colors.redAccent,
                            size: width/10,
                          ),
                        ],
                      ),

                ),
              )),
          /// andBeat button
          Positioned(
              left: (width / 100) * 4,
              top: (height / 100) * 45,
              child: GestureDetector(
                onTap: ()=> null,
                child:
                    Text(
                      mm.elapsedPlayingTime,
                      style: const TextStyle(
                          letterSpacing: 6.0,
                          color: Colors.greenAccent,
                          fontSize: 40.0,
                          fontFamily: "Digital",
                          fontWeight: FontWeight.bold),

                ),
              )),
          /// automatic button
          Positioned(
            left: (width / 100) * 35,
            top: (height / 100) * 50,
            child:  GestureDetector(
              onTap: ()=> mm.automaticIncreaserOnOff(),
              child:
                  ClayContainer(
                    color: Theme.of(context).colorScheme.background,
                    width: width / 6,
                    height: height / 3,
                    emboss:mm.isAutomaticIncreaserOn == false
                        ? false : true,
                    child: Icon(
                        mm.isAutomaticIncreaserOn == false
                            ?
                        Icons.airplanemode_inactive
                            :
                        Icons.airplanemode_active,
                        size: height/5,
                        color:
                        mm.isAutomaticIncreaserOn == false
                            ? Colors.grey
                            : Colors.greenAccent


                    ),
                  ),
              ),
            )

        ],
      ),
    );
  }

  Widget beatIcon(int listLength,int index) {

    double _iconSize = 350 / listLength > 350/3
        ? 350/3
        : 350 / listLength;
    if (mm.beatCounter != index) {
      return mm.beatStatusList[index] == false
          ? Icon(
        Icons.play_arrow,
        color: Colors.grey,
        size: _iconSize,
      )
          : Icon(
        Icons.offline_bolt_outlined,
        color: Colors.grey,
        size: _iconSize,
      );
    } else {
      return mm.beatStatusList[index] == false
          ? Icon(
        Icons.play_arrow,
        color: Colors.greenAccent,
        size: _iconSize,
      )
          : Icon(
        Icons.offline_bolt_rounded,
        color: Colors.redAccent,
        size: _iconSize,
      );
    }
  }
}
