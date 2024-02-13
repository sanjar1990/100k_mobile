import 'package:flutter/material.dart';
import 'package:yuzk_mobile/pages/home/main_home_page.dart';
import 'package:yuzk_mobile/widgets/search_widget.dart';

import '../../utils/dimensions.dart';
import '../../widgets/comments_widget.dart';

class ProductFullDetail extends StatefulWidget {
  const ProductFullDetail({super.key});

  @override
  State<ProductFullDetail> createState() => _ProductFullDetailState();
}

class _ProductFullDetailState extends State<ProductFullDetail> {
  var descriptionColor;
  var commentsColor=Color.fromARGB(255, 255, 255, 255);
  bool _isDescription=true;
  void _setDescription(){
    _isDescription=true;

      descriptionColor=Theme.of(context).colorScheme.onSurface;

    commentsColor=Color.fromARGB(255, 255, 255, 255);

  }
  void _setComment(){
    _isDescription=false;
      commentsColor=Theme.of(context).colorScheme.onSurface;
    descriptionColor=Color.fromARGB(255, 255, 255, 255);
    }


  Widget setBodyContent(){
    if(_isDescription){

      return Container(
        height: 300,

        padding: EdgeInsets.all(Dimensions.height15),
        width: double.maxFinite,
        child: Text("🔆Tik tokda mashxur bo'lgan 360° gradusda yuradigan aqli mashinamiz  keldi "
   " Aqli mashinamiz qulaylikalari"

   " 🔰 Mashina batarekada ishlaydi xar kuni 2 3 soatdan zaryatga qo'yib qo'yishingiz shart"

   " 🔰Maxsus qo'lga toqiladigan sensor remishogi orqali boshqarsangiz xam buladi."

  "   🔰 Pult orqali boshqarsangizxam bo'ladi. "

   " 🔰 Ajoyib dezayn"

    "🔆Maxsulot soni cheklangan shoshiling azizlar"),
      );
    }else {
      return CommentsWidget();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MainHomePage(bodyWidget: SingleChildScrollView(
      child: Column(
        children: [
          const SearchWidget(),
          SizedBox(height: Dimensions.height15,),
          Container(
            color: Theme.of(context).colorScheme.onSurface,
            padding: EdgeInsets.only(top: Dimensions.height30,

            ),
            // color: Theme.of(context).colorScheme.onBackground,
            child: Column(
              children: [
                Padding(
                  padding:EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '100.000 so\'m',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                fontSize: Dimensions.font16
                            ),
                          ),
                          SizedBox(height: Dimensions.height10,),
                          const Row(children: [
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),
                            Icon(Icons.star,color:Color.fromARGB(255, 255, 173, 0),),

                          ],)
                        ],
                      ),
                      ElevatedButton(onPressed: (){

                      },
                          child: Text('Add to cart'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).colorScheme.onPrimary.withRed(222),),
                        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white)
                        )),


                    ],
                  ),
                ),

                Text(
                  'Smart Car Mashina',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black),
                ),
               Container(

                 width: double.maxFinite,
               height: 350,
               decoration: const BoxDecoration(

                 image: DecorationImage(
                   fit: BoxFit.cover,
                   image: AssetImage('assets/images/p2.png')
                 )
               ),
               ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: Dimensions.height45,
                        width: Dimensions.screenWidth/2-12,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                        decoration: BoxDecoration(
                          color: descriptionColor,
                        border: Border(
                            top:BorderSide(color: Colors.black38,width: 1),
                            right:BorderSide(color: Colors.black38,width: 1),
                            left:BorderSide(color: Colors.black38,width: 1),
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius15),
                              topRight: Radius.circular(Dimensions.radius15) ),
                          // color: Colors.white
                        ),
                        child: TextButton(onPressed: (){

                          setState(() {
                            _setDescription();
                          });
                        },

                            child:   Text('Description',
                              style: TextStyle(color: Colors.black, fontSize: Dimensions.font20),)),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: Dimensions.height45,
                        width: Dimensions.screenWidth/2-12,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                        decoration: BoxDecoration(
                          color: commentsColor,
                          border: Border(
                            top:BorderSide(color: Colors.black38,width: 1),
                            right:BorderSide(color: Colors.black38,width: 1),
                            left:BorderSide(color: Colors.black38,width: 1),
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius15),
                              topRight: Radius.circular(Dimensions.radius15) ),
                          // color: Colors.white
                        ),
                        child: TextButton(onPressed: (){
                          setState(() {
                            _setComment();
                          });
                        },

                            child:   Text('Xaridorlar fikri',
                              style: TextStyle(color: Colors.black, fontSize: Dimensions.font20),)),
                      ),

                    ],
                  ),
                ),
                setBodyContent(),

              ],
            ),
          ),

        ],
      ),
    ));
  }
}
