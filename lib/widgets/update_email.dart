import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/models/EmailVerificationModel.dart';
import 'package:yuzk_mobile/models/response_model.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/widgets/app_text_field.dart';

import '../utils/dimensions.dart';

class UpdateEmail extends StatelessWidget {
  final TextEditingController newEmail;
  final TextEditingController verificationCode;
  final TextEditingController passwordController;

  const UpdateEmail({super.key, required this.newEmail, required this.verificationCode, required this.passwordController});

  void _sendVerificationCode(UserController userController)async{

    if(newEmail.text.isEmpty) {
      showCustomSnackBar(message: 'Type in your email', title: 'email');
    }else if(!newEmail.text.contains("@")){
      showCustomSnackBar(message: 'Type in valid email address', title: 'email');
    }else{
      ResponseModel responseModel=await userController.sendVerificationCode(newEmail.text);
      showCustomSnackBar(message: responseModel.message);
    }
  }
  void _verifyCode(UserController userController)async{
    if(verificationCode.text.trim().isEmpty){
      showCustomSnackBar(message: 'Enter verification code', title: 'Verification code');
    }else if(passwordController.text.trim().isEmpty){
      showCustomSnackBar(message: 'Enter password ', title: 'Password');
    }else{
      EmailVerificationModel model=EmailVerificationModel(newEmail: newEmail.text,
          verificationCode: verificationCode.text, password: passwordController.text);
     ResponseModel responseModel= await userController.verifyEmail(model);
     if(responseModel.isError){
       showCustomSnackBar(message: responseModel.message);
     }else{
       showCustomSnackBar(message: responseModel.message, title: "Verified");
        Get.offAndToNamed(RouteHelper.getSignIn());
       userController.logout();
     }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController)=>
      Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: Dimensions.height20),
          child: Text('Enter new Email',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,

            ),
          ),
        ),
        AppTextField(isObscure: false,
            keyBoardType: TextInputType.emailAddress,
            textController: newEmail,
            hintText:'Enter email' ,
            icon: Icons.email),
        Container(
          height: Dimensions.height20*3,

          margin: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height15),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              border: Border.all(width: 1, color: Colors.black38),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(1, 1),
                    color: Colors.black.withOpacity(0.2)
                )
              ]
          ),
          child: TextButton(onPressed: (){ _sendVerificationCode(userController);},

            child: Text('Send verification code', style: TextStyle(
                fontSize: Dimensions.font20,
                color: Colors.pinkAccent
            ), ),),
        ),
        AppTextField(isObscure: false,
            keyBoardType: TextInputType.number,
            textController: verificationCode,
            hintText:'Enter verification code' ,
            icon: Icons.security),
        SizedBox(height: Dimensions.height20,),
        AppTextField(isObscure: true,
            keyBoardType: TextInputType.text,
            textController: passwordController,
            hintText:'Enter your password' ,
            icon: Icons.password),
        Container(
          height: Dimensions.height20*3,

          margin: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height15),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              border: Border.all(width: 1, color: Colors.black38),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(1, 1),
                    color: Colors.black.withOpacity(0.2)
                )
              ]
          ),
          child: TextButton(onPressed: (){_verifyCode(userController);},
            child: Text('SUBMIT', style: TextStyle(
                fontSize: Dimensions.font20,
                color: Colors.pinkAccent
            ), ),),
        ),
      ],
    )    ) ;
  }
}
