import 'dart:io';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:yuzk_mobile/data/repository/auth_repo.dart';
import 'package:yuzk_mobile/data/repository/hive/hive_repo.dart';
import 'package:yuzk_mobile/enums/gender_enum.dart';
import 'package:yuzk_mobile/models/SignUpBody.dart';
import 'package:dio/dio.dart' as dio;
import 'package:yuzk_mobile/person.dart';
import 'package:yuzk_mobile/utils/app_const.dart';

import '../models/response_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  final HiveRepo hiveRepo;
  AuthController({ required this.hiveRepo, required this.authRepo});
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody)async{
    _isLoading=true;
    update();
    late ResponseModel responseModel;
   dio.Response response= await authRepo.registration(signUpBody);
    if(response.statusCode==200){
      responseModel= ResponseModel(isError: false, message: response.data['message']);
    }else{
      responseModel= ResponseModel(isError: true, message: response.statusMessage?? 'Something went wrong');
    }
    _isLoading=false;
    update();
    return responseModel;
  }

  Future<ResponseModel>login(String email, String password)async{
    _isLoading=true;
    update();
    late ResponseModel responseModel;
    dio.Response response=await authRepo.login(email, password);

    if(response.statusCode==200){
      authRepo.saveUserToken(response.data['jwt']);
      AppConstants.TOKEN=response.data['jwt'];
      AppConstants.HIVE_KEY=response.data['id'];

      hiveRepo.putData(Person(name:response.data['name'] ,
          id: response.data['id'],
          email: response.data['email'],
          phone: response.data['phone'],
          birthDate: DateTime.parse(response.data['birthDate']),
          gender: response.data['gender'].toString().toLowerCase(),
          attachUrl: response.data['attachUrl'],
          role: response.data['role'].toString().toLowerCase(),
          jwt: response.data['jwt'],
          addresses: response.data['address']
      ));

      // hiveRepo.setLoggedIn();

      responseModel= ResponseModel(isError: false, message: response.data['role'].toString());
    }else{
    responseModel=ResponseModel(isError: true, message: response.statusMessage!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }



}