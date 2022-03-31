import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;

  const CustomTextField(
      {Key? key, required this.controller, required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please enter number to search';
        }
        return null;
      },
      onFieldSubmitted: onSubmitted,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input a number',
      ),
    );
  }
}
