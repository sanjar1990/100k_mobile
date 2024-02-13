
import 'package:hive/hive.dart';

part 'staff.g.dart';

@HiveType(typeId: 2)
class Staff{

  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String phone;
  @HiveField(3)
  DateTime birthDate;
  @HiveField(4)
  String attachUrl;
  @HiveField(5)
  String role;



  Staff({
  required this.name,
  required this.email,
  required this.phone,
  required this.birthDate,
  required this.attachUrl,
  required this.role,
  });




}