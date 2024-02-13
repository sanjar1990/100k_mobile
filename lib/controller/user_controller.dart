import 'package:get/get.dart';
import 'package:yuzk_mobile/data/repository/auth_repo.dart';
import 'package:yuzk_mobile/data/repository/hive/category_hive_repo.dart';
import 'package:yuzk_mobile/manage_customer/model/profile_pagination.dart';
import 'package:yuzk_mobile/models/EmailVerificationModel.dart';
import 'package:yuzk_mobile/models/profile_filter_model.dart';
import 'package:yuzk_mobile/models/response_model.dart';
import 'package:yuzk_mobile/models/staff_model.dart';
import 'package:yuzk_mobile/models/updateAccountBody.dart';
import 'package:yuzk_mobile/pages/account/admin_account.dart';
import 'package:yuzk_mobile/pages/admin_pages/manage_staff.dart';
import 'package:yuzk_mobile/person.dart';
import 'package:yuzk_mobile/utils/app_const.dart';
import '../base/show_custom_snackbar.dart';
import '../data/repository/hive/hive_repo.dart';
import '../data/repository/hive/staff_hive_repo.dart';
import '../data/repository/user_repo.dart';
import '../routes/route_helper.dart';
import '../staff.dart';

class UserController extends GetxController implements GetxService{
      final AuthRepo authRepo;
      final HiveRepo hiveRepo;
      final CategoryHiveRepo categoryHiveRepo;
      final UserRepo userRepo;
      final StaffHiveRepo staffHiveRepo;
  UserController(  {required this.authRepo,
  required this.hiveRepo, required this.userRepo, required this.staffHiveRepo,
  required this.categoryHiveRepo,});
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

     Person  get person{

    return hiveRepo.getPerson;
  }

  bool userLoggedIn(){
   return hiveRepo.isLoggedIn;
  }
  Future<ResponseModel> updateAttach(String attachId) async {

       var response= await userRepo.updateAttach( attachId);

      if(response.statusCode==200){
        print('data:  ${response.data['data']['attachUrl']}');
        Person person=hiveRepo.getPerson;
        person.attachUrl=response.data['data']['attachUrl'];
        hiveRepo.updatePerson(person);

        return ResponseModel(isError: false, message: "Photo is updated");

      }else{

        return ResponseModel(isError: true, message: response.statusMessage??'Something went wrong');
      }

  }
    List<Staff> getStaffList(){
       bool isExists=staffHiveRepo.isExists;
       if(!isExists){
      loadStaffList;
       }
       List<Staff> staffList=staffHiveRepo.getStaffList;
       return staffList;
       }

  void loadStaffList()async{
   var response=await userRepo.loadStaffList();
   staffHiveRepo.deleteStaffList();
    if(response.statusCode==200){
      List<Staff> staffList=[];
      response.data.forEach(
              (v){
            Staff staff=Staff(
                name: v['name'],
                email: v['email'],
                phone: v['phone'],
                birthDate:  DateTime.parse(v['birthDate']),
                attachUrl: v['attachUrl'],
                 role: v['role'],);
            staffList.add(staff);
          }
      );
      staffHiveRepo.putList(staffList);
    }else{
      showCustomSnackBar(message: response.statusMessage??'Something went wrong');
    }
  }
  bool isStaffExists(){
       return staffHiveRepo.isExists;
  }

      Future<ResponseModel> removeProfile(String email, int index)async{
        staffHiveRepo.deleteStaff(index);
        var response=await userRepo.removeProfile(email);
        ResponseModel responseModel;
        if(response.statusCode==200){
          responseModel=ResponseModel(isError: false, message: response.data['message']);
        }else{
          responseModel=ResponseModel(isError: true, message: response.statusMessage??'Something went wrong');
        }
        return responseModel;
      }
void resetStaff(Staff staff, int index)async{
       var exists=staffHiveRepo.isExists;
       if(exists){
        staffHiveRepo.putStaffAt(index, staff);
          try{
            var response=await userRepo.resetStaff( staff.email);
            if(response.statusCode==200){
              update();
            }else{
              showCustomSnackBar(message: response.statusMessage??'Something went wrong');
            }
          }catch(e){
            showCustomSnackBar(message: e.toString());

          }

         update();
       }
}
      void resetProfile(Content content, int index)async{
          try{
            var response=await userRepo.resetStaff( content.email);
            if(response.statusCode==200){
              update();
            }else{
              showCustomSnackBar(message: response.statusMessage??'Something went wrong');
            }
          }catch(e){
            showCustomSnackBar(message: e.toString());

          }
          update();
      }
  void logout(){
       hiveRepo.deletePerson();
       categoryHiveRepo.clearCategory();
       AppConstants.TOKEN='';
       Get.offAndToNamed(RouteHelper.getSignIn());
  }
      void logoutAdmin(){
        hiveRepo.deletePerson();
        staffHiveRepo.deleteStaffList();
        AppConstants.TOKEN='';
        AppConstants.HIVE_KEY=0;
        update();
      }
  void updateAddress(String address){
    userRepo.updateAddress(address);
    update();
  }

Future<ResponseModel> updateProfile(UpdateAccountBody accountBody)async{
    var response =await userRepo.updateAccount(accountBody);
       if(response.statusCode==200){
         Person person=hiveRepo.getPerson;
         person.name=response.data['data']['name'];
         person.phone=response.data['data']['phone'];
         person.birthDate=DateTime.parse(response.data['data']['birthDate']);
         person.gender=response.data['data']['gender'];

         hiveRepo.updatePerson(person);
         return ResponseModel(isError: false, message: 'Account is successfully updated');
       }else{
         return ResponseModel(isError: true, message: response.statusMessage??'Something went wrong');
       }
}

