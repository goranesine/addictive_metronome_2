import 'dart:async';

import 'package:addictive_metronome_2/models/pyramid_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/streams.dart';

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final am = PyramidModel();
  late StreamSubscription<Signal> metronomeStream;
  late StreamSubscription<SignalForGuiUpdate> guiUpdateStream;

  void on<Signal>(Signal s) => setState(() {
        blink = !blink;
      });

  void onGui<SignalForGuiUpdate>(SignalForGuiUpdate s) => setState(() {});
  bool blink = false;

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
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 0 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 2 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 1 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 3 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 2 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 4 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 3 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 5 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 4 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 6 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 5 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 7 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 6 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (BuildContext con, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 8 - 16,
                              height: height / 100 * 80 / 8,
                              color: am.exerciseNumber == 7 && blink
                                  ? Colors.white
                                  : Constants.rainbowColors[index],
                            ),
                          )),
                ),
                SizedBox(
                  width: width,
                  height: height / 100 * 80 / 10,
                  child: Row(
                    children: <Widget>[

                      Expanded(
                          child: InkWell(
                        child: Center(
                            child: am.isMetronomePlaying
                                ? const Text(
                                    "STOP",
                                    style: Constants.submitTextStyle,
                                  )
                                : const Text(
                                    "PLAY",
                                    style: Constants.submitTextStyle,
                                  )),
                        onTap: () => am.toogleMetronome(),
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
                ),
                SizedBox(
                  width: width,
                  child: Row(
                    children: [
                      Text(" Bpm: ${am.bpm.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.black,
                          onChanged: (value) => am.updateBpm(value.toInt()),
                          min: am.minBpm.toDouble(),
                          max: am.maxBpm.toDouble(),
                          divisions: 12,
                          value: am.bpm.toDouble(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
