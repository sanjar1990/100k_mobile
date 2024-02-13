import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';

import '../utils/dimensions.dart';

class ProductShortDetail extends StatelessWidget {
  const ProductShortDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: (){
        Get.toNamed(RouteHelper.productFullDetail);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: Dimensions.height20),
        color: Color.fromARGB(155, 243, 193, 193) ,
        child: GridView.builder(
        addRepaintBoundaries: false,
          primary: false,
          // scroll
            // Direction: Axis.horizontal,
          itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            crossAxisSpacing: Dimensions.width10,
              mainAxisSpacing: Dimensions.height10
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index){
              return Stack(children: [
                Container(
                  // width: 200,
                  // height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    image:DecorationImage(
                      image: AssetImage('assets/images/p2.png')
                    )
                  ),
                ),
                Positioned(
                  child: Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                    height: Dimensions.height20*2,
                    width: Dimensions.width20*5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      border: Border.all(color: Colors.black38,width: 1)
                    ),
                    child: Text('100.000  so\'m', )),
                  bottom:Dimensions.height10/5,right: Dimensions.width20,)
              ],);
        }),
      ),
    );
  }
}
