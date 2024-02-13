import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/controller/attach_controller.dart';

import 'package:yuzk_mobile/manage_category/category_controller.dart';
import 'package:yuzk_mobile/models/photo_data.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';

import '../base/custom_loader.dart';
import '../base/show_custom_snackbar.dart';
import '../utils/dimensions.dart';
import '../widgets/image_input.dart';
import 'model/categoryModel.dart';

class UpdateCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const UpdateCategory({super.key,
    required this.categoryModel,
    required this.index});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  File? _selectImage;
  final _nameController=TextEditingController();
  final _parentNameController=TextEditingController();
  final _orderNumController=TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _parentNameController.dispose();
    _orderNumController.dispose();
  }
  Future<void> _updateCategory(CategoryController categoryController) async {
    CategoryModel category=widget.categoryModel;
    if(_nameController.text.trim().isNotEmpty){
      category.name=_nameController.text;
    }
    if(_parentNameController.text.trim().isNotEmpty){
      category.parentName=_parentNameController.text;
    }
    if(_orderNumController.text.trim().isNotEmpty){
      category.orderNum=int.parse(_orderNumController.text);
    }
      String photoId='';
    if(_selectImage!=null){
      PhotoData photoData=await Get.find<AttachController>().saveAttach(_selectImage!);
      category.attachUrl=photoData.url;
      photoId=photoData.id;
    }
    categoryController.updateCategory(photoId,category, widget.index).then((status) => {
      if(status.isError){
        showCustomSnackBar(message: status.message),
      }else{
        showCustomSnackBar(message: status.message, title: 'Category is updated'),
    Get.offAndToNamed(RouteHelper.manageCategory)
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categoryController){
      return  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(padding: EdgeInsets.only(
          top: Dimensions.height20, bottom: Dimensions.height45,
        left: Dimensions.width15, right: Dimensions.width15,
        ).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom
        ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Center(child: ImageInput(onPickImage: (image){_selectImage=image;},
                attachUrl: widget.categoryModel.attachUrl, isUpdate: true,),),
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
                    label: const Text('category name: '),
                    hintText: widget.categoryModel.name
                ),
              ),
              TextField(
                controller: _parentNameController,
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
                    label: const Text('parent name: '),
                    hintText: widget.categoryModel.parentName
                ),
              ),
              TextField(
                controller: _orderNumController,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.redAccent,
                    fontSize: Dimensions.font20
                ),
                keyboardType: TextInputType.number,
            decoration: InputDecoration(
             labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.black,
              fontSize: Dimensions.font26),
            label: const Text('order number: '),
            hintText: widget.categoryModel.orderNum.toString()),),
              SizedBox(height: Dimensions.width45,),
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
                      _updateCategory(categoryController);
                    },

                    child: Center(
                        child:  categoryController.isLoading? const CustomLoader():
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
      );

    });
  }
}
