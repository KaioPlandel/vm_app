import 'package:equatable/equatable.dart';

abstract class ExamState extends Equatable {}

class ExamEmptyState extends ExamState {
  @override
  List<Object?> get props => [];
}

class ExamGenerateNumbersSuccessState extends ExamState {
  final List<int> randomNumbers;

  ExamGenerateNumbersSuccessState(this.randomNumbers);

  @override
  List<Object?> get props => [randomNumbers];
}

class ExamGenerateNumbersErrorState extends ExamState {
  final String messageError;

  ExamGenerateNumbersErrorState(this.messageError);

  @override
  List<Object?> get props => [messageError];
}

class ExamOrderCheckState extends ExamState {
  final List<int> randomNumbers;
  final bool isOrdered;

  ExamOrderCheckState(this.randomNumbers, this.isOrdered);

  @override
  List<Object?> get props => [randomNumbers, isOrdered];
}
