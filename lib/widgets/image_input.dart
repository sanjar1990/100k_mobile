import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuzk_mobile/data/repository/hive/hive_repo.dart';

import '../person.dart';
import '../utils/app_const.dart';
import '../utils/dimensions.dart';

class ImageInput extends StatefulWidget {
  final void Function (File image)onPickImage;
  const ImageInput({super.key, required this.onPickImage,
    this.isCreateStaff=false,
    this.isUpdate=false,
    this.attachUrl=''});
  final bool isCreateStaff;
  final bool isUpdate;
  final String attachUrl;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
   File? _selectedImage;
  void _imageTaker()async{
    final imagePicker=ImagePicker();
    final pickedImage=await imagePicker.pickImage(source: ImageSource.camera);
    if(pickedImage==null)return;
    setState(() {
      _selectedImage=File(pickedImage.path);
    });
  widget.onPickImage(_selectedImage!);
  }
   void _imageSelect()async{
     final imagePicker=ImagePicker();
     final pickedImage=await imagePicker.pickImage(source: ImageSource.gallery);
     if(pickedImage==null)return;
     setState(() {
       _selectedImage=File(pickedImage.path);
     });
     widget.onPickImage(_selectedImage!);
   }
   ImageProvider _getImage(){
    bool isUpdate=widget.isUpdate;
    bool isExists=Get.find<HiveRepo>().isExist(AppConstants.HIVE_KEY);
    if(isExists && !widget.isCreateStaff){
      Person person=Get.find<HiveRepo>().getPerson;
     return NetworkImage(person.attachUrl);
    }else if(isUpdate){
      return NetworkImage(widget.attachUrl);
    }
    else{
      return const AssetImage('assets/images/profile.jpg');
    }
   }
  @override
  Widget build(BuildContext context) {
    Widget image= Container(
      height: Dimensions.height20*6,
      width: Dimensions.width20*6,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
          image:  DecorationImage(
              image: _getImage(),
            fit: BoxFit.cover
          )
      ),

    );
    if(_selectedImage!=null){
      image= Container(
        height: Dimensions.height20*6,
        width: Dimensions.width20*6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            image: DecorationImage(
                image: FileImage(_selectedImage!),
              fit: BoxFit.cover
            )
        ),

      );
    }
    return Column(
      children: [
       image,
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: Dimensions.width10),
                height: Dimensions.height45,
                width: Dimensions.height20*7,
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
                      label: Text('Camera',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black54),
                      ),
                      icon: Icon(Icons.camera_alt),
                      onPressed: _imageTaker,
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: Dimensions.width10),
                height: Dimensions.height45,
                width: Dimensions.height20*7,
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
                      label: Text('Gallery',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black54),
                      ),
                      icon: const Icon(Icons.photo_library_outlined),
                      onPressed: _imageSelect,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
