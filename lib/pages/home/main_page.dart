import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuzk_mobile/pages/account/my_account.dart';
import 'package:yuzk_mobile/pages/auth/sign_in_page.dart';
import 'package:yuzk_mobile/pages/auth/sign_up_page.dart';
import 'package:yuzk_mobile/pages/cart/cart_page.dart';
import 'package:yuzk_mobile/pages/catalog/catalog.dart';
import 'package:yuzk_mobile/pages/home/main_home_page.dart';

import '../../enums/menu_items.dart';
import '../../utils/dimensions.dart';
import 'home_body_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex=0;
  List pages=[
    const MainHomePage(bodyWidget:  HomeBodyPage(),),
    const Catalogs(),
    const CartPage(),
    const MyAccount(),
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
showUnselectedLabels: false,
        currentIndex: _selectedIndex,

        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search),
              label: 'Catalog'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
              label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),
              label: 'My account'),
        ],

      ),
    );
  }
}
