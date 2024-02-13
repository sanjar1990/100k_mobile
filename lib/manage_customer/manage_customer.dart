import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuzk_mobile/controller/user_controller.dart';
import 'package:yuzk_mobile/manage_customer/customer_item.dart';
import 'package:yuzk_mobile/manage_customer/search_customer.dart';
import 'package:yuzk_mobile/models/profile_filter_model.dart';
import 'package:yuzk_mobile/models/response_model.dart';
import '../../widgets/admin_drawer.dart';
import '../base/show_custom_snackbar.dart';
import '../pages/account/admin_account.dart';
import 'model/profile_pagination.dart';

class ManageCustomer extends StatefulWidget {
 const  ManageCustomer({super.key, });

  @override
  State<ManageCustomer> createState() => _ManageCustomerState();


}

class _ManageCustomerState extends State<ManageCustomer> {



  int currentPage = 1;
  ProfilePagination? profilePagination;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  List<Content>contentList = [];
   ProfileFilterModel? profile;
  void _getProfile(ProfileFilterModel profileIn){
    profile=profileIn;
    setState(() {

    });

  }
   Future<bool>  _searchProfile({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    ResponseModel responseModel = await Get.find<UserController>().searchFilter(
        profile!, currentPage);
    if (!responseModel.isError) {
      profilePagination = responseModel.data;
      if (isRefresh) {
        contentList = profilePagination!.content;
      } else {
        contentList.addAll(profilePagination!.content);
      }
      totalPages = profilePagination!.totalPages;
      currentPage++;
      setState(() {

      });
      return true;
    } else {
      return false;
    }
  }

  void _removeProfile(Content person, int index) {
    setState(() {

      Get.find<UserController>().removeProfile(person.email, index).then((status) {
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
                 contentList.insert(index, person);
                    Get.find<UserController>().resetProfile(person,index);
                  });

                }),
          ));
        }
      });
    });


  }



  @override
  Widget build(BuildContext context) {
    Widget content=SearchCustomer(onSearchProfile: _getProfile);
    if(profile!=null){
      content=SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: ()async{
          final result=await _searchProfile(isRefresh:true);
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }
        },
        onLoading: ()async{
          final result=await _searchProfile();
          if(result){
            refreshController.loadComplete();
          }else{
            refreshController.loadFailed();
          }
        },

        child:  ListView.separated(
            itemCount: contentList.length,
            separatorBuilder: (context, builder)=>const Divider(),
            itemBuilder: (context, index){
              final profile=contentList[index];
              return  Dismissible(
                  key:ValueKey(contentList[index]),
                  onDismissed: (direction){

                   _removeProfile(profile, index);
                    contentList.removeAt(index);
                  },
                  child: CustomerItem(customer: profile, index: index));

            }),
          // CustomerList(customerList:contentList, onRemoveCustomer: _removeStaff ,)
      );
    }
    return Scaffold(
        drawer:  const AdminDrawer(onSelectScreen: AdminAccount.setScreen,),
      appBar: AppBar(
        title: const Text('Customer Management'),
        actions: [
          IconButton(onPressed: (){

            setState(() {
              content=SearchCustomer(onSearchProfile: _getProfile);
              profile=null;
            });

          },
              icon: const Icon(Icons.search))
        ],
      ),
      body: content
    );
  }
}
