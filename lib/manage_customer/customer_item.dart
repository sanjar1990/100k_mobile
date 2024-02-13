import 'package:flutter/material.dart';
import 'package:yuzk_mobile/manage_customer/model/profile_pagination.dart';
import 'package:yuzk_mobile/manage_customer/update_customer.dart';
import '../enums/gender_enum.dart';
import '../utils/dimensions.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();
class CustomerItem extends StatelessWidget {
  final Content customer;
  final int index;
  const CustomerItem({super.key, required this.customer, required this.index});

  @override
  Widget build(BuildContext context) {
    print(customer);
    String address='';
    if(customer.address.trim().isNotEmpty){
      address=customer.address.split('#')[2];
    }
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
                      backgroundImage: NetworkImage(customer.attachUrl,),
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
                              return  UpdateCustomer(person:customer , index: index,);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        Text(customer.name,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontSize: Dimensions.font20
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
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
                        Text(customer.email,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontSize: Dimensions.font20
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              SizedBox(height: Dimensions.height10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        Text(customer.phone,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontSize: Dimensions.font20
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
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
                        Text(formatter.format(customer.birthDate),
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



              SizedBox(height: Dimensions.height10,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

             Padding(
               padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Row(
                     children: [
                       customer.gender.toLowerCase()==Gender.male.toString()
                           ?const Icon(Icons.male):
                       const Icon(Icons.female),
                       Text('Gender:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                           color: Colors.black45,
                           fontSize: Dimensions.font16
                       ),),
                     ],
                   ),
                   Text(customer.gender.isNotEmpty?customer.gender.toString():'N\\A',
                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
                         color: Colors.black,
                         fontSize: Dimensions.font20
                     ),
                     // textAlign: TextAlign.center,
                   ),
                 ],
               ),
             ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Row(
                     children: [

                       const Icon(Icons.cases_rounded),
                       Text('Role:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                           color: Colors.black45,
                           fontSize: Dimensions.font16
                       ),),
                     ],
                   ),
                   Text(customer.role,
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
              SizedBox(height: Dimensions.height10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            const Icon(Icons.account_box),
                            Text('Status:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black45,
                                fontSize: Dimensions.font16
                            ),),
                          ],
                        ),
                        Text(customer.status,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontSize: Dimensions.font20
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                             Icon( customer.visible?Icons.visibility:Icons.visibility_off),
                            Text('Visible:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.black45,
                                fontSize: Dimensions.font16
                            ),),
                          ],
                        ),
                        Text(customer.visible.toString(),
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
              SizedBox(height: Dimensions.height10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        const Icon(Icons.location_on),
                        Text('Address:', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black45,
                            fontSize: Dimensions.font16
                        ),),
                      ],
                    ),

                    Text(address,
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
