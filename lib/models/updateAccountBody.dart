
import 'package:intl/intl.dart';

import '../enums/gender_enum.dart';

class UpdateAccountBody{
  final String  name;
  final String phone;
  final String birthDate;
  final String gender;

  UpdateAccountBody({required this.name, required this.phone, required this.birthDate, required this.gender});
  Map<String, dynamic>toJson(){
    return{
      'name':name,
      'phone':phone,
      'birthDate':birthDate,
      'gender':gender
    };
  }
}