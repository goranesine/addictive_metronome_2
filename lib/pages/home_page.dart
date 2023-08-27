
import 'package:addictive_metronome_2/pages/eight_note_with_accents_page.dart';
import 'package:addictive_metronome_2/pages/metronome_page.dart';
import 'package:addictive_metronome_2/pages/pyramid_page.dart';
import 'package:addictive_metronome_2/pages/triplets_with_accent_page.dart';
import 'package:addictive_metronome_2/services/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(      backgroundColor: Colors.white,

      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          ElevatedButton(onPressed:()=>SimpleRouter.forward(EightNoteWithAccentsPage()),
              child: Text("EIGHT NOTE WITH ACCENT")),
          ElevatedButton(onPressed:()=>SimpleRouter.forward(TripletsWithAccentsPage()),
              child: Text("TRIPLE NOTE WITH ACCENT")),
          ElevatedButton(onPressed:()=>SimpleRouter.forward(PyramidPage()),
              child: Text("PYRAMID EXERCISE")),
          ElevatedButton(onPressed:()=>SimpleRouter.forward(MetronomePage()),
              child: Text("METRONOME")),
        ],
      ),
    );
  }


}