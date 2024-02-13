


import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_const.dart';
import '../api/dao_api_client.dart';
import 'package:dio/dio.dart';


class AttachRepo {
  final DaoApiClient apiClient;
  AttachRepo({ required this.apiClient});

  Future<Response> saveAttach(File image)async{
    return await apiClient.saveAttach(image);
  }
}