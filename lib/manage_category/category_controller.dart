import 'package:get/get.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/manage_category/category_repo.dart';
import 'package:yuzk_mobile/manage_category/model/categoryModel.dart';

import '../data/repository/hive/category_hive_repo.dart';
import '../models/response_model.dart';
import '../routes/route_helper.dart';
import 'model/new_category_model.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  final CategoryHiveRepo categoryHiveRepo;
  bool isLoading = false;

  CategoryController(
      {required this.categoryRepo, required this.categoryHiveRepo});

  Future<ResponseModel> createCategory(NewCategoryModel categoryModel) async {
    isLoading = true;
    update();
    late ResponseModel responseModel;
    try {
      var response = await categoryRepo.createCategory(categoryModel);

      if (response.statusCode == 200) {
        categoryHiveRepo.putCategory(CategoryModel.fromJson(response.data['data']));

        responseModel =
            ResponseModel(isError: false, message: 'Category is created',);
      } else {
        responseModel = ResponseModel(isError: true,
            message: response.statusMessage ?? 'Something went wrong');
      }
    } catch (e) {
      responseModel = ResponseModel(isError: true, message: e.toString());
    } finally {
      isLoading = false;
      update();
    }


    return responseModel;
  }

  bool get isExists {
    return categoryHiveRepo.isExists();
  }

  Future<bool> uploadCategoryList() async {
    bool result=false;
    if (categoryHiveRepo.isExists()) {
      categoryHiveRepo.clearCategory();
    }
    List<CategoryModel> list = [];
    try {
      var response = await categoryRepo.getCategoryList();
      if (response.statusCode == 200) {
        response.data.forEach((e) {
          CategoryModel model = CategoryModel(
              id: e['id'],
              parentName: e['parentName'],
              name: e['name'],
              orderNum: e['orderNum'],
              creatorEmail: e['creatorEmail'],
              attachUrl: e['attachUrl'],
              productCount: e['productCount']);
          list.add(model);
        });
        categoryHiveRepo.putData(list);
        result=true;
      } else {
        showCustomSnackBar(
            message: response.statusMessage ?? 'Something went wrong');
      }
    } catch (e) {
      showCustomSnackBar(message: e.toString());
    }
    return result;
  }

  List<CategoryModel> get categoryList {
    if (!isExists) {
      uploadCategoryList();
    }
    return categoryHiveRepo.categoryList;
  }
  Future<ResponseModel> deleteCategory(String id, int index)async{
      await categoryHiveRepo.deleteCategory(index);
      update();
    late ResponseModel responseModel;
       try{
      var response=await categoryRepo.deleteCategory(id);
      if(response.statusCode==200){
        responseModel=ResponseModel(isError: false, message: 'Category is Deleted');
      }else{
        responseModel=ResponseModel(isError: true,
            message: response.statusMessage??'Something went wrong');
      }
    }catch(e){
         responseModel=ResponseModel(isError: true,
             message: e.toString());
         return responseModel;
    }

       return responseModel;
  }
  Future<void>resetHiveCategory(int index, CategoryModel categoryModel)async{
    if(isExists){
      List<CategoryModel>list= categoryHiveRepo.categoryList;
      list.insert(index, categoryModel);
    await categoryHiveRepo.clearCategory();
      await categoryHiveRepo.putData(list);
    }
  }
  Future<ResponseModel> resetCategory(CategoryModel categoryModel, int index)async{
      if(isExists){
      await categoryHiveRepo.putAtCategory(index, categoryModel);
      }
    late ResponseModel responseModel;
    try{
      var response = await categoryRepo.resetCategory(categoryModel.id);
    if(response.statusCode==200){
      responseModel=ResponseModel(isError: false, message: "Category recovered");
    }else{
      responseModel=ResponseModel(isError: true, message: response.statusMessage??'Something went wrong');
    }
    }catch(e){
      responseModel=ResponseModel(isError: true, message: e.toString());
    return responseModel;
    }
    update();
    return responseModel;
  }
  Future<ResponseModel> updateCategory(String attachId,CategoryModel categoryModel, int index)async{

    ResponseModel responseModel;
    if(isExists){
      await categoryHiveRepo.putAtCategory(index, categoryModel);
    }else{
      responseModel=ResponseModel(isError: true,
          message: 'Error is occured');
      return responseModel;
    }
    try{

      String  parentId='';
     if(categoryModel.parentName.isNotEmpty){
       List<CategoryModel> list=categoryHiveRepo.categoryList;
       parentId=list.firstWhere((e) => e.name==categoryModel.parentName).id;
     }
      NewCategoryModel newCategoryModel=NewCategoryModel(
          name: categoryModel.name,
          orderNum: categoryModel.orderNum,
          attachId: attachId,
          parentId: parentId);
      var response =await categoryRepo.updateCategory(newCategoryModel, categoryModel.id);
      if(response.statusCode==200){
        responseModel=ResponseModel(isError: false, message: response.data['message']);
      }else{
        responseModel=ResponseModel(isError: true, message: response.statusMessage??'Something went wrong');
      }

    }catch(e){
      responseModel=ResponseModel(isError: true,
          message: e.toString());

      return responseModel;
    }
    update();

return responseModel;

  }
}