import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/models/updateAccountBody.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import '../../controller/attach_controller.dart';
import '../../controller/user_controller.dart';
import '../../enums/gender_enum.dart';
import '../../models/photo_data.dart';
import '../../person.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/image_input.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
class UpdateAccount extends StatefulWidget {
  const UpdateAccount({super.key});

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  DateTime? _birthDay;
  Gender? _gender;
  File? _selectedImage;
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
  void _updateProfile(UserController userController)async{
    Person person=userController.person;
    late String name;
    late String phone;
    late DateTime birthDate;
    late String gender;
    if(_selectedImage!=null){
      PhotoData photoData= await Get.find<AttachController>().saveAttach(_selectedImage!);

      userController.updateAttach(photoData.id).then((status) {
        if(status.isError){
          showCustomSnackBar(message: status.message);
        }
        Get.offAndToNamed(RouteHelper.getMyAccount());
      });
    }
    if(_nameController.text.isEmpty && _phoneController.text.isEmpty && _birthDay==null && _gender==null){

      return;
    }else{
      if(_nameController.text.isNotEmpty){
        name=_nameController.text;
      }else{
        name=person.name;
      }
      if(_phoneController.text.isNotEmpty){
        phone=_phoneController.text;
      }else{
        phone=person.phone;
      }
      if(_birthDay!=null){
        birthDate=_birthDay!;
      }else{
        birthDate=person.birthDate;
      }
      if(_gender!=null){
        gender=_gender.toString();
      }else{
        gender=person.gender;
      }
      UpdateAccountBody updateAccountBody=UpdateAccountBody( name: name, phone: phone,
          birthDate:DateFormat('yyyy-MM-dd').format(birthDate).toString(),
          gender: gender);
      userController.updateProfile(updateAccountBody).then((status) {
        if(status.isError){
          showCustomSnackBar(message: status.message, title: 'UPDATED');
          print('++++++++++Error+++++++');
        }else{
          showCustomSnackBar(message: status.message, title: 'UPDATED');
          print('++++++++++Finished+++++++');
          Get.offAndToNamed(RouteHelper.getMyAccount());

        }

      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: GetBuilder<UserController>(builder: (userController){
      Person person =userController.person;
        return SingleChildScrollView(
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
                  textCapitalisation: true,
                  isObscure: false,
                  keyBoardType: TextInputType.text,
                  textController: _nameController,
                  hintText: person.name,
                  icon: Icons.person),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                  isObscure: false,
                  keyBoardType: TextInputType.number,
                  textController: _phoneController,
                  hintText: person.phone,
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
                                ? formatter.format(person.birthDate)
                                : formatter.format(_birthDay!),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black54),
                          ) ,
                          icon: const Icon(Icons.calendar_month),
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
                            Text(person.gender, style: Theme.of(context)
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
                  onPressed: (){_updateProfile(userController);},

                  child: Center(
                    child: Text('Update',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ),
                ),
              ),


            ],
          ),
        ),
      );}
    ),
    );
  }
}
