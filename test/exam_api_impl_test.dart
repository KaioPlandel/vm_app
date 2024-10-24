import 'package:flutter_test/flutter_test.dart';
import 'package:vm_app/api/ExamApi.dart';

void main() {
  late ExamApiImpl examApi;

  setUp(() {
    examApi = ExamApiImpl.instance;
  });

  group('getRandomNumbers', () {
    test('Deve retornar a quantidade correta de números', () {
      int quantity = 7;
      var result = examApi.getRandomNumbers(quantity);

      expect(result.length, quantity);
    });

    test('Não deve permitir gerar mais de 100 números', () {
      expect(() => examApi.getRandomNumbers(101), throwsA(isA<Exception>()));
    });
  });

  group('checkOrder', () {
    test('Deve retornar true', () {
      var numbers = [4, 5, 6, 7, 8];
      var result = examApi.checkOrder(numbers);

      expect(result, isTrue);
    });

    test('Deve retornar false', () {
      var numbers = [5, 3, 1, 2, 4];
      var result = examApi.checkOrder(numbers);

      expect(result, isFalse);
    });

    test('Deve retornar true para uma lista com um único elemento', () {
      var numbers = [1];
      var result = examApi.checkOrder(numbers);

      expect(result, isTrue);
    });

    test('Deve retornar true para uma lista vazia', () {
      var numbers = <int>[];
      var result = examApi.checkOrder(numbers);

      expect(result, isTrue);
    });
  });
}
