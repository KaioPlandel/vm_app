import 'package:equatable/equatable.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();
}

class GenerateNumbersEvent extends ExamEvent {
  final String quantityInput;

  const GenerateNumbersEvent({required this.quantityInput});

  List<Object?> get props => [quantityInput];
}

class ReorderNumbersEvent extends ExamEvent {
  List<int> oldListNumbers;
  final int oldIndex;
  final int newIndex;

  ReorderNumbersEvent({required this.oldListNumbers, required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldListNumbers, oldIndex, newIndex];
}

class CheckOrderEvent extends ExamEvent {
  final List<int> numbers;

  const CheckOrderEvent({required this.numbers});

  @override
  List<Object?> get props => [numbers];
}

class ResetEvent extends ExamEvent {
  @override
  List<Object?> get props => [];
}
