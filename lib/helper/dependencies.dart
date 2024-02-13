import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuzk_mobile/controller/attach_controller.dart';
import 'package:yuzk_mobile/controller/auth_controller.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/data/api/ApiClient.dart';
import 'package:yuzk_mobile/data/repository/attach_repo.dart';
import 'package:yuzk_mobile/data/repository/auth_repo.dart';
import 'package:yuzk_mobile/data/repository/hive/category_hive_repo.dart';
import 'package:yuzk_mobile/data/repository/hive/hive_repo.dart';
import 'package:yuzk_mobile/data/repository/hive/staff_hive_repo.dart';
import 'package:yuzk_mobile/data/repository/user_repo.dart';
import 'package:yuzk_mobile/manage_category/category_controller.dart';
import 'package:yuzk_mobile/manage_category/category_repo.dart';
import 'package:yuzk_mobile/widgets/location_input.dart';
import '../data/api/dao_api_client.dart';

Future<void>init()async{
final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences, fenix: true);
  //api client
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()), fenix: true);
  Get.lazyPut(() => DaoApiClient(sharedPreferences: Get.find(), hiveRepo: Get.find()) ,fenix: true);
  // repo
  Get.lazyPut(()=>HiveRepo(), fenix: true);
  Get.lazyPut(()=>StaffHiveRepo(), fenix: true);
    Get.lazyPut(() => AuthRepo(apiClient: Get.find(),
        daoApiClient: Get.find(),
        sharedPreferences: Get.find()), fenix: true);
  Get.lazyPut(() => AttachRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => UserRepo(daoApiClient: Get.find(), staffHiveRepo: Get.find()), fenix:  true);
  Get.lazyPut(()=>CategoryRepo(daoApiClient: Get.find()));
  Get.lazyPut(()=>CategoryHiveRepo(), fenix: true);

  // controller
  Get.lazyPut(() => AuthController(hiveRepo: Get.find(),authRepo: Get.find()), fenix: true);
Get.lazyPut(() => AttachController(attachRepo: Get.find()), fenix: true);
Get.lazyPut(() => UserController(
    staffHiveRepo: Get.find(),
    hiveRepo: Get.find(),
    authRepo: Get.find(),
    userRepo: Get.find(),
    categoryHiveRepo: Get.find(),),

    fenix: true);
Get.lazyPut(() => CategoryController(categoryRepo: Get.find(), categoryHiveRepo: Get.find()), fenix: true);

}