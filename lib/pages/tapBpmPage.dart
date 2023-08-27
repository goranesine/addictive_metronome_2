import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/metronome_model.dart';
import '../services/streams.dart';


class TapBpmPage extends StatefulWidget {

  const TapBpmPage({Key? key}) : super(key: key);

  @override
  State<TapBpmPage> createState() => _TapBpmPageState();
}

class _TapBpmPageState extends State<TapBpmPage> {
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

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: height / 2,
              child: GestureDetector(
                onTap: () {
                  mm.switchOnOff();
                  mm.tapList.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "PLAY",
                  style: TextStyle(
                    fontFamily: "Digital",
                    fontSize: width / 10,
                    color: Colors.greenAccent,
                  ),
                ),
              )),
          Positioned(
            left: width / 3,
            bottom: height / 4,
            child:
              Text(
                    mm.tempoInBpm.toString(),
                    style: TextStyle(
                      fontFamily: "Digital",
                      fontSize: width / 3,
                      color: Colors.greenAccent,
                    ),

                )),

          Positioned(
              left: width / 3,
              bottom: 0,
              child: GestureDetector(
                onTap: () => mm.tapTempo(),

                child: Container(
                  height: width,
                  width: width,
                  color: Colors.transparent,
                ),
              )),
        ],
      ),
    );
  }
}
