import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuzk_mobile/manage_category/category_controller.dart';
import 'package:yuzk_mobile/manage_category/model/categoryModel.dart';
import 'package:yuzk_mobile/manage_category/new_category.dart';
import 'package:yuzk_mobile/manage_category/update_category.dart';
import 'package:yuzk_mobile/pages/account/admin_account.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';
import '../base/show_custom_snackbar.dart';
import '../widgets/admin_drawer.dart';
import 'category_item.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({super.key});

  @override
  State<ManageCategory> createState() => _ManageCategoryState();

}

class _ManageCategoryState extends State<ManageCategory> {
final RefreshController refreshController=RefreshController(initialRefresh: true);
  void _addCategory(){
    showModalBottomSheet(
        context: context,

        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (ctx){
            return const FractionallySizedBox(
              heightFactor: 0.9,
              child: NewCategory()
          );
        });

  }
void _removeCategory(CategoryModel categoryModel, int index){
  Get.find<CategoryController>().deleteCategory(categoryModel.id,index)
      .then((value) {
    if(value.isError){
      showCustomSnackBar(message: value.message);
    }else{
      ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: const Text('Category is deleted'),
         duration: const Duration(seconds: 3),
           action: SnackBarAction(label: 'Undo',
           onPressed: (){
             setState(() {
               Get.find<CategoryController>().resetCategory(categoryModel, index);
             });

         },),
         ));
    }

  });
}
void _updateCategory(CategoryModel categoryModel, int index){
  showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx){
        return  UpdateCategory(categoryModel: categoryModel ,
          index: index,);
      });
}

  PageController pageController=PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  @override
  void initState() {
    super.initState();
    bool exist=Get.find<CategoryController>().isExists;
    if(!exist){
      Get.find<CategoryController>().uploadCategoryList();
    }
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        // print('currentPageValue:  $_currentPageValue');
      });
    });

  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title:Text('Category'),
      actions: [
          IconButton(onPressed: _addCategory,
              icon:  const Icon(Icons.add,))
      ],
      ),
        drawer:  const AdminDrawer(onSelectScreen: AdminAccount.setScreen,),
      body: GetBuilder<CategoryController>(builder: (categoryController)   {
        List<CategoryModel> categoryList=[];
       if(categoryController.isExists){
         categoryList= categoryController.categoryList;
       }


      return categoryList.isEmpty?Text('No Category created'):
      SmartRefresher(
          controller: refreshController,
      enablePullUp: true,
        onRefresh: ()async{
            final result=categoryController.isExists;
            if(result){
              refreshController.refreshCompleted();
            }else{
              refreshController.refreshFailed();
            }

        },
        onLoading: ()async{
            final result=await categoryController.uploadCategoryList();
            if(result){
              refreshController.loadComplete();
            }else{
              refreshController.loadFailed();
            }
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.width20),
              height: Dimensions.height20*16,
              child: PageView.builder(

                  controller: pageController,
                  itemCount: categoryList.length,
                  itemBuilder: (context, position){
                    return CategoryItem(index: position,
                      categoryModel:categoryList[position],
                      currPageValue: _currPageValue,
                      scaleFactor: _scaleFactor,
                      onRemoveCategory: _removeCategory,
                      onUpdateCategory: _updateCategory,
                    );
                  }),
            ),
            DotsIndicator(
              dotsCount: categoryList.length,
              position: _currPageValue.round(),
              decorator: DotsDecorator(
                activeColor: Colors.red,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          ],
        ) ,
      );



      }


      )
    );
  }
}
