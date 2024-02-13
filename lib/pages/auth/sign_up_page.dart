import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuzk_mobile/base/custom_loader.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/controller/attach_controller.dart';
import 'package:yuzk_mobile/controller/auth_controller.dart';
import 'package:yuzk_mobile/models/SignUpBody.dart';
import 'package:yuzk_mobile/models/photo_data.dart';
import 'package:yuzk_mobile/pages/auth/sign_in_page.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/widgets/image_input.dart';
import '../../enums/gender_enum.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';

final formatter = DateFormat.yMd();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  var _selectedImageId='';
  DateTime? _birthDay;
  Gender? _gender;
  File? _selectedImage;
  void _openVerification()async {
    showModalBottomSheet(

      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Center(child: Container(padding: EdgeInsets.all(10),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Click button to verify your email', style: TextStyle(
                color:Colors.white,
            fontSize: Dimensions.font26
            ),),
            Container(
            height: 100,
              width: 100,
              decoration:  BoxDecoration(
                border: Border.all(width: 2,color: Colors.red),
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [BoxShadow(
                  offset: Offset(1, 2),
                    blurRadius: 2,
                  spreadRadius: 2
                )]
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white)
                  ),
                  onPressed: () async {

                    final Uri emailLaunchUri = Uri.parse("https://mail.google.com/mail/u/0/#inbox");

                    launchUrl(emailLaunchUri);
                    Get.offNamed(RouteHelper.getSignIn());
                  },
                  child:  Text('Verify',
                  style: TextStyle(color: Colors.red,
                  fontSize: Dimensions.font20),)),
            )
          ],
        ),))
    );
  }
  void _presentDatePicker() async {
    final now = DateTime.now();
    var pickedDate = await showDatePicker(
        builder: (ctx, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                secondary: Colors.black,
                background: Colors.white,
                primary: Colors.pinkAccent,
                // header background color
                onPrimary: Colors.black,
                // header text color
                onSurface: Colors.red, // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        firstDate: DateTime(now.year - 100,DateTime.january),
        lastDate: DateTime(now.year - 15, DateTime.january));

    setState(() {
      _birthDay = pickedDate!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  var signUpImages = [
    't.png',
    'f.png',
    'g.png',
  ];

  void _registration(AuthController authController) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    if (name.trim().isEmpty) {
      showCustomSnackBar(message: 'Type in your name', title: 'Name');
    } else if (phone.trim().isEmpty) {
      showCustomSnackBar(message: 'Type in your phone', title: 'phone');
    } else if (email.trim().isEmpty) {
      showCustomSnackBar(message: 'Type in your email', title: 'email');
    } else if (!email.contains('@')) {
      showCustomSnackBar(message: 'Type in valid email address', title: 'email');
    } else if (password.trim().isEmpty) {
      showCustomSnackBar(message: 'Type in your password', title: 'password');
    } else if (password.trim().length < 6) {
      showCustomSnackBar(
          message: 'Password length should be more then 6', title: 'password');
    } else if(_birthDay==null){
      showCustomSnackBar(
          message: 'Select birthdate', title: 'Birthdate');
  }  else if(_gender==null){
      showCustomSnackBar(
          message: 'Please pick your gender', title: 'Gender');
  } else{

      //sign up
      SignUpBody signUpBody=SignUpBody(name: name, email: email, phone: phone, password: password,
          birthDate: DateFormat('yyyy-MM-dd').format(_birthDay!).toString(),
          gender: _gender!, attachId: _selectedImageId);
      if(_selectedImage!=null){
        PhotoData photoData= await Get.find<AttachController>().saveAttach(_selectedImage!);
      _selectedImageId=photoData.id;
      }
    authController.registration(signUpBody).then((value) {
      if(value.isError){
        showCustomSnackBar(message: value.message, );
      }else{
        _openVerification();
      }
    }

    );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: GetBuilder<AuthController>(builder: (_authController)=>
        _authController.isLoading? const CustomLoader():SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                 Center(
                  child: ImageInput(onPickImage: (image){_selectedImage=image;}),
                ),

                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                    isObscure: false,
                    keyBoardType: TextInputType.emailAddress,
                    textController: _emailController,
                    hintText: 'Email',
                    icon: Icons.email),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                    isObscure: true,
                    keyBoardType: TextInputType.text,
                    textController: _passwordController,
                    hintText: 'Password',
                    icon: Icons.password),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  textCapitalisation: true,
                    isObscure: false,
                    keyBoardType: TextInputType.text,
                    textController: _nameController,
                    hintText: 'Name',
                    icon: Icons.person),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                    isObscure: false,
                    keyBoardType: TextInputType.number,
                    textController: _phoneController,
                    hintText: 'Phone',
                    icon: Icons.phone),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: Dimensions.width10),
                      height: Dimensions.height45+20,
                      width: Dimensions.height20*9,
                      margin:
                      EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(1, 1),
                              color: Colors.black.withOpacity(0.2))
                        ],
                      ),
                      child: Row(
                        children: [
                          TextButton.icon(
                            label: Text(
                      _birthDay == null
                      ? 'Select birthday'
                          : formatter.format(_birthDay!),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black54),
          ) ,
                            icon: Icon(Icons.calendar_month),
                            onPressed: _presentDatePicker,
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,

                        height: Dimensions.height45+20,
                        width: Dimensions.height20*8,
                        margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                                color: Colors.black.withOpacity(0.2))
                          ],
                        ),
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),

                          value: _gender,
                          underline: Text(''),
                          icon:Icon(Icons.arrow_drop_down_outlined, color:  Colors.black54, size: 30,) ,
                          hint:
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: Dimensions.height10),
                                child: Icon(Icons.people),
                              ),
                              Text('Gender', style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black54),),
                            ],
                          ),
                          items: Gender.values
                              .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Row(
                              children: [
                                Icon( gender==Gender.male? Icons.male: Icons.female),
                                Text(gender.name.toUpperCase(), style: TextStyle(color: Colors.black),),
                              ],
                            ),
                          ))

                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _gender=value as Gender?;
                            });

                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.03,
                ),
                //button
                Container(
                  height: Dimensions.screenHeight / 13,
                  width: Dimensions.screenWidth / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Colors.white),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                                (states) =>
                            Theme.of(context).colorScheme.outlineVariant)),
                    onPressed: (){
                      _registration(_authController);
                    },
                    child: Center(
                      child: Text('Sign up',
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
                  height: Dimensions.screenHeight * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Have an account already? ',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black54, fontSize: Dimensions.font20),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(const SignInPage(),
                                transition: Transition.fadeIn),
                          text: 'Sign in',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                            Theme.of(context).colorScheme.outlineVariant,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Sign up using one of the following methods',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black54, fontSize: Dimensions.font20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  child: Wrap(
                    spacing: Dimensions.width20,
                    children: List.generate(
                        3,
                            (index) => CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundImage: AssetImage(
                              'assets/images/${signUpImages[index]}'),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),),
    );
  }
}
