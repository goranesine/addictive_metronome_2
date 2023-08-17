import 'package:flutter/material.dart';

class Constants{
  static const submitTextStyle = TextStyle(
      fontSize: 30,
      letterSpacing: 1,
      color: Colors.black,
      fontWeight: FontWeight.bold);
static const int maxBpm = 120;
static const int minBpm = 60;
static const int bpmAutomaticIncrementValue = 5;
  List<Color> ash = [
    const Color(0xFF606c88),
    const Color(0xFF3f4c6b),
  ];

  List<Color> winter = [
    const Color(0xFFE6DADA),
    const Color(0xFF274046),
  ];
   final Color border = const Color(0xFF616161);
  final textStyle = const TextStyle(
    fontFamily: "Digital",
    fontSize: 30,
    color: Colors.greenAccent,
  );

  final String eightNoteAccents = "RLrrrrrrLRllllll,RlRLrrrrLrLRllll,RlRlrLrrLrrrrrrr,LrLrlRllRlllllll,"
      "RrrrLRllLlllRLrr,rrrrLrLrllllRlRl,rLrrLrrrrrrrRlRl,lRllRlllllllLrLr,"
      "RlrrLlllRlrrLlll,LrllRrrrLrllRrrr,RlrrLlllLrllRrrr,RllllllLrrrrRlll,"
      "rLrrLrllRrrrRrrr,LrllrLrrLlllLlll,RlrrLrllRrrRrrRr,LrllRlrrlLllLllL,"
      "RlrrlRllRrrrrRrr,LrllrLrrLllllLll,RlRlrrLrLrllLlll,LrLrllRLRlrrRrrr,"
      "RlRlrrLlLlllLlll,rlRlrLrrllLllLll,lrLrlRllrrRrrRrr,rrllRlrrllrrLrll,"
      "RllllRllRlllRlrr,LrrrrLrrLrrrLrll,RlllLrrrRlllLrrr,LLLrLLLrlRlRRlRR,"
      "RlRRlRRlllllLrll,rrllRrrRrrllRrrR,llrrLllLllrrLllL,RlrLrlRlrrllrrll,"
      "rRllRllllLrrLrrr,RrlLrrLlRrrrrRrr,LlrRllRrLllllLll,RLrrLRllRlRLrrrr,"
      "LRllRLrrLrLRllll,RlRRRlRRRlRRRlrr,LrLLLrLLLrLLLrll,RlRRRlrrLrLLLrll,LrllrLrrLllLllLl,llllLrllllLrlRll,rrrrRlrrrrRlrLrr,RlrrlRllrrrrrrrr,RllRLrrrLrrLRLLL,rrLrllllllRlrrrr,RlrlLrrrLrlrRlll,RlllllRllllRllll";


}