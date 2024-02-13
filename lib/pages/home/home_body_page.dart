import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yuzk_mobile/utils/colors.dart';
import 'package:yuzk_mobile/widgets/categories_widget.dart';
import 'package:yuzk_mobile/widgets/comfortable.dart';
import 'package:yuzk_mobile/widgets/search_widget.dart';

import '../../utils/dimensions.dart';
import '../../widgets/products_widget.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({super.key});

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  @override
  Widget build(BuildContext context) {
    return

        SingleChildScrollView(
          child: Column(
                   children: [
                    SearchWidget(),
               CategoriesWidget(),
                     ProductWidget(title: 'New products',),
                     const ProductWidget(title: 'Popular products',),
                   SizedBox(height: Dimensions.height20,),
                   Comfortable(),

                   ],
                 ),
        );



  }
}
