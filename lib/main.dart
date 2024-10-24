import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vm_app/ui/HomeScreen.dart';

import 'api/ExamApi.dart';
import 'api/IExamApi.dart';
import 'bloc/ExamBloc.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider<IExamApi>(
        create: (_) => ExamApiImpl.instance,
      ),
      BlocProvider<ExamBloc>(
        create: (context) => ExamBloc(context.read<IExamApi>()),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
