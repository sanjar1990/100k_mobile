import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuzk_mobile/enums/menu_items.dart';
import 'package:yuzk_mobile/pages/home/home_body_page.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';

class MainHomePage extends StatefulWidget {
  final Widget bodyWidget;
  const MainHomePage({super.key, required this.bodyWidget});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary.withRed(222),
        leadingWidth: Dimensions.height20*6,
        leading: TextButton(onPressed: (){},
          child: Container(
            height: Dimensions.height20*10,
            width: Dimensions.height20*10,
            child: Image.asset('assets/images/100k.png',color: Colors.white,),),),
        actions: [

          DropdownButton(
              underline: Text(''),
              icon:  Container(
                  padding: EdgeInsets.only(right: Dimensions.width10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person, color: Colors.white,),
                      Padding(

                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text('MENU'),
                      ),
                      const Icon(Icons.arrow_drop_down_outlined, color: Colors.white,),
                    ],
                  )),
              items: MenuItemsEnum.values.map((value) =>  DropdownMenuItem(
                value: value,

                child:   Container(
                  child:  Row(
                    children: [

                      Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2),
                        child:  Text( value.name.toUpperCase(), style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color:Theme.of(context).primaryColor
                        ),),
                      ),


                    ],
                  ),
                ),)).toList(),

              onChanged: <String>(value){

              })
        ],
      ),
      body: widget.bodyWidget ,
    );
  }
}