    Future<ResponseModel> sendVerificationCode(String email)async{
      var response=await  userRepo.sendVerificationCode(email);
      if(response.statusCode==200){
        return ResponseModel(isError: false, message: response.data['message']);
      }else{
        return ResponseModel(isError: false, message: response.statusMessage?? 'Something went wrong');
      }
     }

     Future<ResponseModel> verifyEmail(EmailVerificationModel model) async{
       var response=await userRepo.verifyCode(model);
       if(response.statusCode==200){
         return ResponseModel(isError: false, message: response.data['message']);
       }
       else{
         return ResponseModel(isError: true, message: response.statusMessage?? 'Something went wrong try again');
       }
     }

      Future<ResponseModel> changePassword(String oldPassword, String newPassword) async{
        var response=await userRepo.changePassword(oldPassword, newPassword);
        if(response.statusCode==200){
          return ResponseModel(isError: false, message: response.data['message']);
        }
        else{
          return ResponseModel(isError: true, message: response.statusMessage?? 'Something went wrong try again');
        }
      }
      Future<ResponseModel> updateCustomer(Content profile) async{

        ResponseModel responseModel;

        var response= await userRepo.updateCustomer(profile);
        if(response.statusCode==200){
          responseModel=ResponseModel(isError: false, message: response.data['message']);
          return responseModel;
        }else{
          responseModel=ResponseModel(isError: true, message: response.statusMessage?? 'Something went wrong');
        }

        return responseModel;
      }
      Future<ResponseModel> updateStaff(StaffModel staffModel, String attachUrl, int index) async{
       Staff staff =Staff(
           name: staffModel.name,
           email: staffModel.email,
           phone: staffModel.phone,
           birthDate: staffModel.birthDate,
           attachUrl: attachUrl,
           role: 'role_staff');
       bool isExists=staffHiveRepo.isExists;
       if(isExists){
         staffHiveRepo.putStaffAt(index, staff);
       }
       ResponseModel responseModel;

         var response= await userRepo.updateStaff(staffModel);
         if(response.statusCode==200){
           responseModel=ResponseModel(isError: false, message: response.data['message']);
           return responseModel;
         }else{
           responseModel=ResponseModel(isError: true, message: response.statusMessage?? 'Something went wrong');
         }

       return responseModel;
      }
      Future<ResponseModel> createStaff(StaffModel staffModel, String url) async{
        _isLoading=true;
        update();
        ResponseModel responseModel=ResponseModel(isError: true, message: 'Something went wrong');
        try{
          Staff staff=Staff(name: staffModel.name,
              email: staffModel.email,
              phone: staffModel.phone,
              birthDate: staffModel.birthDate,
              attachUrl: url,
              role: 'STAFF');
          if(staffHiveRepo.isExists){
            List<Staff> list=staffHiveRepo.getStaffList;
            list.add(staff);
            staffHiveRepo.deleteStaffList();
            staffHiveRepo.putList(list);
          }else{
            List<Staff> list= [];
            list.add(staff);
            update();
          }

          var response=await userRepo.createStaff(staffModel);



          if(response.statusCode==200){
            responseModel= ResponseModel(isError: false, message: response.data['message']);
          }
          else{
            responseModel= ResponseModel(isError: true, message: response.statusMessage?? 'Something went wrong try again');
          }
          _isLoading=false;
          update();
          Get.offAll(()=>const ManageStaff());
        }catch(e){

          Get.offAll(const AdminAccount());
          _isLoading=false;
          update();
        }

        return responseModel;
      }

        Future<ResponseModel> searchFilter(ProfileFilterModel model, int currentPage,) async{
          var response=await userRepo.searchFilter(model,currentPage);
          if(response.statusCode==200){
            ProfilePagination profilePagination=ProfilePagination.fromJson(response.data);
            return ResponseModel(isError: false, message: 'Success',data: profilePagination);
          }
     return ResponseModel(isError: true, message: response.statusMessage??'Something went wrong');
     }
}