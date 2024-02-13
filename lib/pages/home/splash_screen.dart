import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';

import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
late Animation<double> animation;
late AnimationController controller;
@override
  void initState() {
    super.initState();
    controller=AnimationController(vsync: this, duration: Duration(seconds:3))..forward();
    animation=CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);
    Timer(Duration(seconds: 3),()=>Get.offNamed(RouteHelper.getInitial()));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(scale: animation,
            child:  Image.asset('assets/images/100k.png', width:Dimensions.splashImg ,),),
          SizedBox(height: Dimensions.height45,),
          Center(child: Image.asset('assets/images/splash_cart.png', width: Dimensions.splashImg,))
          ],
        ),
      ),
    );
  }
}
