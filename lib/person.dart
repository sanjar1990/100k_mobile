import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String phone;
  @HiveField(4)
  DateTime birthDate;
  @HiveField(5)
  String gender;
  @HiveField(6)
  String attachUrl;
  @HiveField(7)
  String role;
  @HiveField(8)
  String jwt;
  @HiveField(9)
  String addresses='';


  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.attachUrl,
    required this.role,
    required this.jwt,
     this.addresses='',
});


}