import 'package:flutter/material.dart';
import 'package:yuzk_mobile/widgets/staff_item.dart';

import '../models/staff_model.dart';
import '../staff.dart';

class StaffList extends StatelessWidget {
  const StaffList({super.key, required this.staffList, required this.onRemoveStaff});
  final List<Staff> staffList;
  final void Function(Staff staff, int index) onRemoveStaff;
  @override
  Widget build(BuildContext context) {
    return staffList.isEmpty ?const Text('No Staff is exists'):ListView.builder(
        itemCount: staffList.length,
        itemBuilder: (ctx, index)=>Dismissible(
            key:ValueKey(staffList[index]),
            onDismissed: (direction){
              onRemoveStaff(staffList[index], index);

            },
            child: StaffItem(staffModel: staffList[index], index: index,)));
  }
}
