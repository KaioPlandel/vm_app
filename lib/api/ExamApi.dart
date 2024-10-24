import 'dart:math';

import 'IExamApi.dart';

class ExamApiImpl extends IExamApi {
  static final ExamApiImpl _mInstance = ExamApiImpl._internal();

  ExamApiImpl._internal();

  static ExamApiImpl get instance => _mInstance;

  @override
  List<int> getRandomNumbers(int quantity) {
    var lRandomNumbers = <int>{};
    if (quantity > 100) throw Exception("Não é possível gerar mais de 100 números.");
    while (lRandomNumbers.length < quantity) {
      lRandomNumbers.add(Random().nextInt(100));
    }
    return lRandomNumbers.toList();
  }

  @override
  bool checkOrder(List<int> aNumbers) {
    for (var i = 0; i < aNumbers.length - 1; i++) {
      if (aNumbers[i] > aNumbers[i + 1]) {
        return false;
      }
    }
    return true;
  }
}
