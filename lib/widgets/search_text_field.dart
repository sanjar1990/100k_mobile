import 'package:flutter/material.dart';
import 'package:yuzk_mobile/utils/colors.dart';

import '../utils/dimensions.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    var textController=TextEditingController();
    return TextField(

      keyboardType:TextInputType.text,
      controller: textController,

      decoration: InputDecoration(
        border: InputBorder.none,
          hintText:'searching...',
          hintStyle: TextStyle(fontSize: Dimensions.font16,
          color: AppColors.lightGrey),
          prefixIcon: Icon(Icons.search,
            color:Colors.white,
          ),


      ),
    );
  }
}
