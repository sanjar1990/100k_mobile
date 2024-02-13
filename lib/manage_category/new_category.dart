
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/manage_category/category_controller.dart';
import 'package:yuzk_mobile/manage_category/manage_category.dart';
import 'package:yuzk_mobile/manage_category/model/categoryModel.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';
import '../base/custom_loader.dart';
import '../base/show_custom_snackbar.dart';
import '../controller/attach_controller.dart';
import '../models/photo_data.dart';
import '../widgets/image_input.dart';
import 'model/new_category_model.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final _nameController=TextEditingController();
  final _orderNumController=TextEditingController();
  File? _selectImage;
  String _attachId='';
    CategoryModel? parentCategory;
   String _parentId='';
List<CategoryModel> categoryList=Get.find<CategoryController>().categoryList;

  void _createCategory(CategoryController categoryController)async{
    if(_nameController.text.isEmpty){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text('Invalid input'),
        content:  Text('Enter category name'  ,
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
    if(_orderNumController.text.isEmpty){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text('Invalid input'),
        content:  Text('Enter category order number'  ,
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
    if(parentCategory!=null){
      _parentId=parentCategory!.id
      ;
    }
    if(_selectImage==null){
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text('Invalid input'),
        content:  Text('Choose category photo'  ,
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
    }else{
      PhotoData photoData= await Get.find<AttachController>().saveAttach(_selectImage!);
      _attachId=photoData.id;

    }


    NewCategoryModel category=NewCategoryModel(
        parentId: _parentId,
        name: _nameController.text,
        orderNum: int.parse(_orderNumController.text),
        attachId: _attachId);

    categoryController.createCategory(category).then((status) => {
      if(status.isError){
    showCustomSnackBar(message: status.message),
        Navigator.of(context).pop()
      }else{
        showCustomSnackBar(
        message: 'Category created', title: 'Category'),
        Get.offAndToNamed(RouteHelper.getManageCategory())
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categoryController)=>
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(padding: EdgeInsets.all(Dimensions.height15).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom
          ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: ImageInput(onPickImage: (image){_selectImage=image;}),),
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
                    label: Text('name:'),
                  ),
                ),
                TextField(
                  controller: _orderNumController,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.redAccent,
                      fontSize: Dimensions.font20
                  ),
                  keyboardType: TextInputType.number,

                  decoration:  InputDecoration(

                    prefixText: '# ',
                    prefixStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.red,
                        fontSize: Dimensions.font20
                    ),
                    label: const Text('Order number:'),
                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black,
                        fontSize: Dimensions.font26
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                Visibility(
                  visible: categoryList.isNotEmpty,
                  child: DropdownButton(

                    hint: const Text('Select parent category'),
                      items:   categoryList.map((e) => DropdownMenuItem(
                          value:e ,
                          child: Text(e.name,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black87
                          ),
                          ))).toList(),
                      onChanged: <CategoryModel>(value) {
                     setState(() {
                       parentCategory=value;
                     });
                      },
                    ),
                ),
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
                        categoryController.isLoading?null:_createCategory(categoryController);
                      },

                      child: Center(
                          child:  categoryController.isLoading? const CustomLoader():
                          Text('Create' , style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: Dimensions.font20,

                          ),)
                      ),
                    ),


                  ],
                ),
              ],
            ) ,
          ),
        )
    );
  }
}
