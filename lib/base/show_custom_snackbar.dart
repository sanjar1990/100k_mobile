import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';

void showCustomSnackBar({required String message, String title='Error'}){
    Get.snackbar(title, message,
duration: const Duration(seconds: 4),
titleText: Text(title,style: TextStyle(color: Colors.white, fontSize: Dimensions.font20),
),
       messageText: Text(message, style: const TextStyle(color: Colors.white),),
      snackPosition:SnackPosition.TOP,
colorText: Colors.white,
backgroundColor: Colors.redAccent
    );
}