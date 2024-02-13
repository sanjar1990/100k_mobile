import 'package:flutter/material.dart';
import 'package:yuzk_mobile/widgets/search_text_field.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(
          top: Dimensions.height20,
          right: Dimensions.width20,
          left: Dimensions.width20),
      child: Row(
        children: [
          Container(
            width: Dimensions.width30 * 10,
            height: Dimensions.height20 * 3,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.lightGrey),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius30),
                bottomLeft: Radius.circular(Dimensions.radius30),
              ),
            ),
            child: SearchTextField()
          ),

          Expanded(
            child: Container(
              width: Dimensions.width45*2,
              height: Dimensions.height20 * 3,
              decoration: BoxDecoration(

                color: Theme.of(context).colorScheme.onPrimary.withRed(222),
                border: Border.all(width: 1, color: Theme.of(context).colorScheme.onPrimary.withRed(222)),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius30),
                  bottomRight: Radius.circular(Dimensions.radius30),
                ),
              ),
              child: Icon(Icons.search,size: Dimensions.icon16*2,
                color: Colors.white,),
            ),
          ),

        ],
      ),
    );
  }
}
