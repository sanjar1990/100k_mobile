import 'package:intl/intl.dart';

class StaffModel{
  final String name;
  final String email;
  final String phone;
  final String password;
  final DateTime birthDate;
  final String attachUrl;

  StaffModel(
      {required this.name,
        required this.email,
        required this.phone,
        required this.password,
        required this.birthDate,
        required this.attachUrl
      });

  Map<String, dynamic>toJson(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
      'birthDate':DateFormat('yyyy-MM-dd').format(birthDate).toString(),
      'attachUrl':attachUrl
    };
  }
}