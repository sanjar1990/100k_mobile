import 'package:flutter/material.dart';
import 'package:yuzk_mobile/models/staff_model.dart';
import 'package:yuzk_mobile/widgets/update_staff.dart';

import '../staff.dart';
import '../utils/dimensions.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();
class StaffItem extends StatelessWidget {
  final Staff staffModel;
  final int index;
  const StaffItem({super.key, required this.staffModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: Dimensions.width15,
          vertical: Dimensions.height20
        ),
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                      padding: EdgeInsets.only(left: Dimensions.width30*4),
                    child:     CircleAvatar(
                      backgroundImage: NetworkImage(staffModel.attachUrl,),
                      radius: Dimensions.radius20*3,
                    ),
                  ),
                 PopupMenuButton<String>(
                      onSelected: (value){
                        if(value=='Update account'){
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (ctx){
                                return  UpdateStaff(staff:staffModel , index: index,);
                              });
                        }

                      },
                      itemBuilder: (BuildContext context) {
                        return { 'Update account'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    )
                ],
              ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Icon(Icons.person),
                      Text('name:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black45,
                        fontSize: Dimensions.font16
                      ),),
                    ],
                  ),
                  Text(staffModel.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontSize: Dimensions.font20
                    ),
                  // textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height10,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                       Icon(Icons.email),
                        Text('email:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black45,
                            fontSize: Dimensions.font16,
                          overflow: TextOverflow.ellipsis
                        ),),
                      ],
                    ),
                    Text(staffModel.email,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: Dimensions.font20
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                       Icon(Icons.phone),
                        Text('phone:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black45,
                            fontSize: Dimensions.font16
                        ),),
                      ],
                    ),
                    Text(staffModel.phone,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: Dimensions.font20
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text('birthdate:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black45,
                            fontSize: Dimensions.font16
                        ),),
                      ],
                    ),
                    Text(formatter.format(staffModel.birthDate),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: Dimensions.font20
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],),
        ),
      ),
    );
  }
}
