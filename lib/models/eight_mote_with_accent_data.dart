import 'dart:math';

abstract class ExerciseModel {
  static String sixteenNotes =
      "RLrrrrrrLRllllll,RlRLrrrrLrLRllll,RlRlrLrrLrrrrrrr,LrLrlRllRlllllll,"
      "RrrrLRllLlllRLrr,rrrrLrLrllllRlRl,rLrrLrrrrrrrRlRl,lRllRlllllllLrLr,"
      "RlrrLlllRlrrLlll,LrllRrrrLrllRrrr,RlrrLlllLrllRrrr,RllllllLrrrrRlll,"
      "rLrrLrllRrrrRrrr,LrllrLrrLlllLlll,RlrrLrllRrrRrrRr,LrllRlrrlLllLllL,"
      "RlrrlRllRrrrrRrr,LrllrLrrLllllLll,RlRlrrLrLrllLlll,LrLrllRLRlrrRrrr,"
      "RlRlrrLlLlllLlll,rlRlrLrrllLllLll,lrLrlRllrrRrrRrr,rrllRlrrllrrLrll,"
      "RllllRllRlllRlrr,LrrrrLrrLrrrLrll,RlllLrrrRlllLrrr,LLLrLLLrlRlRRlRR,"
      "RlRRlRRlllllLrll,rrllRrrRrrllRrrR,llrrLllLllrrLllL,RlrLrlRlrrllrrll,"
      "rRllRllllLrrLrrr,RrlLrrLlRrrrrRrr,LlrRllRrLllllLll,RLrrLRllRlRLrrrr,"
      "LRllRLrrLrLRllll,RlRRRlRRRlRRRlrr,LrLLLrLLLrLLLrll,RlRRRlrrLrLLLrll,LrllrLrrLllLllLl,llllLrllllLrlRll,rrrrRlrrrrRlrLrr,RlrrlRllrrrrrrrr,RllRLrrrLrrLRLLL,rrLrllllllRlrrrr,RlrlLrrrLrlrRlll,RlllllRllllRllll";

  static List<String> sixteenNotesPatternList = sixteenNotes.split(",");
  static List<String> eightNotesPatternList = [];
  static List<String> fourNotesPatternList = [];

  static Future<void> splitToEightNotes() async {
    for (int i = 0; i < sixteenNotesPatternList.length; i++) {
      eightNotesPatternList.add(sixteenNotesPatternList[i].substring(0, 8));
      eightNotesPatternList.add(sixteenNotesPatternList[i].substring(8, 16));
    }
  }

  static Future<void> splitToFourNotes() async {
    for (int i = 0; i < eightNotesPatternList.length; i++) {
      fourNotesPatternList.add(eightNotesPatternList[i].substring(0, 4));
      fourNotesPatternList.add(eightNotesPatternList[i].substring(4, 8));
    }
  }

  static String randomSixteenNotes()  {
    List<String> temp = [];
    String stringExercise = "";
    Random r = Random();
    for (var i = 0; i < 4; i++) {
      temp.add(fourNotesPatternList[r.nextInt(fourNotesPatternList.length)]);
    }
    stringExercise = temp.join("");

    return stringExercise;
  }
}
