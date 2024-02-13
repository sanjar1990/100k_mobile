import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/pages/home/main_page.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/utils/dimensions.dart';
class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key, required this.onSelectScreen});
  final void Function (String identifier) onSelectScreen;
  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
bool _visible_profile=false;
bool _visible_products=false;
bool _visible_attach=false;
bool _visible_comments=false;
bool _visible_customer=false;
bool _visible_email=false;
bool _visible_admin=false;
bool _visible_category=false;
void _setVisibleProfile(){
  setState(() {
    _visible_profile=!_visible_profile;
  });
}
void _setVisibleProducts(){
  setState(() {
    _visible_products=!_visible_products;
  });
}
void _setVisibleAttach(){
  setState(() {
    _visible_attach=!_visible_attach;
  });
}
void _setVisibleComments(){
  setState(() {
    _visible_comments=!_visible_comments;
  });
}
void _setVisibleCustomer(){
  setState(() {
    _visible_customer=!_visible_customer;
  });
}
void _setVisibleEmail(){
  setState(() {
    _visible_email=!_visible_email;
  });
}
void _setVisibleAdmin(){
  setState(() {
    _visible_admin=!_visible_admin;
  });
}
void _setVisibleCategory(){
  setState(() {
    _visible_category=!_visible_category;
  });
}
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(
        padding: EdgeInsets.only(bottom: Dimensions.height20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                  padding: EdgeInsets.only(top:Dimensions.height20*2,left:Dimensions.height20,
                  right: Dimensions.height20
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft
                    )
                  ),
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shopping_cart,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,),
                          SizedBox(width: Dimensions.width20,),
                          Text('100K Admin ',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary
                          ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(

                            alignment: Alignment.bottomLeft,
                            child: TextButton.icon(
                              label: Text('Main page'),
                              icon:Icon(Icons.exit_to_app), onPressed: () {
                              Get.toNamed(RouteHelper.getInitial());
                            } ,
                            ),
                          ),
                          Container(

                            alignment: Alignment.bottomRight,
                            child: TextButton.icon(
                              label: Text('Log out'),
                              icon:Icon(Icons.exit_to_app), onPressed: () {
                              Get.find<UserController>().logoutAdmin();
                              Get.offAll(const MainPage());
                            } ,
                            ),
                          )
                        ],
                      ),

                    ],
                  )),
              // Staff
              ListTile(title: Text('Manage Profile',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: Dimensions.font26
              ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                  color: Theme.of(context).colorScheme.onBackground ,),
              onTap: _setVisibleProfile,
              ),
              // DrawerListTile(title: 'Manage Products', icon: Icons.shopping_cart, isVisible:_visible ,),
              Visibility(
                  visible: _visible_profile,
                  child: Column(

                    children:  [
                    ListTile(title: Text('Manage staff', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,size: Dimensions.icon16,
                    color: Theme.of(context).colorScheme.primary,),
                    onTap: (){
                      widget.onSelectScreen('manage_staff');
                    },
                    ),
                      ListTile(title: Text('Manage Customer', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,size: Dimensions.icon16,
                          color: Theme.of(context).colorScheme.primary,),
                        onTap: (){
                          widget.onSelectScreen('manage_customer');
                        },
                      ),
                    ],
                  )),
              // Category
              ListTile(title: Text('Manage Category',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleCategory,
              ),
              Visibility(
                  visible: _visible_category,
                  child: Column(

                    children:  [
                      ListTile(title: Text('Manage Category', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,size: Dimensions.icon16,
                          color: Theme.of(context).colorScheme.primary,),
                        onTap: (){
                          widget.onSelectScreen('manage_category');
                        },
                      ),
                    ],
                  )),
              //
              ListTile(title: Text('Manage Products',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleProducts,
              ),
            Visibility(
                visible: _visible_products,
                child: Column(
                  children: [

                  ],
                )),
              ListTile(title: Text('Manage attach',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleAttach,
              ),
              Visibility(
                  visible: _visible_attach,
                  child: Text('')),
              ListTile(title: Text('Manage comments',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleComments,
              ),
              Visibility(
                  visible: _visible_comments,
                  child: Text('')),
              ListTile(title: Text('Manage customer',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleCustomer,
              ),
              Visibility(
                  visible: _visible_customer,
                  child: Text('')),
              ListTile(title: Text('Manage email',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleEmail,
              ),
              Visibility(
                  visible: _visible_email,
                  child: Text('')),
              ListTile(title: Text('Manage admin',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: Dimensions.font26
                ),), trailing: Icon(Icons.arrow_drop_down_circle_outlined, size: 26,
                color: Theme.of(context).colorScheme.onBackground ,),
                onTap: _setVisibleAdmin,
              ),
              Visibility(
                  visible: _visible_admin,
                  child: Text('')),


            ],

          ),
        ),
      ),
    );
  }
}
