import 'package:dio/dio.dart';
import 'package:yuzk_mobile/manage_category/model/categoryModel.dart';
import 'package:yuzk_mobile/utils/app_const.dart';

import '../data/api/dao_api_client.dart';
import 'model/new_category_model.dart';

class CategoryRepo{
  final DaoApiClient daoApiClient;

  CategoryRepo({required this.daoApiClient});

  Future<Response> createCategory(NewCategoryModel model){
    return daoApiClient.postData(AppConstants.CREATE_CATEGORY, model.toJson());
  }
  Future<Response> getCategoryList(){
    return daoApiClient.getData(AppConstants.GET_CATEGORY_LIST);
  }
  Future<Response>deleteCategory(String id){
    return daoApiClient.remove(AppConstants.DELETE_CATEGORY+id);
  }
  Future<Response> resetCategory(String id){
   return daoApiClient.updateData(AppConstants.RECOVER_CATEGORY+id,{});
  }
  Future<Response> updateCategory(NewCategoryModel category, String id){
    return daoApiClient.updateData(AppConstants.UPDATE_CATEGORY+id,category.toJson());
  }
}