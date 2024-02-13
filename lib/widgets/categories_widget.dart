import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(8),

      margin: EdgeInsets.only(
          top: Dimensions.height20,
         ),
        height: Dimensions.height400,
      width: double.maxFinite,
      color: Color.fromARGB(255, 252, 225, 225),
      child: GridView.builder(
          primary: false,
          itemCount: 11,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(

              mainAxisSpacing: Dimensions.height10,
              crossAxisCount: 3,

          ),

          shrinkWrap: true,
          itemBuilder: (context, index) {

            return Column(
              children: [
              CircleAvatar(
                backgroundImage:AssetImage('assets/images/category1.png') ,
                radius: Dimensions.height45,
              ),
              // SizedBox(height: Dimensions.height10/2,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Telefonlar', style: TextStyle(fontWeight: FontWeight.bold, ),),
                    Text('(23)', ),
                  ],
                )
              ],
            );
          }),
    );

  }
}
