import 'package:flutter/material.dart';
import 'package:yuzk_mobile/manage_customer/customer_item.dart';
import 'package:yuzk_mobile/manage_customer/model/profile_pagination.dart';
import 'package:yuzk_mobile/widgets/staff_item.dart';
import '../person.dart';
import '../staff.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key, required this.customerList, required this.onRemoveCustomer});
    final List<Content> customerList;
  final void Function(Content person, int index) onRemoveCustomer;
  @override
  Widget build(BuildContext context) {
    return customerList.isEmpty ?const Text('No Staff is exists'):ListView.builder(
        itemCount: customerList.length,
        itemBuilder: (ctx, index)=>Dismissible(
            key:ValueKey(customerList[index]),
            onDismissed: (direction){
              onRemoveCustomer(customerList[index], index);

            },
            child: CustomerItem(customer: customerList[index], index: index,)));
  }
}
