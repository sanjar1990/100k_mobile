import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/models/response_model.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';

import '../base/show_custom_snackbar.dart';
import '../utils/dimensions.dart';
import 'app_text_field.dart';

class UpdatePassword extends StatelessWidget {
  final TextEditingController newPasswordOne;
  final TextEditingController newPasswordTwo;
  final TextEditingController oldPassword;
  const UpdatePassword({super.key, required this.newPasswordOne, required this.newPasswordTwo, required this.oldPassword});
  void _changePassword(UserController userController)async{
   if(oldPassword.text.trim().isEmpty){
     showCustomSnackBar(message: 'type your old password', title: 'password');
   } else if(newPasswordTwo.text.trim().isEmpty){
      showCustomSnackBar(message: 'type your new password', title: 'password');
    }else if(newPasswordOne.text.trim().length<6){
      showCustomSnackBar(
          message: 'Password length should be more then 6', title: 'password');
    }else if(newPasswordOne.text!=newPasswordTwo.text){
      showCustomSnackBar(
          message: 'Password not match', title: 'password');
    }else{
      ResponseModel responseModel=await userController.changePassword(oldPassword.text, newPasswordOne.text);
      if(responseModel.isError){
        showCustomSnackBar(message: responseModel.message);
      }else{
        showCustomSnackBar(message: responseModel.message);
        Get.offAndToNamed(RouteHelper.getSignIn());
        userController.logout();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) =>
        Center(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: Dimensions.height20),
                child: Text('Change your password',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,

                  ),
                ),
              ),
              AppTextField(isObscure: false,
                  keyBoardType: TextInputType.emailAddress,
                  textController: oldPassword,
                  hintText:'Enter old Password' ,
                  icon: Icons.password),
              SizedBox(height: Dimensions.height20,),
              AppTextField(isObscure: false,
                  keyBoardType: TextInputType.emailAddress,
                  textController: newPasswordOne,
                  hintText:'Enter new Password' ,
                  icon: Icons.password),
              SizedBox(height: Dimensions.height20,),
              AppTextField(isObscure: false,
                  keyBoardType: TextInputType.emailAddress,
                  textController: newPasswordTwo,
                  hintText:'Enter password again' ,
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
                child: TextButton(onPressed: (){_changePassword(userController);},
                  child: Text('Change password', style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Colors.pinkAccent
                  ), ),),
              ),
            ],
          ),
        )
    );
  }
}
