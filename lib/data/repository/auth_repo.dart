import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuzk_mobile/data/api/ApiClient.dart';
import 'package:yuzk_mobile/data/api/dao_api_client.dart';
import 'package:yuzk_mobile/models/SignUpBody.dart';
import 'package:yuzk_mobile/utils/app_const.dart';
import 'package:dio/dio.dart';

class AuthRepo{
  final ApiClient apiClient;
  final DaoApiClient daoApiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences, required this.daoApiClient});
  Future<Response> registration(SignUpBody signUpBody)async{
    return daoApiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }
  Future<Response> login(String email, String password)async{
    return daoApiClient.postData(AppConstants.LOGIN_URI,{'email':email, 'password':password});
  }

  Future<bool>saveUserToken(String token)async{
    apiClient.token=token;
    daoApiClient.token=token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }






}