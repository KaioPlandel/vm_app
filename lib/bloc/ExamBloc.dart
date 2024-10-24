import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/IExamApi.dart';
import 'ExamEvent.dart';
import 'ExamState.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final IExamApi mExamApi;

  ExamBloc(this.mExamApi) : super(ExamEmptyState()) {
    on<GenerateNumbersEvent>(_generateNumbers);
    on<CheckOrderEvent>(_checkOrder);
    on<ReorderNumbersEvent>(_reorderNumbers);
    on<ResetEvent>(_reset);
  }

  void _reset(ResetEvent event, Emitter<ExamState> emit) {
    emit(ExamGenerateNumbersSuccessState([]));
  }

  void _generateNumbers(GenerateNumbersEvent event, Emitter<ExamState> emit) async {
    try {
      int? lQuantity;
      if (event.quantityInput.isEmpty) {
        throw Exception("O campo não pode estar vazio.");
      }

      lQuantity = int.tryParse(event.quantityInput);

      if (lQuantity == null || lQuantity <= 0) {
        throw Exception("Insira um número válido.");
      }
      var lNumbers = await mExamApi.getRandomNumbers(lQuantity);
      emit(ExamGenerateNumbersSuccessState(lNumbers));
    } catch (e) {
      emit(ExamGenerateNumbersErrorState(e.toString().replaceAll("Exception:", "")));
    }
  }

  void _checkOrder(CheckOrderEvent event, Emitter<ExamState> emit) {
    bool isOrdered = mExamApi.checkOrder(event.numbers);
    emit(ExamOrderCheckState(event.numbers, isOrdered));
  }

  void _reorderNumbers(ReorderNumbersEvent event, Emitter<ExamState> emit) {
    final List<int> reorderedNumbers = List.from(event.oldListNumbers);

    int adjustedNewIndex = event.newIndex;

    if (adjustedNewIndex > event.oldIndex) {
      adjustedNewIndex -= 1;
    }

    final item = reorderedNumbers.removeAt(event.oldIndex);
    reorderedNumbers.insert(adjustedNewIndex, item);

    emit(ExamGenerateNumbersSuccessState(reorderedNumbers));
  }
}
