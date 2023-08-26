
import 'dart:math';

abstract class TripletsWithAccentsExerciseData{
  static String twentyFourNotes = "RlrlllRlrlllRlrlllRlrlll,"
      "rrrLrlrrrLrlrrrLrlrrrlrl,"
      "RlrlrlrrrLrlRlrlrlrrrLrl,"
      "RlllRlllRlrrLrrrLrrrLrll,"
      "RllllRlllRlrLrrrrLrrrLrll,"
      "RllRllRlllllLrrLrrLrrrrr,"
      "RlrlrLrlRlllRlrlrLrlRlll,"
      "LrlrlRlrLrrrLrlrlRlrLrrr,"
      "RlrlrLrrrrrrLrlrlRllllll,"
      "rlrLllLllrlrLllLllrlRlrl,"
      "RllRllLrrLrrRllRllLrrLrr,"
      "RlrLrrLllLllLrlRllRrrRrr,"
      "RlRlrlRrrRrrLrLrlrLllLll,"
      "RRRlrlrlrLLLRRRlrlrlrLLL,"
      "RrlLrrLlrRllRrlLrrLlrRll,"
      "rrRllLrrrrrrllLrrRllllll,"
      "rrrRlrlllLrlrrrRlrlllLrl,"
      "RlllllllRRllRlllllllRRll,"
      "LrrrrrrrLLrrLrrrrrrrLLrr,"
      "RrrrLlllRrrrLlllRrrrLlll,"
      "RllRllRLRLrrLrrLrrLRLRll,"
      "rllRllrllLrrlrrLrrlrrRll,"
      "rrLrllRlrrllrrLrllRlrrll,"
      "rrllRlrllRlrllrrLrlrrLrl,"
      "RlrrLrllrrrrLrllRlrrllll,"
      "RllrrrLrlRlrLrrlllRlrLrl,"
      "RlrRlrLlrLrrLrlLrlRrlRll,"
      "RlrlrlrrllrrLrlrlrllrrll,"
      "RlrLrlRlrLrrLrlRlrLrlRll,"
      "RllLllrrLrrLRllLllrrLrrL,"
      "RlrLrlrrrLrrLrlRlrlllRll,"
      "RllLrrRllLrrRllLrrRllLrr,"
      "RlrllRllRllRLrlrrLrrLrrL,"
      "rrlrrlRlrllrllrLrlrlrlrl,"
      "rrllRllrrLrrllRllrrLrlrl,"
      "RlrllRlrlrrLRlrllRLrlrrL,RlrLllLllLllLrlRrrRrrRrr,RlrLrlRrrRrrLrlRlrLllLll,RlrLrlRlrLrlLllLllRrrRrr,RlrLrlRlrLrlRrrRrrRrrRrr,LrlRlrLrlRlrLllLllLllLll,RlrLrlRlrLrlrrRrrRrrRrrR,LrlRlrLrlRlrllLllLllLllL,RlrLrlRlrlrLllLllLRrrRrr,LrlRlrLrlrlRrrRrrRLllLll,RlrLrlrrRrrRLrlRlrllLllL,RlrLrlRlrLrlrRrrRrrRrrRr,LrlRlrLrlRlrlLllLllLllLl,RlrLrlrRrrRrLrlRlrlLllLl,rlRLllrlRLllrlRLllrlRLll";

  static List<String> twentyFourNotesPatternList = twentyFourNotes.split(",");
  static List<String> twelveNotesPatternList = [];
  static List<String> sixNotesPatternList = [];
  static void splitToTwelveNotes()  {
    for (int i = 0; i < twentyFourNotesPatternList.length; i++) {
      twelveNotesPatternList.add(twentyFourNotesPatternList[i].substring(0, 12));
      twelveNotesPatternList.add(twentyFourNotesPatternList[i].substring(12, 24));
    }
  }

  static void splitToSixNotes()  {
    for (int i = 0; i < twelveNotesPatternList.length; i++) {
      sixNotesPatternList.add(twelveNotesPatternList[i].substring(0, 6));
      sixNotesPatternList.add(twelveNotesPatternList[i].substring(6, 12));
    }
  }
  static String randomTwentyFourNotes(int r){

    String returnedStringExercise ="";
    switch(r){

      case 2:
        returnedStringExercise = randomTwentyFourNotesFromSixNotes();
        break;
      case 1:
        returnedStringExercise = randomTwentyFourNotesFromTwelveNotes();
        break;
      case 0:
        returnedStringExercise = randomTwentyFourNotesFromTwentyFourNotes();
        break;
    }
    return returnedStringExercise;
  }



  static String randomTwentyFourNotesFromSixNotes()  {
    List<String> temp = [];
    String stringExercise = "";
    Random r = Random();
    for (var i = 0; i < 4; i++) {
      temp.add(sixNotesPatternList[r.nextInt(sixNotesPatternList.length)]);
    }
    stringExercise = temp.join("");

    return stringExercise;
  }
  static String randomTwentyFourNotesFromTwelveNotes()  {

    List<String> temp = [];
    String stringExercise = "";
    Random r = Random();
    for (var i = 0; i < 2; i++) {
      temp.add(twelveNotesPatternList[r.nextInt(twelveNotesPatternList.length)]);
    }
    stringExercise = temp.join("");

    return stringExercise;
  }
  static String randomTwentyFourNotesFromTwentyFourNotes()  {
    String stringExercise = "";
    Random r = Random();
    stringExercise = twentyFourNotesPatternList[r.nextInt(twentyFourNotesPatternList.length)];
    return stringExercise;

  }
}