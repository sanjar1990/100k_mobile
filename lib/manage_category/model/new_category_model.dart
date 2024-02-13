class NewCategoryModel{
  final String name;
  final int orderNum;
  final String attachId;
  final String parentId;

  NewCategoryModel({required this.name, required this.orderNum,
    required this.attachId, required this.parentId});

  Map<String, dynamic> toJson()=>{
    'name':name,
    'orderNum':orderNum,
    'attachId':attachId,
    'parentName':parentId
  };
}