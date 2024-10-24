import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vm_app/ui/widget/CustomButtonWithGradient.dart';

import '../bloc/ExamBloc.dart';
import '../bloc/ExamEvent.dart';
import '../bloc/ExamState.dart';
import '../utils/AppColors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _mCountTextController = TextEditingController();
  final _mCountFocus = FocusNode();
  var mColorBorder = Colors.white;
  final List<int> _mNumbers = [];
  late ExamBloc _mExamBloc;

  @override
  void initState() {
    super.initState();
    _mExamBloc = BlocProvider.of<ExamBloc>(context);
  }

  _generateNumbers() {
    _mExamBloc.add(GenerateNumbersEvent(quantityInput: _mCountTextController.text));
  }

  _reoderNumbers(int aOldIndex, int aNewIndex) {
    _mExamBloc.add(ReorderNumbersEvent(oldListNumbers: _mNumbers, oldIndex: aOldIndex, newIndex: aNewIndex));
  }

  _reset() {
    _mExamBloc.add(ResetEvent());
  }

  _checkOrder() {
    _mExamBloc.add(CheckOrderEvent(numbers: _mNumbers));
  }

  @override
  Widget build(BuildContext context) {
    var lSize = MediaQuery.of(context).size;
    return BlocProvider<ExamBloc>(
      create: (context) => _mExamBloc,
      child: BlocConsumer<ExamBloc, ExamState>(
        builder: (BuildContext context, ExamState state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.darkNavyBlue,
              ),
              backgroundColor: AppColors.darkNavyBlue,
              body: Stack(
                children: [
                  BlocBuilder<ExamBloc, ExamState>(
                    bloc: _mExamBloc,
                    builder: (context, state) {
                      if (_mNumbers.isNotEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(right: lSize.width * 0.03, left: lSize.width * 0.03),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Segure e arraste os itens para organizar os números em ordem crescente.",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: lSize.width * 0.04,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: lSize.width * 0.25, top: lSize.width * 0.15),
                                  child: ReorderableListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    onReorder: (oldIndex, newIndex) {
                                      _reoderNumbers(oldIndex, newIndex);
                                    },
                                    children: [
                                      for (int index = 0; index < _mNumbers.length; index++)
                                        ListTile(
                                          key: Key('$index'),
                                          title: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: lSize.width * 0.01),
                                            child: Container(
                                              height: lSize.width * 0.15,
                                              decoration: BoxDecoration(color: mColorBorder, borderRadius: BorderRadius.circular(8)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: lSize.width * 0.02,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(color: AppColors.darkGray, borderRadius: BorderRadius.circular(8)),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(lSize.width * 0.04),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          _mNumbers[index].toString(),
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white, fontWeight: FontWeight.w300, fontSize: lSize.width * 0.045),
                                                        ),
                                                        const Icon(
                                                          Icons.drag_indicator,
                                                          color: AppColors.lightPurple,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: lSize.width * 0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        onItemClick: () {
                                          _reset();
                                        },
                                        title: 'Reiniciar',
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButtonWithGradient(
                                        onButtonClick: () {
                                          _checkOrder();
                                        },
                                        title: 'Checar Ordem',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: lSize.width * 0.03),
                        child: Column(
                          children: [
                            Text(
                              "Insira a quantidade de números que deseja gerar, entre 1 e 100",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: lSize.width * 0.05,
                              ),
                            ),
                            SizedBox(height: lSize.width * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _mCountFocus,
                                    controller: _mCountTextController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'Quantidade',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: AppColors.lightPurple,
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: AppColors.lightPurple,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: AppColors.lightPurple,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.poppins(color: Colors.white),
                                    maxLength: 3,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CustomButtonWithGradient(
                                  onButtonClick: () {
                                    _generateNumbers();
                                  },
                                  title: 'Gerar Números',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ));
        },
        listener: (BuildContext context, ExamState state) {
          if (state is ExamOrderCheckState) {
            if (state.isOrdered) {
              mColorBorder = Colors.lightGreenAccent;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Parabéns os números estão em ordem crescente",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: AppColors.lightPurple,
                  duration: const Duration(seconds: 3),
                ),
              );
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Os números não estão ordenados",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                backgroundColor: AppColors.mediumGray,
                duration: const Duration(seconds: 3),
              ),
            );
            mColorBorder = Colors.red;
          }
          if (state is ExamGenerateNumbersSuccessState) {
            _mCountFocus.unfocus();
            _mCountTextController.clear();
            _mNumbers.clear();
            _mNumbers.addAll(state.randomNumbers);
          }

          if (state is ExamGenerateNumbersErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.messageError,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      ),
    );
  }
}
