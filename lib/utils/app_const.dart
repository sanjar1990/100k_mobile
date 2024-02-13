class AppConstants{
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;


  static  String BASE_URL = "https://mvs.bslmeiyu.com";
  // static const String BASE_URL = " http://localhost:80000";

  // static const String BASE_URL = "http://localhost:8080";
  // static  const BASE_URL = "http://192.168.0.100:8080";
  static const String POPULAR_PRODUCT_URL = "https://mvs.bslmeiyu.com/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URL = "https://mvs.bslmeiyu.com/api/v1/products/recommended";
  static  String TOKEN = "No token";
  static const String PHONE = "No phone";
  static const String PASSWORD = "No Info";
  static const String UPLOAD_URL = "/uploads/";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  // auth endPoint
  static const String url='192.168.0.104';
  // static const String url='192.168.240.214';
  static const String REGISTRATION_URI='http://$url:8080/api/v1/auth/registration';
  static const String LOGIN_URI='http://$url:8080/api/v1/auth/login';
  static const String ATTACH_URL='http://$url:8080/api/v1/attach/public/upload';
  static const String UPDATE_ADDRESS='http://$url:8080/api/v1/profile/updateAddress';
  static const String UPDATE_PHOTO='http://$url:8080/api/v1/profile/updatePhoto';
  static const String UPDATE_PROFILE_INFO='http://$url:8080/api/v1/profile/updateInfo';
  static const String SEND_VERIFICATION_CODE='http://$url:8080/api/v1/profile/sendVerificationCode';
  static const String VERIFY_CODE='http://$url:8080/api/v1/profile/verifyCode';
  static const String CHANGE_PASSWORD='http://$url:8080/api/v1/profile/changePassword';
  static const String GET_STAFF_LIST='http://$url:8080/api/v1/profile/getStaffList';
  static const String CREATE_STAFF='http://$url:8080/api/v1/profile/createStaff';
  static const String DELETE_PROFILE='http://$url:8080/api/v1/profile/deleteProfile?email=';
  static const String RESET_STAFF='http://$url:8080/api/v1/profile/resetStaff?email=';
  static const String UPDATE_STAFF='http://$url:8080/api/v1/profile/updateStaff';
  static const String UPDATE_CUSTOMER='http://$url:8080/api/v1/profile/updateCustomer';
  static const String SEARCH_FILTER="http://$url:8080/api/v1/profile/searchPagination?size=2&page=";
  static const String CREATE_CATEGORY="http://$url:8080/api/v1/category/createCategory";
  static const String GET_CATEGORY_LIST="http://$url:8080/api/v1/category/getCategory";
  static const String DELETE_CATEGORY="http://$url:8080/api/v1/category/deleteCategory/";
  static const String RECOVER_CATEGORY="http://$url:8080/api/v1/category/resetCategory/";
  static const String UPDATE_CATEGORY="http://$url:8080/api/v1/category/updateCategory/";
  static int HIVE_KEY=0;
  static const String HIVE_PERSON_LIST_KEY="staff_list";
}