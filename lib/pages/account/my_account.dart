import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/pages/auth/sign_in_page.dart';
import 'package:yuzk_mobile/person.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';
import 'package:yuzk_mobile/widgets/app_icon.dart';
import 'package:yuzk_mobile/widgets/app_text_field.dart';
import 'package:yuzk_mobile/widgets/location_input.dart';
import 'package:yuzk_mobile/widgets/update_email.dart';
import 'package:yuzk_mobile/widgets/update_password.dart';
import '../../widgets/account_widget.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  void _addLocation(UserController userController){
    Get.to(const LocationInput());
  }

  void handleClick(String value) async{
    switch (value) {
      case 'Logout':{
        print('LogOut++++++++++++++++++++++++++++');
        Get.find<UserController>().logout();

         }
        break;
      case 'Update': Get.toNamed(RouteHelper.getUpdateAccountPage());
      break;
      case 'Dashboard':Get.toNamed(RouteHelper.getAdminAccount());
    }
  }
  final _newEmail=TextEditingController();
  final _verificationCode=TextEditingController();
  final _passwordController=TextEditingController();
  final _newPasswordOne=TextEditingController();
  final _newPasswordTwo=TextEditingController();
  final _oldPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var role='role_customer';
var loggedIn=Get.find<UserController>().userLoggedIn();
if(loggedIn){
  role=Get.find<UserController>().person.role.toLowerCase();
}
    Widget popUp= PopupMenuButton<String>(
      onSelected: handleClick,
      itemBuilder: (BuildContext context) {
        return {'Logout', 'Update'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
    if(role=='role_admin'|| role=='role_staff'){
      popUp=PopupMenuButton<String>(
        onSelected: handleClick,
        itemBuilder: (BuildContext context) {
          return {'Logout', 'Update','Dashboard'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceTint,
      appBar: AppBar(title: role=='role_admin'?Text('ADMIN'): Text('My account'), backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      actions: [
      popUp,
      ],
      centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        print('logged in ${userController.userLoggedIn()}');
        if(userController.userLoggedIn()){
          Person person=userController.person;
          print('Person role: ++++++++++++++++++++++++++++:  ${person.role}');
            }
            return userController.userLoggedIn()
            ? SingleChildScrollView(
              child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height30),
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: Dimensions.height20*3.5,
                  backgroundImage: NetworkImage(userController.person.attachUrl),
                ),
                SizedBox(height: Dimensions.height30,),
                 AccountWidget(text: userController.person.name, icon: AppIcon(icon: Icons.person,),),
                SizedBox(height: Dimensions.height20,),
                 Stack(children: 
                 [AccountWidget(text: userController.person.email, icon: AppIcon(icon: Icons.email),),
                   Positioned(
                       top: 5,
                       right: 5,
                       child:  PopupMenuButton<String>(
                         onSelected: (value){
                           if(value=='Update email'){
                             showModalBottomSheet(context: context,
                                 useSafeArea: true,
                                 isScrollControlled: true,
                                 backgroundColor: Colors.white,
                                 builder: (context){

                               return UpdateEmail(newEmail: _newEmail, verificationCode: _verificationCode, passwordController: _passwordController,);
                             });
                           }else if(value=='Update password'){
                             showModalBottomSheet(context: context,
                                 useSafeArea: true,
                                 isScrollControlled: true,
                                 backgroundColor: Colors.white,
                                 builder: (context){

                                   return UpdatePassword(newPasswordOne:_newPasswordOne,
                                     newPasswordTwo: _newPasswordTwo,

                                   oldPassword: _oldPasswordController,);
                                 });
                           }
                     
                         },
                         itemBuilder: (BuildContext context) {
                           return { 'Update email', 'Update password'}.map((String choice) {
                             return PopupMenuItem<String>(
                               value: choice,
                               child: Text(choice),
                             );
                           }).toList();
                         },
                       ),)
                 ]
                 ),
                SizedBox(height: Dimensions.height20,),
                AccountWidget(text: userController.person.phone, icon: AppIcon(icon: Icons.phone),),
                SizedBox(height: Dimensions.height20,),
                AccountWidget(text: DateFormat('yyyy-MM-dd').format(userController.person.birthDate).toString(), icon: const AppIcon(icon: Icons.date_range),),
                SizedBox(height: Dimensions.height20,),
                AccountWidget(text:userController.person.gender, icon:  AppIcon(icon: userController.person.gender=='male'?Icons.male:Icons.female),),
                SizedBox(height: Dimensions.height20,),
                 InkWell(
                     onTap: (){_addLocation(userController);},
                     child:  const AccountWidget(text: 'Address',
                       icon: AppIcon(icon: Icons.location_on),),
                 ),
                SizedBox(height: Dimensions.height20,),
                 const AccountWidget(text: 'Message', icon: AppIcon(icon: Icons.message),),
                SizedBox(height: Dimensions.height20,),
                  InkWell(
                     onTap: userController.logout,
                     child: AccountWidget(text: 'Logout', icon: AppIcon(icon: Icons.logout),)),
                SizedBox(height: Dimensions.height20,),
              ],),
                      ),
            )
            :const Center(child: SignInPage(),);

      },)
    );
  }
}
