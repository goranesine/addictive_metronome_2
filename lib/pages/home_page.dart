
import 'package:addictive_metronome_2/pages/eight_note_with_accents_page.dart';
import 'package:addictive_metronome_2/pages/metronome_page.dart';
import 'package:addictive_metronome_2/services/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed:()=> SimpleRouter.forward(MetronomePage()),
              child: Text("METRONOME")),
          ElevatedButton(onPressed:()=>SimpleRouter.forward(EightNoteWithAccentsPage()),
              child: Text("EIGHT NOTE WITH ACCENT")),
        ],
      ),
    );
  }


}