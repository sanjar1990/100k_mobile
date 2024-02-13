import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';

class AppInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const AppInfo({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: Dimensions.width45*2,
      height: Dimensions.height20*8,
      child: Column(children: [
        Icon(icon,size: Dimensions.icon24,),
        Container(

          child: Text(title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.black, fontWeight: FontWeight.bold,
          ),),
        ),
        Text(description,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black45),)
      ],),
    );
  }
}
