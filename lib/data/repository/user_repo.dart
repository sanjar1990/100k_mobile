import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/manage_customer/model/profile_pagination.dart';
import 'package:yuzk_mobile/models/EmailVerificationModel.dart';
import 'package:yuzk_mobile/models/staff_model.dart';
import 'package:yuzk_mobile/models/updateAccountBody.dart';
import 'package:yuzk_mobile/utils/app_const.dart';

import '../../models/profile_filter_model.dart';
import '../api/dao_api_client.dart';
import 'hive/staff_hive_repo.dart';

class UserRepo{
  final DaoApiClient daoApiClient;
  final StaffHiveRepo staffHiveRepo;
  UserRepo({required this.daoApiClient, required this.staffHiveRepo});

  Future<Response> updateAddress(String address)async{
    return await daoApiClient.updateData(AppConstants.UPDATE_ADDRESS, {'address':address});
  }
  Future<Response> updateAttach(String attachId)async{
    return await daoApiClient.updateData(AppConstants.UPDATE_PHOTO,{'attachId':attachId});
  }
  Future<Response> updateAccount(UpdateAccountBody accountBody)async{
    print('ACcountBody:+++++++++++++++++++++:${accountBody.toJson()}');
    return await daoApiClient.updateData(AppConstants.UPDATE_PROFILE_INFO,accountBody.toJson());
  }
  Future<Response> sendVerificationCode(String email)async{
    return await daoApiClient.postData(AppConstants.SEND_VERIFICATION_CODE, {
      'email':email
    });
  }
  Future<Response> verifyCode(EmailVerificationModel model) async{
    return await daoApiClient.postData(AppConstants.VERIFY_CODE, model.toJson());
  }
  Future<Response> changePassword(String oldPassword, String newPassword) async{
    return await daoApiClient.postData(AppConstants.CHANGE_PASSWORD, {
      'oldPassword':oldPassword,
      'newPassword':newPassword,
    });
  }
  Future<Response> createStaff(StaffModel staffModel) async{
    return await daoApiClient.postData(AppConstants.CREATE_STAFF, staffModel.toJson());
  }
  Future<Response> loadStaffList() async {
   return await daoApiClient.getData(AppConstants.GET_STAFF_LIST);
  }
  Future<Response>removeProfile(String email){
    return daoApiClient.remove(AppConstants.DELETE_PROFILE+email);
  }
  Future<Response>resetStaff(String email){
    return daoApiClient.getData(AppConstants.RESET_STAFF+email);
  }
  Future<Response>updateStaff(StaffModel staffModel){
    return daoApiClient.updateData(AppConstants.UPDATE_STAFF, staffModel.toJson());
  }
  Future<Response>updateCustomer(Content profile){
    print('Profile++++++++++++++: ${profile.toJson()}');
    print('URL++++++++++++++++++++: ${AppConstants.UPDATE_CUSTOMER}');
    return daoApiClient.updateData(AppConstants.UPDATE_CUSTOMER, profile.toJson());
  }
  Future<Response>searchFilter(ProfileFilterModel profileFilterModel, int page){
    return daoApiClient.postData(AppConstants.SEARCH_FILTER+page.toString(),
        profileFilterModel.toJson());
  }
}