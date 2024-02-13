import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:yuzk_mobile/data/repository/hive/hive_repo.dart';
import '../../utils/app_const.dart';
final dio = Dio();
class DaoApiClient{
  final HiveRepo hiveRepo;
  String? token;
  final SharedPreferences sharedPreferences;
  DaoApiClient( {required this.sharedPreferences, required this.hiveRepo,}){
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future<Response> saveAttach (File file) async {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    FormData  formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
    });

    var response = await dio.post(
        AppConstants.ATTACH_URL,
        data: formData,
        options: Options(
          method: "POST",
        )
    );
    return response;
  }
  Future<Response>postData(String url, dynamic body)async{
    updateToken();

  try{
    Future<Response>response=dio.post(url,data: body).timeout(Duration(seconds: 15));
  return response;
  }catch(e){
    return Response(requestOptions: RequestOptions(),statusCode: 1, statusMessage: e.toString());
  }
  }

  Future<Response>getData(String url)async{
    updateToken();
    late Response response;
    try{
    response= await dio.get(url).timeout(Duration(seconds: 10));
    }catch(e){
      response= Response(requestOptions: RequestOptions(), statusCode: 1, statusMessage: e.toString());
    }
    return response;
  }
  void updateToken(){
    if(hiveRepo.isLoggedIn){
      String jwt=hiveRepo.getPerson.jwt;
      print('JWT++++++++++++++++++:::: $jwt');
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer $jwt";
    }

  }

  Future<Response>updateData(String url, dynamic data)async{
    updateToken();

    late Response response;
  try{
     response=await dio.put(url, data: data).timeout(const Duration(seconds: 10));
  }catch(e){

    response=Response(requestOptions: RequestOptions(),statusCode:1, statusMessage: e.toString() );
  }
  return response;
  }
  Future<Response>remove(String url)async{
    updateToken();

    late Response response;
    try{
      response=await dio.delete(url).timeout(const Duration(seconds: 10));
    }catch(e){

      response=Response(requestOptions: RequestOptions(),statusCode:1, statusMessage: e.toString() );
    }
    return response;
  }


}