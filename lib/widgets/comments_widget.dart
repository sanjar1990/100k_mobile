import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.width10),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: Dimensions.height15),
        itemBuilder: (context,index) {
          return Container(
            child: Column(

              children: [
               //xaridor comment
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),

                 color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('name'),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: Dimensions.height10),
                        child: Row(children: [
                          Row(children: [
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),

                          ],),
                          SizedBox(
                            width: Dimensions.width15,
                          ),
                          Text('25 dekabr, 2023')
                        ],),
                      ),
                      Text('comment: asdjshdjsdjsakhdjshdasjhdsjdhsjkdhsajkdhsajd'
                          'ksdsajlkdsjaldkjsdlksajdlksjdlksjklsjdslkdjslk'
                          'kkdjsadlksajdksjdlksajdksajdskdjsalkdjaslkdj'
                          'dlsdksadksldsadsdsadsadsdsdsdsdsdsdsadsdsad'),
                      Container(padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                        child: Row(children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2),
                            height: Dimensions.height20*4,
                            width: Dimensions.width20*4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/car1.jpg')
                                )
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2),
                            height: Dimensions.height20*4,
                            width: Dimensions.width20*4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/car1.jpg')
                                )
                            ),
                          ),
                        ],),),
                    ],
                  ),
               ),
                //sotuvchi javobi
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  
                    height: Dimensions.height20*7,
                  
                    color: Colors.white54,
                    child: Column(children: [
                      Padding(padding: EdgeInsets.all(Dimensions.height10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Sotuvchi javobi:'),
                          Text('4 yanvar 2024')
                      ],),),
                      Text('answer: xjkdkhfdshfdsjkfhsdjkfdsfdsdfdsfds '
                      'ddzfdsfdfdsn fdsfds fdsfd f  dsfdsfdsfdfd  fdsfdsfdsf '
                      'ddzfdsfdfdsn fdsfds fdsfd f  dsfdsfdsfdfd  fdsfdsfdsf '
                          'dsdfdsfdsfdsfdsfsdfdsf fsdfdsfdsf fdsfds', overflow: TextOverflow.fade,)
                    ],),
                  ),
                )
              ],
            ),
          );
        },

      ),
    );
  }
}
