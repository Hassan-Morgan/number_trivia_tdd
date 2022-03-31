import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/logic/number_trivia_cubit.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/pages/number_trivia_page.dart';

import 'injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<NumberTriviaCubit>(),
        child: MaterialApp(
          home: NumberTriviaPage(),
        ));
  }
}
