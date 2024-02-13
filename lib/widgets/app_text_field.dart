import 'package:flutter/material.dart';
import 'package:yuzk_mobile/utils/colors.dart';

import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final bool isObscure;
  final TextInputType keyBoardType;
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool textCapitalisation;
  const AppTextField({super.key,
    required this.isObscure,
    required this.keyBoardType,
    required this.textController,
    required this.hintText,
    required this.icon,
  this.textCapitalisation=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.black.withOpacity(0.2)
            )
          ]
      ),
      child:TextField(

        textCapitalization: textCapitalisation? TextCapitalization.sentences:TextCapitalization.none,
obscureText: isObscure,
keyboardType: keyBoardType,
        controller: textController,
    decoration: InputDecoration(
      hintText:hintText,
    prefixIcon:Icon(icon, color: Colors.yellow,),

        focusedBorder:OutlineInputBorder(
borderRadius: BorderRadius.circular(Dimensions.radius30),
          borderSide:const BorderSide(width: 1, color: Colors.white)
    ),
      enabledBorder:OutlineInputBorder(
borderRadius: BorderRadius.circular(Dimensions.radius30),
borderSide: BorderSide(width: 1, color: Colors.white)
      ),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(Dimensions.radius15)
)
    ),


      ),
    );
  }
}
