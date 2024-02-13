import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';

class ProductWidget extends StatelessWidget {
  final String title;
  const ProductWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black, fontSize: Dimensions.font26),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'All',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ))
            ],
          ),
        ),
        InkWell(
          onTap: (){
            Get.toNamed(RouteHelper.productFullDetail);
          },
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
                top: Dimensions.height20,
              right: Dimensions.height10,
              left: Dimensions.height10
               ),
            height: 600,
            width: double.infinity,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              primary: false,
              itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: Dimensions.height15
                ),
                itemBuilder: (context, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        padding: const EdgeInsets.all(8),
                        height: Dimensions.height20*6,
                        decoration: const BoxDecoration(
                            image:  DecorationImage(
                              image: AssetImage('assets/images/product1.png'),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),

                      Text('Product name'),
                      Row(
                        children: [
                        Text('122222',style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: Dimensions.width10,),
                        Text('so\'m',style: TextStyle(color: Colors.black45),),
                      ],),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          child:const Text('orders: 120',style: TextStyle(color: Colors.black45),),
                        ),
                      )

                    ],
                  );
                }),
          ),
        )
      ],
    );
  }
}
