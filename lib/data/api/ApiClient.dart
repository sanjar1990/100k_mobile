import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuzk_mobile/utils/app_const.dart';
class ApiClient extends GetConnect implements GetxService{
  late String token;
    final SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.sharedPreferences}){
    timeout=const Duration(seconds: 7);
    token=sharedPreferences.getString(AppConstants.TOKEN)??'';
      _mainHeaders={
        'Content-type':'application/json; charset=UTF-8',
        'Authorization':'Bearer $token'
      };
  }
  void updateHeader(String token){
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token'
    };
  }
  Future<Response>postData(String url, dynamic body) async{
  try{
    print('body: $body');
    Response response=await post(url, body, headers: _mainHeaders);
    return response;
  }catch(e){
    return Response(statusCode: 1, statusText: e.toString());
  }
  }
  




}