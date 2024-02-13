import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppTextField2 extends StatelessWidget {
  final TextEditingController textController;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final String label;
  final bool isObscure;
  final String prefixText;
  const AppTextField2({super.key, required this.textController,
    this.textCapitalization=TextCapitalization.none,
    this.textInputType=TextInputType.text,
    required this.label,
    this.isObscure=false,
    this.prefixText='',
  });

  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding:  EdgeInsets.only(bottom: Dimensions.height15),
      child: Card(
          color: Theme.of(context).colorScheme.onBackground,
            shadowColor: Color.fromARGB(255, 91, 91, 91),
        elevation: 3,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.width15),
          child: TextField(

            controller: textController,
            textCapitalization:textCapitalization,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.redAccent,
                fontSize: Dimensions.font20
            ),
            keyboardType: textInputType,
            decoration: InputDecoration(
              border:InputBorder.none,
              prefixText:prefixText,
              counterStyle: TextStyle(color: Colors.black87),
              labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontSize: Dimensions.font26
              ),
              label: Text(label),
            ),
          obscureText: isObscure,
          ),
        ),
      ),
    );
  }
}
