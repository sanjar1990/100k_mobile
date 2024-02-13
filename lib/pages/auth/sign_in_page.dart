
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/controller/auth_controller.dart';
import 'package:yuzk_mobile/pages/auth/sign_up_page.dart';
import 'package:yuzk_mobile/pages/home/main_page.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/widgets/app_text_field.dart';

import '../../base/show_custom_snackbar.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    Future<void> login(AuthController authController) async {
    String email=emailController.text;
    String password=passwordController.text;
    if(email.trim().isEmpty){
      showCustomSnackBar(message: 'Type in your email', title: 'email');

    }else if(email.trim().isEmpty || !email.contains('@')){
      showCustomSnackBar(message: 'Type in valid email address', title: 'Valid Email address');

    }else if(password.trim().isEmpty){
      showCustomSnackBar(message: 'Type in your password', title: 'Password');

    }else if(password.trim().length<6){
      showCustomSnackBar(message: 'Password can not be less then 6 characters', title: 'Password');
    } else{
        authController.login(email, password).then((status) {
          print('status: ${status.message}');
          if(!status.isError){
            if(status.message.toLowerCase()=='role_customer'){

              Get.offAndToNamed(RouteHelper.getInitial());
            }else if(status.message.toLowerCase()=='role_admin'){
              Get.offAndToNamed(RouteHelper.getAdminAccount());
            }

          }else{
            showCustomSnackBar(message: status.message);
          }
        });
    }
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: GetBuilder<AuthController>(builder: (authController)=>
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  Center(
                    child: Container(
                      height: Dimensions.height30 * 6,
                      width: Dimensions.width30 * 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/splash_cart.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Sign into your account',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black54, fontSize: Dimensions.font20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20 * 2,
                  ),
                  AppTextField(
                      isObscure: false,
                      keyBoardType: TextInputType.emailAddress,
                      textController: emailController,
                      hintText: 'Email',
                      icon: Icons.email),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextField(
                      isObscure: true,
                      keyBoardType: TextInputType.text,
                      textController: passwordController,
                      hintText: 'Password',
                      icon: Icons.password),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                    ],
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  //button
                 Container(
                    height: Dimensions.screenHeight / 13,
                    width: Dimensions.screenWidth / 2,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.white),
                    child:  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) =>
                              Theme.of(context).colorScheme.outlineVariant)),
                      onPressed: () {
                        login(authController);
                      },
                      child: Center(
                        child:  authController.isLoading? const CircularProgressIndicator():  Text('Sign in',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black54, fontSize: Dimensions.font20),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(SignUpPage(),
                                  transition: Transition.fadeIn),
                            text: 'Create',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.outlineVariant,
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),)
    );
  }
}
