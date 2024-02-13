import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/widgets/admin_drawer.dart';

class AdminAccount extends StatelessWidget {
  const AdminAccount({super.key});

 static void setScreen(String identifier){
    if(identifier=='manage_staff'){
      Get.offAndToNamed(RouteHelper.getManageStaff());
    }else if(identifier=='manage_customer'){
      Get.offAndToNamed(RouteHelper.getManageCustomer());
    }else if(identifier=='manage_category'){
      Get.offAndToNamed(RouteHelper.getManageCategory());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color:  Colors.white
      ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,),

    // body: GetBuilder<AdminController>(builder: (adminController) {
    //   return const Center(
    //     child: Text('Admin Dashboard'),
    //   );
    // },),
      body: Center(child: Text('Admin Dashboard'),),
      drawer:  AdminDrawer(onSelectScreen: setScreen,),
    );
  }
}
