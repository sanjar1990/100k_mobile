import 'package:flutter/material.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';
import 'package:yuzk_mobile/widgets/app_icon.dart';

class AccountWidget extends StatelessWidget {
  final String text;
  final AppIcon icon;
  const AccountWidget({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),

      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
          offset: Offset(0,2),
            blurRadius:2,
            color:Colors.black54
          )
        ]
      ),
      child: Row(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
          child: icon,
        ),
        Expanded(child: Text(text, style: TextStyle(fontSize: Dimensions.font20, color: Colors.black),overflow: TextOverflow.ellipsis,))
      ],),
    );
  }
}
