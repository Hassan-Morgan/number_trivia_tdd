import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/logic/number_trivia_states/number_trivia_states.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/widgets/button_widget.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/widgets/display_message_widget.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/widgets/loading_widget.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/widgets/text_feild_widget.dart';

import '../logic/number_trivia_cubit.dart';

class NumberTriviaPage extends StatelessWidget {
  NumberTriviaPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaCubit, NumberTriviaStates>(
        builder: (context, state) {
      return state.maybeWhen(
        orElse: () => const Scaffold(
          body: MessageDisplay(message: 'cannot start the app error happened'),
        ),
        loading: () => const LoadingWidget(),
        error: (error) => _displayScreen(message: error, context: context),
        initial: () =>
            _displayScreen(message: 'tap search to start', context: context),
        success: (numberTrivia) =>
            _displayScreen(message: numberTrivia.text, context: context),
      );
    });
  }

  Widget _displayScreen({
    required String message,
    required BuildContext context,
  }) {
    final cubit = BlocProvider.of<NumberTriviaCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NumberTrivia App',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MessageDisplay(message: message),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: controller,
                    onSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        cubit.getConcreteNumberTrivia(controller.text);
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      buttonName: 'search number',
                      buttonColor: Colors.blue,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.getConcreteNumberTrivia(controller.text);
                        }
                      },
                    ),
                    CustomButton(
                      buttonName: 'search number',
                      buttonColor: Colors.grey,
                      onPressed: () {
                        cubit.getRandomNumberTrivia();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
