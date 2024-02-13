import 'dart:io';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:yuzk_mobile/data/repository/attach_repo.dart';
import 'package:dio/dio.dart';
import 'package:yuzk_mobile/models/photo_data.dart';
class  AttachController extends GetxController implements GetxService{
  final AttachRepo attachRepo;
  AttachController({required this.attachRepo});

  Future<PhotoData> saveAttach(File image)async{
    Response response= await attachRepo.saveAttach(image);
    if(response.statusCode==200){
      return PhotoData(id:response.data['id'], url: response.data['url'], );
    }else {
      throw Exception(response.statusMessage);
    }
  }
}