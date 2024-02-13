import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/base/custom_loader.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/manage_customer/manage_customer.dart';
import 'package:yuzk_mobile/manage_customer/model/profile_pagination.dart';
import 'package:yuzk_mobile/models/staff_model.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/widgets/image_input.dart';
import '../controller/attach_controller.dart';
import '../enums/gender_enum.dart';
import '../enums/profile_role.dart';
import '../enums/profile_status.dart';
import '../models/photo_data.dart';
import '../person.dart';
import '../utils/dimensions.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
class UpdateCustomer extends StatefulWidget {
  final Content person;
  final int index;
  const UpdateCustomer({super.key, required this.person, required this.index});

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _phoneController=TextEditingController();
  File? _selectImage;
  DateTime? _birthDay;
  Gender? _gender;
  ProfileRole? _role;
  ProfileStatus? _status;
  bool? _visible;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
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

  void _updateStaff(UserController userController)async{
    var person=widget.person;



    if(_nameController.text.trim().isNotEmpty){
      person.name=_nameController.text;
    }
    if(_emailController.text.trim().isNotEmpty){
      person.email=_emailController.text;
    }
    if(_phoneController.text.trim().isNotEmpty){
      person.phone=_phoneController.text;
    }
    if(_gender!=null){
      person.gender=Gender.values.firstWhere((element) => element==_gender).name;
    }
    if(_role!=null){
      person.role=_role.toString().toUpperCase();
    }
    if(_status!=null){
      person.status=_status.toString().toUpperCase();
    }
    if(_visible!=null){
      person.visible=_visible!;
    }
    if(_birthDay!=null){
      person.birthDate=_birthDay!;
    }

    if(_emailController.text.isNotEmpty&& !_emailController.text.contains('@')){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text('Invalid input'),
        content:  Text('Enter valid email'  ,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: Dimensions.font20,
              color: Colors.black87
          ),),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(ctx).pop();
          }, child: const Text('okay',style:TextStyle(color: Colors.black87),))
        ],
      ));
      return;
    }


    person.attachUrl='';
    if(_selectImage!=null){
      PhotoData photoData= await Get.find<AttachController>().saveAttach(_selectImage!);
      person.attachUrl=photoData.id;
    }
    userController.updateCustomer(person,).then((status){
      if(status.isError){
        showCustomSnackBar(message: status.message);
      }else{
       Navigator.of(context).pop();

      }


    });





  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController)=>
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(padding: EdgeInsets.all(Dimensions.height15).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom
          ),
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Center(child: ImageInput(onPickImage: (image){_selectImage=image;},isCreateStaff: true,isUpdate: true, attachUrl: widget.person.attachUrl,),),
                TextField(
                  controller: _nameController,
                  maxLength: 50,

                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.redAccent,
                      fontSize: Dimensions.font20
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                      counterStyle: TextStyle(color: Colors.black87),
                      labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: Dimensions.font26
                      ),
                      label: const Text('name: '),
                      hintText: widget.person.name
                  ),
                ),
                TextField(
                  controller: _emailController,

                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.redAccent,
                      fontSize: Dimensions.font20
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: Dimensions.font26

                      ),
                      label: const Text('email: '),
                      hintText: widget.person.email
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.redAccent,
                      fontSize: Dimensions.font20
                  ),
                  keyboardType: TextInputType.number,

                  decoration:  InputDecoration(

                    prefixText: '+998 ',
                    prefixStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.red,
                        fontSize: Dimensions.font20
                    ),
                    label: const Text('phone: '),
                    hintText: widget.person.phone,
                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontSize: Dimensions.font26

                    ),
                  ),
                ),

                SizedBox(height: Dimensions.height20,),
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
                              ? formatter.format(widget.person.birthDate)
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
                SizedBox(height: Dimensions.height20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //gender
                    Container(
                      alignment: Alignment.center,

                      height: Dimensions.height45+20,
                      width: Dimensions.height20*8,
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
                    //status
                    Container(
                      alignment: Alignment.center,

                      height: Dimensions.height45+20,
                      width: Dimensions.height20*8,
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

                        value: _role,
                        underline: Text(''),
                        icon:Icon(Icons.arrow_drop_down_outlined, color:  Colors.black54, size: 30,) ,
                        hint:
                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: Dimensions.height10),
                              child: Icon(Icons.cases),
                            ),
                            Text('Role', style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black54),),
                          ],
                        ),
                        items: ProfileRole.values
                            .map((role) => DropdownMenuItem(
                          value: role,
                          child: Row(
                            children: [
                              Text(role.name.toUpperCase(), style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ))

                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _role=value as ProfileRole?;
                          });

                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height20,),
                //status, visible
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //gender
                    Container(
                      alignment: Alignment.center,

                      height: Dimensions.height45+20,
                      width: Dimensions.height20*8,
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

                        value: _status,
                        underline: Text(''),
                        icon:Icon(Icons.arrow_drop_down_outlined, color:  Colors.black54, size: 30,) ,
                        hint:
                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: Dimensions.height10),
                              child: const Icon(Icons.switch_account),
                            ),
                            Text('Status', style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black54),),
                          ],
                        ),
                        items: ProfileStatus.values
                            .map((status) => DropdownMenuItem(
                          value: status,
                          child: Row(
                            children: [
                              Text(status.name.toUpperCase(), style: const TextStyle(color: Colors.black),),
                            ],
                          ),
                        ))

                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _status=value as ProfileStatus?;
                          });

                        },
                      ),
                    ),
                    //status
                    Container(
                      alignment: Alignment.center,

                      height: Dimensions.height45+20,
                      width: Dimensions.height20*8,
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

                        value: _visible,
                        underline: Text(''),
                        icon:Icon(Icons.arrow_drop_down_outlined, color:  Colors.black54, size: 30,) ,
                        hint:
                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: Dimensions.height10),
                              child: Icon(Icons.visibility),
                            ),
                            Text('Visible', style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black54),),
                          ],
                        ),
                        items: [true, false]
                            .map((visible) => DropdownMenuItem(
                          value: visible,
                          child: Row(
                            children: [
                              Icon( visible? Icons.visibility: Icons.visibility_off),
                              SizedBox(width: 5,),
                              Text(visible.toString(), style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ))

                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _visible=value as bool;
                          });

                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.03,
                ),
                //button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                      child:  Text('Close', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: Dimensions.font20,
                          color: Colors.black87
                      ),)),
                    SizedBox(width: Dimensions.width20,),
                    ElevatedButton(
                      onPressed: (){
                        _updateStaff(userController);
                      },

                      child: Center(
                          child:  userController.isLoading? const CustomLoader():
                          Text('Update' , style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: Dimensions.font20,

                          ),)
                      ),
                    ),


                  ],
                ),

              ],
            ),

          ),
        )
    );

  }
}
