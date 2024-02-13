import 'package:yuzk_mobile/boxes.dart';

import '../../../manage_category/model/categoryModel.dart';

class CategoryHiveRepo {
  Future<void> putData(List<CategoryModel> list) async{
    // list.map((e) => boxCategory.add(e));
    for (var element in list) {boxCategory.add(element);}
  }
  void putCategory(CategoryModel model){
    boxCategory.add(model);
  }

  bool isExists() {
    return boxCategory.length > 0;
  }

  List<CategoryModel> get categoryList {
    List<CategoryModel> list=[];
    if(isExists()){
      list=boxCategory.values.toList().map((e) => CategoryModel(
          id: e.id,
          parentName: e.parentName,
          name: e.name,
          orderNum: e.orderNum,
          creatorEmail: e.creatorEmail,
          attachUrl: e.attachUrl,
          productCount: e.productCount)).toList();
    }
    return list;
  }

  CategoryModel getByIndex(int index) {
    return boxCategory.getAt(index);
  }
  Future<void> clearCategory()async{
   await boxCategory.clear();
  }
  Future<void> deleteCategory(int index)async{
    await boxCategory.deleteAt(index);
  }
  Future<void> putAtCategory(int index, CategoryModel categoryModel)async{
    await boxCategory.put(index, categoryModel);
  }

}
