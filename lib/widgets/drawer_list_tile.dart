import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
   bool isVisible;
   DrawerListTile({super.key, required this.title, required this.icon, this.isVisible=false});

  @override
  Widget build(BuildContext context) {
    return  ListTile(title: Text(title,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: Dimensions.font26
      ),), trailing: Icon(icon, size: 26,
      color: Theme.of(context).colorScheme.onBackground ,),
      onTap: (){
      isVisible=!isVisible;
      }

    );
  }
}
