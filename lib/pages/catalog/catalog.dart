import 'package:flutter/material.dart';
import 'package:yuzk_mobile/widgets/search_widget.dart';

import '../../utils/dimensions.dart';
import '../../widgets/product_short_detail.dart';

class Catalogs extends StatefulWidget {
  const Catalogs({super.key});

  @override
  State<Catalogs> createState() => _CatalogsState();
}

class _CatalogsState extends State<Catalogs> {
  var _selectedIndex=0;
  List<String> catalogList = [
    'all',
    'vitaminlar',
    'aksesuarlar',
    'kremlar',
    'elektronika',
    'quloqchinlar',
    'aqqili soatlar',
    'navigatorlar',
    'audiotexnika',
    'telefonlar',
    'telefon aksesuarlari',
    'oshxona buyumlari'
  ];
  void _setIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchWidget(),
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.height20),
              height: Dimensions.height20 * 5,
              width: double.maxFinite,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catalogList.length,
                  itemBuilder: (ctx, index) {


                    return TextButton(

                      onPressed: () {
                        _setIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 200,
                        width: Dimensions.height20 * 7,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            border: Border.all(width: 1, color: Colors.red)),
                        child: Text(
                          catalogList[index],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black, fontSize: Dimensions.font20),
                        ),
                      ),
                    );
                  }),
            ),

            Padding(
              padding:  EdgeInsets.only(left: Dimensions.height20),
              child: Text(catalogList[_selectedIndex].toUpperCase(),
                style: TextStyle(fontSize: Dimensions.font20, color: Theme.of(context).colorScheme.onPrimary),),
            ),

            const ProductShortDetail(),
          ],
        ),
      ),
    );
  }
}
