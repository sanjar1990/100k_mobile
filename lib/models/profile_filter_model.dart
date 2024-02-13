import 'package:intl/intl.dart';
import 'package:yuzk_mobile/enums/gender_enum.dart';
import 'package:yuzk_mobile/enums/profile_role.dart';
import 'package:yuzk_mobile/enums/profile_status.dart';

class ProfileFilterModel{
    String? _name;
   String? _email;
   String? _phone;
   String? _birthDateFrom;
   String? _birthDateTo;
   Gender? _gender;
   ProfileRole? _role;
   ProfileStatus? _status;
   bool visible=true;


    set name(String value) {
    _name = value;
  }

  Map<String, dynamic> toJson()=>{
  'name':_name,
  'email':_email,
  'phone':_phone,
  'birthDateFrom':_birthDateFrom,
  'birthDateTo':_birthDateTo,
  'gender':_gender,
  'role':_role,
  'status':_status,
  'visible':visible
  };

    set email(String value) {
    _email = value;
  }

    set phone(String value) {
    _phone = value;
  }

    set birthDateFrom(String value) {
    _birthDateFrom = value;
  }

    set birthDateTo(String value) {
    _birthDateTo = value;
  }

    set gender(Gender value) {
    _gender = value;
  }

    set role(ProfileRole value) {
    _role = value;
  }

    set status(ProfileStatus value) {
    _status = value;
  }
}

