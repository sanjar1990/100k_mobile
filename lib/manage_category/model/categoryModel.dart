import 'package:hive/hive.dart';
part 'categoryModel.g.dart';

@HiveType(typeId: 3)
class CategoryModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String parentName;
  @HiveField(2)
  String name;
  @HiveField(3)
  int orderNum;
  @HiveField(4)
  String creatorEmail;
  @HiveField(5)
  String attachUrl;
  @HiveField(6)
  int productCount;

  CategoryModel({
    required this.id,
    required this.parentName,
    required this.name,
    required this.orderNum,
    required this.creatorEmail,
    required this.attachUrl,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    parentName: json["parentName"],
    name: json["name"],
    orderNum: json["orderNum"],
    creatorEmail: json["creatorEmail"],
    attachUrl: json["attachUrl"],
    productCount: json["productCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parentName": parentName,
    "name": name,
    "orderNum": orderNum,
    "creatorEmail": creatorEmail,
    "attachUrl": attachUrl,
    "productCount": productCount,
  };
}