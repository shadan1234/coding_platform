import 'package:flutter/foundation.dart';

import '../pages/question_ans.dart';

class QuestionAnswerData extends ChangeNotifier{
  List<QuestionAnswerPair>? qaPair;
   void add(QuestionAnswerPair qa){
     qaPair??=[];
     qaPair?.add(qa);
     notifyListeners();
   }
}