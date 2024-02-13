import 'package:yuzk_mobile/enums/gender_enum.dart';

class SignUpBody {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String birthDate;
  final Gender gender;
  final String attachId;

  SignUpBody(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.birthDate,
      required this.gender,
      required this.attachId
      });

  Map<String, dynamic>toJson(){
    return{
    'name':name,
      'email':email,
      'phone':phone,
      'password':password,
      'birthDate':birthDate,
      'gender':gender.name,
      'attachId':attachId
    };
  }
}
