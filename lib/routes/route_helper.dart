import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:yuzk_mobile/manage_category/manage_category.dart';
import 'package:yuzk_mobile/manage_customer/manage_customer.dart';
import 'package:yuzk_mobile/models/PlaceLocationModel.dart';
import 'package:yuzk_mobile/pages/account/admin_account.dart';
import 'package:yuzk_mobile/pages/account/my_account.dart';
import 'package:yuzk_mobile/pages/account/update_account_page.dart';
import 'package:yuzk_mobile/pages/admin_pages/manage_staff.dart';
import 'package:yuzk_mobile/pages/auth/sign_in_page.dart';
import 'package:yuzk_mobile/pages/home/main_home_page.dart';
import 'package:yuzk_mobile/pages/home/main_page.dart';
import 'package:yuzk_mobile/pages/home/splash_screen.dart';
import 'package:yuzk_mobile/pages/map/map_screen.dart';
import 'package:yuzk_mobile/pages/product/product_full_detail.dart';
import 'package:yuzk_mobile/widgets/location_input.dart';

import '../pages/home/home_body_page.dart';

class RouteHelper{
static const String initial='/';
static const String productFullDetail='/product-full-detal';
static const String splashPage='/splash_page';
static const String signIn='/sign_in';
static const String myAccount='/my_account';
static const String mapScreen='/map_screen';
static const String updateAccountPage='/update_account_page';
static const String adminAccount='/admin_account';
static const String manageStaff='/manage_staff';
static const String manageCustomer='/manage_customer';
static const String manageCategory='/manage_category';



static String getInitial()=>'$initial';
static String getMyAccount()=>'$myAccount';
static String getAdminAccount()=>'$adminAccount';
static String getProductFullDetail()=>'$productFullDetail';
static String getSplashPage()=>'$splashPage';
static String getSignIn()=>'$signIn';
static String getMapScreen()=>'$mapScreen';
static String getUpdateAccountPage()=>'$updateAccountPage';
static String getManageStaff()=>'$manageStaff';
static String getManageCustomer()=>'$manageCustomer';
static String getManageCategory()=>'$manageCategory';

static List<GetPage>routes=[
  GetPage(name: initial, page: ()=> const MainPage()),
  GetPage(name: myAccount, page: ()=> const MyAccount()),
  GetPage(name: adminAccount, page: ()=> const AdminAccount()),
  GetPage(name: productFullDetail, page: ()=> const ProductFullDetail()),
  GetPage(name: splashPage, page: ()=> const SplashScreen()),
  GetPage(name: signIn, page: ()=> const SignInPage(),transition: Transition.fadeIn),
  GetPage(name: mapScreen, page: ()=> const MapScreen()),
  GetPage(name: updateAccountPage, page: ()=> const UpdateAccount()),
  GetPage(name: manageStaff, page: ()=> const ManageStaff()),
  GetPage(name: manageCustomer, page: ()=>  ManageCustomer()),
  GetPage(name: manageCategory, page: ()=>  ManageCategory()),
];
}