import 'package:flutter/material.dart';
import 'package:yuzk_mobile/manage_category/model/categoryModel.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,
    required this.index,
    required this.categoryModel,
    required this.currPageValue,
    required this.scaleFactor, required this.onRemoveCategory,
    required this.onUpdateCategory});
  final CategoryModel categoryModel;
  final int index;
  final double currPageValue;
  final double scaleFactor;
  final void Function(CategoryModel categoryModel, int index) onRemoveCategory;
  final void Function(CategoryModel categoryModel, int index) onUpdateCategory;

  @override
  Widget build(BuildContext context) {
    double _height=Dimensions.height20*11;
    Matrix4 matrix4=Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
          height: _height,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(categoryModel.attachUrl))
          ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              padding: EdgeInsets.only(
                  top:Dimensions.height10,
                  bottom:Dimensions.height10,
                  left:Dimensions.width20,
                  right:Dimensions.width20,
              ),
              width: double.maxFinite,
              height: Dimensions.height20*7,
              margin: EdgeInsets.only(left: Dimensions.width30+5,
                  right:Dimensions.width30+5, bottom: Dimensions.height10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 5.0,
                  offset: Offset(0,5),
                ),
                 BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                  offset: Offset(-5,0)
                ),
                 BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    offset: Offset(5,0)
                ),

              ]
              ),
              child: Stack(
                children:[ SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('name:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black54, fontSize: Dimensions.font16,
                        ),textAlign: TextAlign.start,
                        ),
                        Text(categoryModel.name, style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black87, fontSize: Dimensions.font26,
                        ),textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                      Text('Parent category:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black54, fontSize: Dimensions.font16,
                      ),textAlign: TextAlign.start,
                      ),
                      Text(categoryModel.parentName??'N/A', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black87, fontSize: Dimensions.font26,
                      ),textAlign: TextAlign.start,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('creator email:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black54, fontSize: Dimensions.font16,
                          ),textAlign: TextAlign.start,
                          ),
                          Text(categoryModel.creatorEmail, style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black87, fontSize: Dimensions.font26,
                          ),textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('order number:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black54, fontSize: Dimensions.font16,
                              ),textAlign: TextAlign.start,
                              ),
                              Text(categoryModel.orderNum.toString(), style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black87, fontSize: Dimensions.font20,
                              ),textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text('product count:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black54, fontSize: Dimensions.font16,
                              ),textAlign: TextAlign.start,
                              ),
                              Text(categoryModel.productCount.toString(), style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black87, fontSize: Dimensions.font20,
                              ),textAlign: TextAlign.start,
                              ),
                            ],
                          ),

                        ],
                      )

                    ],
                  ),
                ),
                  Positioned(
                    right: Dimensions.width10/2,
                    child: PopupMenuButton<String>(
                      onSelected: (value){
                        if(value=='Update category'){
                        onUpdateCategory(categoryModel, index);
                        }else if(value=='Delete category'){
                          onRemoveCategory(categoryModel,index);
                        }

                      },
                      itemBuilder: (BuildContext context) {
                        return { 'Update category','Delete category'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  )
                ]
              ),
            ),
          ),

        ]
      ),
    );
  }
}
