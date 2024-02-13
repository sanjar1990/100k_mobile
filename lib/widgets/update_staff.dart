import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/base/custom_loader.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/models/staff_model.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/widgets/image_input.dart';
import '../controller/attach_controller.dart';
import '../models/photo_data.dart';
import '../staff.dart';
import '../utils/dimensions.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
class UpdateStaff extends StatefulWidget {
  final Staff staff;
  final int index;
  const UpdateStaff({super.key, required this.staff, required this.index});

  @override
  State<UpdateStaff> createState() => _UpdateStaffState();
}

class _UpdateStaffState extends State<UpdateStaff> {
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _phoneController=TextEditingController();
  final _passwordController=TextEditingController();
  File? _selectImage;
  DateTime? _birthDay;
  var _selectedImageId='';
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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
    String name=_nameController.text;
    String email=_emailController.text;
    String phone=_phoneController.text;
    String password=_passwordController.text;
    if(name.trim().isEmpty){
      name=widget.staff.name;
    }
    if(email.trim().isEmpty){
     email=widget.staff.email;
    }
    if(!email.contains('@')){
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
    if(phone.isEmpty){
     phone=widget.staff.phone;
    }
    if(password.trim().length<6){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text('Invalid input'),
        content:  Text('Password length should be greater then 6',
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
    _birthDay ??= widget.staff.birthDate;

      String attachUrl=widget.staff.attachUrl;
      if(_selectImage!=null){
        PhotoData photoData= await Get.find<AttachController>().saveAttach(_selectImage!);
        _selectedImageId=photoData.id;
        attachUrl=photoData.url;
      }
      StaffModel staffModel=StaffModel(name: name,
          email: email,
          phone: phone,
          password: password,
          birthDate: _birthDay!,
          attachUrl: _selectedImageId);
      userController.updateStaff(staffModel, attachUrl, widget.index).then((status){
        showCustomSnackBar(message: status.message);
        Get.offAllNamed(RouteHelper.manageStaff);
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

                Center(child: ImageInput(onPickImage: (image){_selectImage=image;},isCreateStaff: true,isUpdate: true, attachUrl: widget.staff.attachUrl,),),
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
                    hintText: widget.staff.name
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
                      hintText: widget.staff.email
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
                      hintText: widget.staff.phone,
                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontSize: Dimensions.font26

                    ),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.redAccent,
                      fontSize: Dimensions.font20
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontSize: Dimensions.font26
                    ),

                    label: const Text('password: '),
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
                              ? formatter.format(widget.staff.birthDate)
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
