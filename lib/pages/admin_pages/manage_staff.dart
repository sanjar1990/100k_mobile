import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:yuzk_mobile/base/show_custom_snackbar.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/widgets/new_staff.dart';
import 'package:yuzk_mobile/widgets/staff_list.dart';
import '../../routes/route_helper.dart';
import '../../staff.dart';
import '../../widgets/admin_drawer.dart';
import '../account/admin_account.dart';

class ManageStaff extends StatefulWidget {
  const ManageStaff({super.key});

  @override
  State<ManageStaff> createState() => _ManageStaffState();
}

class _ManageStaffState extends State<ManageStaff> {

void _openAddStaffOverlay(){
    showModalBottomSheet(
        context: context,
    backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    isScrollControlled: true,
        useSafeArea: true,
        builder: (ctx){
      return const NewStaff();
        });
  }
void _removeStaff(Staff staff, int index){
    setState(()  {

    Get.find<UserController>().removeProfile(staff.email, index).then((status) {
      if(status.isError){
        showCustomSnackBar(message: status.message);
      }else{
        ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('Staff is deleted'),
      duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'Undo',
            onPressed: (){
          setState(() {
            Get.find<UserController>().resetStaff(staff,index);
          });

            }),
      ));
      }
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  const AdminDrawer(onSelectScreen: AdminAccount.setScreen,),
      appBar: AppBar(
        title: const Text('Staff Management'),
        actions: [
          IconButton(onPressed: _openAddStaffOverlay,
              icon: const Icon(Icons.add))
        ],
      ),
      body: GetBuilder<UserController>(builder: (userController)  {
        if(!userController.isStaffExists()){
          userController.loadStaffList();
        }
        return Column(

          children: [
            Expanded(child: StaffList(staffList: userController.getStaffList(),
              onRemoveStaff: _removeStaff,))
          ],
        );
      },)
    );
  }
}
