import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_ogg_piano/flutter_ogg_piano.dart';

abstract class OggPlayer {
static  final FlutterOggPiano fop = FlutterOggPiano();
 static Map<int, List<Float64List>> map = {};

 static List<Float64List> sounds = [];


static Future<void> initOgg()async {
  fop.init(mode: MODE.LOW_LATENCY,isStereo: false);
  loadOgg();
}
 static void loadOgg() {
    rootBundle.load("assets/tap.ogg").then((ogg) {
      fop.load(src: ogg, index: 0, name: 'tap.ogg',forceLoad: true);
    });
    rootBundle.load("assets/accent.ogg").then((ogg) {
      fop.load(src: ogg, index: 1, name: 'accent.ogg',forceLoad: true);
    });
    rootBundle.load("assets/click.ogg").then((ogg) {
      fop.load(src: ogg, index: 2, name: 'click.ogg',forceLoad: true);
    });
    rootBundle.load("assets/realAccent.ogg").then((ogg) {
      fop.load(src: ogg, index: 3, name: 'realAccent.ogg',forceLoad: true);
    });
    rootBundle.load("assets/realTap.ogg").then((ogg) {
      fop.load(src: ogg, index: 4, name: 'realTap.ogg',forceLoad: true);
    });

  }

 static void play(int id) {
    fop.play(index: id, note: 0);
  }

 static void playGroup(int numberOfNotes) {
    for (int i = 0; i < numberOfNotes; i++) {
      Float64List list = Float64List(3);

      list[0] = 0;
      list[1] = 0;
      list[2] = 3;

      sounds.add(list);
      map[i] = sounds;
    }

    fop.playInGroup(map);
  }
  static void dispose(){

  fop.release();
  }
}
