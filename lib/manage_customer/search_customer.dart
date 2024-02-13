import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/manage_customer/manage_customer.dart';
import '../enums/gender_enum.dart';
import '../enums/profile_role.dart';
import '../enums/profile_status.dart';
import '../models/profile_filter_model.dart';
import '../utils/dimensions.dart';
import '../widgets/app_text_field2.dart';

final formatter = DateFormat.yMd();
class SearchCustomer extends StatefulWidget {
  const SearchCustomer({super.key, required this.onSearchProfile});
  final void Function(ProfileFilterModel profile) onSearchProfile;
  @override
  State<SearchCustomer> createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _phoneController=TextEditingController();
  DateTime? _birthdayFrom;
  DateTime? _birthdayTo;
  Gender? _gender;
  ProfileRole? _role;
  ProfileStatus? _status;
  bool _visible=true;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  void _datePickerFrom() async {
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
        initialDate: DateTime(now.year - 99,DateTime.january),
        firstDate: DateTime(now.year - 100,DateTime.january),
        lastDate: DateTime(now.year - 15, DateTime.january));

    setState(() {
      _birthdayFrom= pickedDate!;
    });
  }
  void _datePickerTo() async {
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
      initialDate:DateTime.now(),
      lastDate: DateTime.now() ,
      firstDate: DateTime(now.year - 15, DateTime.january),
    );


    setState(() {
      _birthdayTo = pickedDate!;
    });
  }
  void _searchProfile(){
    ProfileFilterModel model=ProfileFilterModel();
    if(_nameController.text.trim().isNotEmpty){
     model.name=_nameController.text;
    }
    if(_emailController.text.trim().isNotEmpty){
      model.email=_emailController.text;
    }
    if(_phoneController.text.trim().isNotEmpty){
      model.phone=_phoneController.text;
    }
    if(_birthdayFrom!=null){
      model.birthDateFrom=DateFormat('yyyy-MM-dd').format(_birthdayFrom!).toString();

    }
    if(_birthdayTo!=null){
      model.birthDateTo=DateFormat('yyyy-MM-dd').format(_birthdayTo!).toString();
    }
    if(_gender!=null){
      model.gender=_gender!;
    }
    if(_role!=null){
      model.role=_role!;
    }
    if(_status!=null){
      model.status=_status!;
    }
    model.visible=_visible;
   widget.onSearchProfile(model);

    }
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<UserController>(builder: (userController)=>
        Padding(
          padding:  EdgeInsets.all(Dimensions.height15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(

              children: [
                AppTextField2(textController: _nameController,
                  textCapitalization: TextCapitalization.sentences,
                  label: 'Name',),
                AppTextField2(textController: _emailController,
                  label: 'Email',),
                AppTextField2(textController: _phoneController,
                  label: 'Phone',
                  textInputType: TextInputType.number,
                  prefixText: '+998 ',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                      height: Dimensions.height45+20,
                      width: Dimensions.height20*9,

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
                              _birthdayFrom == null
                                  ? 'Birthday from'
                                  : formatter.format(_birthdayFrom!),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black54),
                            ) ,
                            icon: Icon(Icons.calendar_month),
                            onPressed: _datePickerFrom,
                          ),

                        ],
                      ),
                    ),
                    Container(

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
                      child: Row(
                        children: [
                          TextButton.icon(
                            label: Text(
                              _birthdayTo == null
                                  ? 'Birthday To'
                                  : formatter.format(_birthdayTo!),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black54),
                            ) ,
                            icon: Icon(Icons.calendar_month),
                            onPressed: _datePickerTo,
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: Dimensions.height20,),
                //gender, role
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
                SizedBox(height: Dimensions.height30,),
                Container(width: Dimensions.height20*8,
                  height: Dimensions.height45*2,
                  decoration:  BoxDecoration(
                      boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary, offset: const Offset(2, 2),
                          blurRadius: 1.2, spreadRadius: 2
                      )],
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Theme.of(context).colorScheme.primary
                  ),
                  padding: EdgeInsets.symmetric(vertical:Dimensions.height15),
                  child: TextButton(
                    onPressed: _searchProfile,
                    child: Text('Search',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: Dimensions.font26,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                )

                // Expanded(child: CustomerList(customerList: customerList, onRemoveCustomer: _removeStaff,))
              ],
            ),
          ),
        )
    );
  }
}
